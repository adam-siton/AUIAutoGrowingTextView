AUIAutoGrowingTextView
======================

A very simple implementation of an auto growing UITextView Using Auto Layout.

To use, change the class of your auto layout UITextView in Interface builder to AUIAutoGrowingTextView - and you're done.

You can also set min and max height in code by using:

	self.textView.minHeight = 65;
    self.textView.maxHeight = 90;