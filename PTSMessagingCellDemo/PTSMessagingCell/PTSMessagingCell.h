//
//  PTSMessagingCell.h
//  Purplemoon
//
//  *View*
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/** @class PTSMessagingCell
    @brief This class extends a UITableViewCell with a style similar to that of the SMS-App (iOS). It displays a TextMessage of any size (only limited by the capabilities of UIView), a timestamp (if given) and an Avatar-Image (if given). 
 
    The cell will properly respond to orientation-changes and can be displayed on iPhones and iPads. The usage of this class is very simple: Initialize it, using the initMessagingCellWithReuseIdentifier:(NSString*)reuseIdentifier-Method and afterwards set its properties, as you would with a commom UITabelViewCell.
 
    The class also implements behaviour regarding gesture recognizers and Copy/Paste. The PTSMessagingCells are selectable and its content can be copied to the clipboard.
 
    @author Ralph Gasser
    @date 2014-09-24
    @version 1.8.1
    @copyright Copyright 2014, pontius software GmbH
 */


@interface PTSMessagingCell : UITableViewCell {
    /*This is a private subview of the MessagingCell, containing the ballon-graphic. It is not intended to be editable.*/
    @private UIImageView * balloonView;
    
    @private UILabel * nameLabel;
    
    @private UILabel * timestampLabel;
    
    /*Subview of the ballonView, containing the actual message (if specified). It can be set in the cellForRowAtIndexPath:-Method.*/
    @private UILabel * messageLabel;
    
    /*Subview of the ballonView, containing the Avatar-Image (if specified). It can be set in the cellForRowAtIndexPath:-Method.*/
    @private UIImageView * avatarImageView;
    
    /*Specifies, if the message of the current cell was received or sent. This influences the way, the cell is rendered.*/
    @private BOOL sent;
}

@property (nonatomic, readonly) UIImageView * balloonView;

@property (nonatomic, readonly) UILabel * nameLabel;

@property (nonatomic, readonly) UILabel * timestampLabel;

@property (nonatomic, readonly) UILabel * messageLabel;

@property (nonatomic, readonly) UIImageView * avatarImageView;

@property (nonatomic, getter = isSent) BOOL sent;

/**Initializes the PTSMessagingCell.
    @param reuseIdentifier NSString* containing a reuse Identifier.
    @return Instanze of the initialized PTSMessagingCell. 
*/
-(id)initMessagingCellWithReuseIdentifier:(NSString*)reuseIdentifier;

@end

