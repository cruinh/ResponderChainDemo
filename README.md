# ResponderChainDemo
Example of how to use the iOS responder chain in Swift to let a UITableViewCell communicate with the UIViewController it is contained in.

In this example project, a table view contains a single table view cell.  The table view cell, in turn, contains a button labeled "Test".  When the "Test" button is tapped, a message is sent through the app's responder chain.  The message is sent such that any class implementing the protocol "TitleTableViewCellActionHandler" will have it's "updateTitleForCell" function called.  The view controller is set up to implement this protocol and when "updateTitleForCell" is called, it will set it's nav title to "Test".
