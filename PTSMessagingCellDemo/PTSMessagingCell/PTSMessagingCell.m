//
//  PTSMessagingCell.m
//  Purplemoon
//
//  Created by Ralph Gasser on 08.08.11.
//  Copyright 2011 pontius software GmbH. All rights reserved.
//

#import "PTSMessagingCell.h"

static CGFloat textMarginHorizontal = 12.0f;
static CGFloat textMarginVertical = 5.0f;

static UIImage * bubbleSelectedRightImage;
static UIImage * bubbleReadRightImage;
static UIImage * bubbleSelectedLeftImage;
static UIImage * bubbleReadLeftImage;

#pragma mark Private class body

/**Definition of private methods.*/
@implementation PTSMessagingCell (Private)

-(void)updateBackground {
    /**Returns the appropriate image, sepending on the sent and selected state.*/
    if ([self isSent]) {
        self.balloonView.image = bubbleReadRightImage;
    } else {
        self.balloonView.image = bubbleReadLeftImage;
    }
}

-(void)updateSelectedBackground {
    if ([self isSent]) {
        self.balloonView.image = bubbleSelectedRightImage;
    } else {
        self.balloonView.image = bubbleSelectedLeftImage;
    }
}

@end

#pragma mark -
#pragma mark Public class body

@implementation PTSMessagingCell
@synthesize sent, nameLabel, timestampLabel, messageLabel, avatarImageView, balloonView;

#pragma mark -
#pragma mark Static methods

+(void)load {
    /*Initializes the bubble images needed by the class.*/
    bubbleReadLeftImage = [[UIImage imageNamed:@"bubble_read_left"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 9.0f, 27.0f, 4.0f) resizingMode:UIImageResizingModeStretch];
    bubbleSelectedLeftImage = [[UIImage imageNamed:@"bubble_selected_left"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 9.0f, 27.0f, 4.0f) resizingMode:UIImageResizingModeStretch];
    bubbleReadRightImage = [[UIImage imageNamed:@"bubble_read_right"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 4.0f, 27.0f, 9.0f) resizingMode:UIImageResizingModeStretch];
    bubbleSelectedRightImage = [[UIImage imageNamed:@"bubble_selected_right"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 4.0f, 27.0f, 9.0f) resizingMode:UIImageResizingModeStretch];
}

#pragma mark -
#pragma mark Object-Lifecycle/Memory management

-(id)initMessagingCellWithReuseIdentifier:(NSString*)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        /*Selection-Style of the TableViewCell will be 'None' as it implements its own selection-style.*/
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /*Now the basic view-lements are initialized...*/
        balloonView = [[UIImageView alloc] initWithFrame:CGRectZero];
        messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timestampLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        avatarImageView = [[UIImageView alloc] initWithImage:nil];
        
        /*Setup rounded corners for avatarImageView.*/
        [avatarImageView.layer setCornerRadius:4.0f];
        [avatarImageView setClipsToBounds:YES];
       
        /*Message-Label Configuration*/
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.messageLabel.numberOfLines = 0;
        
        /*Configuration of the pre-existing labels*/
        [[self timestampLabel] setBackgroundColor:[UIColor clearColor]];
        [[self nameLabel] setBackgroundColor:[UIColor clearColor]];
        
        /*...and adds them to the view.*/
        [self.balloonView addSubview:[self nameLabel]];
        [self.balloonView addSubview:[self timestampLabel]];
        [self.balloonView addSubview:[self messageLabel]];
        [self.contentView addSubview:[self avatarImageView]];
        [self.contentView addSubview:[self balloonView]];
        
        /*Set cell background color to clear color (iOS7).*/
        [self setBackgroundColor:[UIColor clearColor]];
        
        /*Add gesture recognizer for long presses.*/
        UILongPressGestureRecognizer * recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [recognizer setMinimumPressDuration:1.0f];
        [self addGestureRecognizer:recognizer];
    }
    
    return self;
}

#pragma mark -
#pragma mark Layouting

-(void)layoutSubviews {
    /*Setup of the contantView.*/
    self.contentView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    CGFloat contentWidth = CGRectGetWidth(self.contentView.frame);
   
    /*Calculates the size of the message, the profile name and the timestamp. */
    CGSize textSize = [[[self messageLabel] text] boundingRectWithSize:CGSizeMake(contentWidth - 100.0f, CGFLOAT_MAX)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[[self messageLabel] font]} context:nil].size;
    
    CGSize dateSize = [[[self timestampLabel] text] boundingRectWithSize:CGSizeMake((contentWidth - 100.0f)/2, 20.0f)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[[self timestampLabel] font]} context:nil].size;
    
    CGSize nameSize = [[[self nameLabel] text] boundingRectWithSize:CGSizeMake((contentWidth - 100.0f)/2, 20.0f)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[[self nameLabel] font]} context:nil].size;
    
    /*Initializes the different frames , that need to be calculated.*/
    CGRect ballonViewFrame = CGRectZero;
    CGRect messageLabelFrame = CGRectZero;
    CGRect timeLabelFrame = CGRectZero;
    CGRect nameLabelFrame = CGRectZero;
    CGRect avatarImageFrame = CGRectZero;
    
    /*Makes a difference between a sent message and a received message.*/
    if (self.sent == YES) {
        avatarImageFrame = CGRectMake(contentWidth - 55.0f, 5.0f, 50.0f, 50.0f);
        
        ballonViewFrame = CGRectMake(5.0f, 5.0f, contentWidth - 60.0f, dateSize.height +textSize.height + 4*textMarginVertical);
        
        timeLabelFrame = CGRectMake(ballonViewFrame.size.width - dateSize.width - textMarginHorizontal, 5.0, dateSize.width, dateSize.height);
        
        nameLabelFrame = CGRectMake(textMarginHorizontal, 5.0f, nameSize.width, nameSize.height);
               
        messageLabelFrame = CGRectMake(textMarginHorizontal, 2*textMarginVertical + timeLabelFrame.size.height, textSize.width, textSize.height);
    } else {
        avatarImageFrame = CGRectMake(5.0f, 5.0f, 50.0f, 50.0f);
        
        ballonViewFrame = CGRectMake(contentWidth - (contentWidth - avatarImageFrame.size.width - 5.0f), 5.0f, contentWidth - 60.0f, dateSize.height + textSize.height + 4*textMarginVertical);
        
        timeLabelFrame = CGRectMake(ballonViewFrame.size.width - dateSize.width - textMarginHorizontal, 5.0, dateSize.width, dateSize.height);
        
        nameLabelFrame = CGRectMake(textMarginHorizontal, 5.0f, nameSize.width, nameSize.height);

        messageLabelFrame = CGRectMake(textMarginHorizontal, 2*textMarginVertical + timeLabelFrame.size.height, textSize.width, textSize.height);
    }
    
    /*Sets the pre-initialized frames  for the balloonView and messageView.*/
    self.balloonView.frame = ballonViewFrame;
    self.messageLabel.frame = messageLabelFrame;
    
    /*If shown (and loaded), sets the frame for the avatarImageView and it's border.*/
    self.avatarImageView.frame = avatarImageFrame;
    self.timestampLabel.frame = timeLabelFrame;
    self.nameLabel.frame = nameLabelFrame;
}

-(void)setSent:(BOOL)newValue {
    /*Applies the new value.*/
    sent = newValue;
    
    /*Updates the balloon image background.*/
    [self updateBackground];
}

#pragma mark -
#pragma mark UIGestureRecognizer-Handling

-(void)handleLongPress:(UILongPressGestureRecognizer *)longPressRecognizer {
    /*When a LongPress is recognized, the copy-menu will be displayed.*/
    if (longPressRecognizer.state == UIGestureRecognizerStateBegan) {
        [self updateSelectedBackground];
    } else {
        [self updateBackground];
    }
    
    if ([self becomeFirstResponder] == NO) {
        return;
    }
    
    /*Display UIMenuController.*/
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.balloonView.frame inView:self];
    [menu setMenuVisible:YES animated:YES];
}

-(BOOL)canBecomeFirstResponder {
    /*This cell can become first-responder*/
    return YES;
}


#pragma mark -
#pragma mark Action-Handler

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    /*Allows the copy-Action on this cell.*/
    if (action == @selector(copy:)) {
        return YES;
    } else {
        return [super canPerformAction:action withSender:sender];
    }
}

-(void)copy:(id)sender {
    /**Copys the messageString to the clipboard.*/
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.messageLabel.text];
}
@end


