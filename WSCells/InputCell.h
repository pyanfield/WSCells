//
//  InputCell.h
//  Halo
//
//  Created by Weishuai Han on 8/24/12.
//
//

#import <UIKit/UIKit.h>

typedef enum GroupCellPosition{
    GroupCellPositionSingle,
    GroupCellPositionTop,
    GroupCellPositionBottom,
    GroupCellPositionMiddel
}GroupCellPosition;

@protocol InputCellDelegate;

@interface InputCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *inputValue;
@property (nonatomic) float titleWidth;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic) UIKeyboardType inputKeyboardType;
@property (nonatomic) BOOL secureTextEntry;

@property (nonatomic) GroupCellPosition position;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *separateLineColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *valueColor;

@property (nonatomic, weak)   id <InputCellDelegate>   delegate;
@property (nonatomic) int flag;
@property (nonatomic) int numOfDigit;
@property (nonatomic) int limitInputCharactersLength;
@property (nonatomic) BOOL hasAccessoryView;
@property (nonatomic) BOOL editableText;
@property (nonatomic) UITextAlignment titleAlignment;
@property (nonatomic) UITextAlignment inputFieldAlignment;
// currentValue maybe can be replaced by inputValue, need test more.
@property (nonatomic, strong) NSString *currentValue;
@property (nonatomic, readonly) UITextField *inputField;

@end

@protocol InputCellDelegate <NSObject>

@optional
- (void)inputCell:(InputCell*)inputCell shouldEndEditingWithFlag:(int)flag;
- (void)inputCell:(InputCell*)inputCell shouldBeginEditingWithFlag:(int)flag;
- (void)inputCell:(InputCell*)inputCell didBeginEditingWithFlag:(int)flag;
- (void)inputCell:(InputCell*)inputCell didEndEditingWithFlag:(int)flag;
- (BOOL)inputCellShouldReturn:(InputCell*)inputCell;
- (BOOL)inputCell:(InputCell*)inputCell shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end