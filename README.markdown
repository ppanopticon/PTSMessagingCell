PTSMessagingCell
================

The PTSMessagingCell class provides the basic functionalities of a messaging cell as used in the iOS Messaging App or WhatsApp.

## Author
Ralph Gasser (pontius software GmbH)

## Requirements
* Only implemented to work with ARC (Automated Reference Counting)

## Legal
Copyright 2012 by pontius software GmbH (Switzerland), All rights reserved

The code and its documentation are provided free of charge under the terms of the Creative Commons BY-SA 3.0 license. 

You are allowed to use this class for any of your projects (be it commercial or open source). If you do so, you are invited to give credits to the author Ralph Gasser (pontius software GmbH, Switzerland). 
If you alter the class and/or improve upon it, you are kindly asked to share your work under the same terms.

## Description
The PTSMessagingCell class provides the basic functionalities of a messaging cell as used in the iOS messaging app or WhatsApp. It can be used like a normal UITableView cell, where you can set all the properties in the method:

`- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath`

See the demo project for an example how to use the class.

The class was tested in an application, using data that was fetched from a persistent store with Core Data. So lots of data and long message texts should not be problem. 

IMPORTANT: The sizing of the cells is handled in the data sources (UITableViewDataSource method): 

`-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath`

This is not very elegant but I did not come up with a better solution yet.

The class should be working on the iPhone (3.3 inch & 4inch) and iPad (although I only really tested the iPhones) and with all interface-orientations.

## To-Do's
* Implementation for Retain/Release environments.
* Find a better solution for dynamic sizing.
* Tweaking.