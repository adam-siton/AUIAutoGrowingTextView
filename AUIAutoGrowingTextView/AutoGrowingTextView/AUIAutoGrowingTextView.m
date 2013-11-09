//
//  AUIAutoGrowingTextView.m
//
//  Created by Adam on 10/10/13.
//

#import "AUIAutoGrowingTextView.h"

@interface AUIAutoGrowingTextView()

@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *maxHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *minHeightConstraint;

@end

@implementation AUIAutoGrowingTextView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void) awakeFromNib
{
    [self commonInit];    
}

-(void) commonInit
{
    // If we are using auto layouts, than get a handler to the height constraint.
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            self.heightConstraint = constraint;
            break;
        }
    }    
    if (!self.heightConstraint) {
        // TODO: We might use auto layouts but set the height of the textView by using a top + bottom constraints. In this case we would want to manually create a height constraint    
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if (self.heightConstraint) {
        [self handleLayoutWithAutoLayouts];
    }
    else {
        [self handleLayoutWithoutAutoLayouts];
    }
    
    // Center vertically
    // We're  supposed to have a maximum height contstarint in code for the text view which will makes the intrinsicSide eventually higher then the height of the text view - if we had enough text.
    // This code only center vertically the text view while the context size is smaller/equal to the text view frame.
    if (self.intrinsicContentSize.height <= self.bounds.size.height) {
        CGFloat topCorrect = (self.bounds.size.height - self.contentSize.height * [self zoomScale])/2.0;
        topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
        self.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    }
}

-(void) handleLayoutWithAutoLayouts
{
    CGSize intrinsicSize = self.intrinsicContentSize;
    if (self.minHeight) {
        intrinsicSize.height = MAX(intrinsicSize.height, self.minHeight);
    }
    if (self.maxHeight) {
        intrinsicSize.height = MIN(intrinsicSize.height, self.maxHeight);
    }
    self.heightConstraint.constant = intrinsicSize.height;
}

-(void) handleLayoutWithoutAutoLayouts
{
    // TODO:
}

- (CGSize)intrinsicContentSize
{
    CGSize intrinsicContentSize = self.contentSize;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        intrinsicContentSize.width += (self.textContainerInset.left + self.textContainerInset.right ) / 2.0f;
        intrinsicContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom) / 2.0f;
    }
    
    return intrinsicContentSize;
}


@end
