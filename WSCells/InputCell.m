//
//  InputCell.m
//  Halo
//
//  Created by Weishuai Han on 8/24/12.
//
//

#import "InputCell.h"

#define TITLE_WIDTH 100
#define C_TITLE         COLOR(0x0c4769FF)
#define C_SEPARATOR     COLOR(0x7c627cFF)
#define C_BORDER        COLOR(0x627c62FF)
#define C_VALUE         COLOR(0x575757FF)
#define C_FILL          COLOR(0x89a289ff)

@interface InputCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic) float margin;
@property (nonatomic) float cornerRadius;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *inputFieldFont;
@property (nonatomic) float titleHeight;
@property (nonatomic) float inputFieldHeight;
//@property (nonatomic) float radius;

@end

@implementation InputCell

@synthesize inputValue = _inputValue;
@synthesize borderColor = _borderColor, fillColor = _fillColor, separateLineColor = _separateLineColor;
@synthesize hasAccessoryView = _hasAccessoryView;
@synthesize editableText = _editableText;
@synthesize titleColor = _titleColor, valueColor = _valueColor;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_inputTextField];
        _titleWidth = TITLE_WIDTH;
        _inputKeyboardType = UIKeyboardTypeDefault;
        _secureTextEntry = NO;
        _fillColor = C_FILL;
        _margin = UI_MIDDLE_GAP;
        _cornerRadius = 10.0;
        _inputTextField.delegate = self;
        _delegate = nil;
        _titleFont = [UIFont boldSystemFontOfSize:FONT_MIDDLE];
        _inputFieldFont = [UIFont systemFontOfSize:FONT_SMALL];
        _numOfDigit = -1;
        _editableText = YES;
        _separateLineColor = C_SEPARATOR;
        _borderColor = C_BORDER;
        _titleColor = C_TITLE;
        _valueColor = C_VALUE;
        
        // calculate the height for different size
        _titleHeight = [_titleFont lineHeight];
        _inputFieldHeight = [_inputFieldFont lineHeight];
        _limitInputCharactersLength = -1;
        _hasAccessoryView = NO;
        _titleAlignment = NSTextAlignmentLeft;
        _inputFieldAlignment = NSTextAlignmentLeft;
        _currentValue = [NSString new];
    }
    return self;
}

- (UITextField*)inputField
{
    return _inputTextField;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(self.margin+UI_MIDDLE_GAP, (self.contentView.bounds.size.height-self.titleHeight)/2, self.titleWidth,self.titleHeight);
    self.titleLabel.font = self.titleFont;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = self.titleColor;
    self.titleLabel.textAlignment = self.titleAlignment;
    
    if (_hasAccessoryView) {
        UIImageView *accessory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        accessory.frame = CGRectMake(self.bounds.size.width - 2.5*UI_MIDDLE_GAP - accessory.bounds.size.width, (self.contentView.bounds.size.height-accessory.bounds.size.height)/2, accessory.bounds.size.width,accessory.bounds.size.height);
        [self.contentView addSubview:accessory];
        
        self.inputTextField.frame = CGRectMake(self.margin+UI_MIDDLE_GAP+UI_SMALL_GAP+self.titleWidth, (self.contentView.bounds.size.height-self.inputFieldHeight)/2, CGRectGetMinX(accessory.frame)-CGRectGetMaxX(self.titleLabel.frame)-UI_MIDDLE_GAP,self.inputFieldHeight);
    }else{
        self.inputTextField.frame = CGRectMake(self.margin+UI_MIDDLE_GAP+UI_SMALL_GAP+self.titleWidth, (self.contentView.bounds.size.height-self.inputFieldHeight)/2, self.contentView.bounds.size.width-2*UI_MIDDLE_GAP-self.titleWidth-self.margin*2-UI_SMALL_GAP,self.inputFieldHeight);
    }
    self.inputTextField.font = self.inputFieldFont;
    self.inputTextField.backgroundColor = [UIColor clearColor];
    self.inputTextField.textColor = self.valueColor;
    self.inputTextField.textAlignment = self.inputFieldAlignment;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSaveGState(c);
    CGContextSetFillColorWithColor(c, [self.fillColor CGColor]);
    CGContextSetStrokeColorWithColor(c, [self.borderColor CGColor]);
   
    switch (self.position) {
        case GroupCellPositionTop:
            CGContextMoveToPoint(c, self.margin, self.cornerRadius);
            CGContextAddArc(c, self.margin+self.cornerRadius, self.cornerRadius,self.cornerRadius, M_PI,M_PI+M_PI/2, 0);
            CGContextAddLineToPoint(c, rect.size.width-self.margin - self.cornerRadius, 0.0);
            CGContextAddArc(c, rect.size.width-self.margin-self.cornerRadius, self.cornerRadius, self.cornerRadius, M_PI+M_PI/2, M_PI*2, 0);
            CGContextAddLineToPoint(c, rect.size.width-self.margin, rect.size.height);
            CGContextAddLineToPoint(c, self.margin, rect.size.height);
            CGContextAddLineToPoint(c, self.margin, self.cornerRadius);
            CGContextDrawPath(c,kCGPathFillStroke);
            break;
        case GroupCellPositionBottom:
            CGContextMoveToPoint(c, self.margin, 0.0);
            CGContextAddLineToPoint(c, rect.size.width-self.margin, 0.0);
            CGContextAddLineToPoint(c, rect.size.width-self.margin, rect.size.height-self.cornerRadius);
            CGContextAddArc(c, rect.size.width-self.margin-self.cornerRadius, rect.size.height-self.cornerRadius, self.cornerRadius, 0.0, M_PI_2, 0);
            CGContextAddLineToPoint(c, self.margin+self.cornerRadius, rect.size.height);
            CGContextAddArc(c, self.cornerRadius+self.margin, rect.size.height-self.cornerRadius,self.cornerRadius ,M_PI_2, M_PI, 0);
            CGContextAddLineToPoint(c, self.margin, 0.0);
            CGContextDrawPath(c,kCGPathFillStroke);
            break;
        case GroupCellPositionMiddel:        
            CGContextAddRect(c, CGRectMake(self.margin, 0.0, rect.size.width-2*self.margin, rect.size.height));
            CGContextDrawPath(c,kCGPathFillStroke);
            break;
        case GroupCellPositionSingle:
            CGContextMoveToPoint(c, self.margin, self.cornerRadius);
            CGContextAddArc(c, self.margin+self.cornerRadius, self.cornerRadius,self.cornerRadius, M_PI,M_PI+M_PI/2, 0);
            CGContextAddLineToPoint(c, rect.size.width-self.margin - self.cornerRadius, 0.0);
            CGContextAddArc(c, rect.size.width-self.margin-self.cornerRadius, self.cornerRadius, self.cornerRadius, M_PI+M_PI/2, M_PI*2, 0);
            CGContextAddLineToPoint(c, rect.size.width-self.margin, rect.size.height-2*self.cornerRadius);
            CGContextAddArc(c, rect.size.width-self.margin-self.cornerRadius, rect.size.height-self.cornerRadius, self.cornerRadius, 0.0, M_PI_2, 0);
            CGContextAddLineToPoint(c, self.margin+self.cornerRadius, rect.size.height);
            CGContextAddArc(c, self.cornerRadius+self.margin, rect.size.height-self.cornerRadius,self.cornerRadius ,M_PI_2, M_PI, 0);
            CGContextAddLineToPoint(c, self.margin, self.cornerRadius);
            CGContextDrawPath(c,kCGPathFillStroke);
            break;
        default:
            break;
    }
    CGContextRestoreGState(c);
    // draw seperator line for the cell
    CGContextSaveGState(c);
    CGContextSetStrokeColorWithColor(c, [self.separateLineColor CGColor]);
    switch (self.position) {
        case GroupCellPositionTop:
            CGContextMoveToPoint(c, rect.size.width-self.margin-0.5f, rect.size.height);
            CGContextAddLineToPoint(c, self.margin+0.5f, rect.size.height);
            CGContextDrawPath(c,kCGPathStroke);
            break;
        case GroupCellPositionBottom:
            CGContextMoveToPoint(c, self.margin+0.5f, 0.0);
            CGContextAddLineToPoint(c, rect.size.width-self.margin-0.5f, 0.0);
            CGContextDrawPath(c,kCGPathStroke);
            break;
        case GroupCellPositionMiddel:
            CGContextMoveToPoint(c, self.margin+0.5f, 0.0);
            CGContextAddLineToPoint(c, rect.size.width-self.margin-0.5f, 0.0);
            CGContextMoveToPoint(c, self.margin+0.5f, rect.size.height);
            CGContextAddLineToPoint(c, rect.size.width-self.margin-0.5f, rect.size.height);
            CGContextDrawPath(c,kCGPathStroke);
            break;
        case GroupCellPositionSingle:
            break;
        default:
            break;
    }
    CGContextRestoreGState(c);
}

#pragma mark - 
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ((self.delegate) && ([self.delegate respondsToSelector:@selector(inputCell:shouldEndEditingWithFlag:)])) {
        [self.delegate inputCell:self shouldEndEditingWithFlag:self.flag];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ((self.delegate) && ([self.delegate respondsToSelector:@selector(inputCell:shouldBeginEditingWithFlag:)])) {
        [self.delegate inputCell:self shouldBeginEditingWithFlag:self.flag];
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ((self.delegate) && ([self.delegate respondsToSelector:@selector(inputCell:didBeginEditingWithFlag:)])) {
        [self.delegate inputCell:self didBeginEditingWithFlag:self.flag];
    }    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ((self.delegate) && ([self.delegate respondsToSelector:@selector(inputCell:didEndEditingWithFlag:)])) {
        [self.delegate inputCell:self didEndEditingWithFlag:self.flag];
    } 
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *currentStr;
    if ((range.length == 0 && string.length > 0) || (range.length > 0 && string.length > 0)) {
        // add the character to textfield
        NSString *firstHalfStr = [textField.text substringToIndex:range.location];
        NSString *lastHalfStr = [textField.text substringFromIndex:(range.location + range.length)];
        currentStr = [NSString stringWithFormat:@"%@%@%@",firstHalfStr,string,lastHalfStr];
    }else{
        // delete string from textfield
        NSString *firstHalfStr = [textField.text substringWithRange:NSMakeRange(0,range.location)];
        NSString *lastHalfStr = [textField.text substringFromIndex:(range.location+range.length)];
        currentStr = [NSString stringWithFormat:@"%@%@",firstHalfStr,lastHalfStr];
    }
    
    if (self.limitInputCharactersLength != -1 && currentStr.length > self.limitInputCharactersLength) {
        self.currentValue = textField.text;
        return NO;
    }
    
    // if numOfDigit>0, we need implement the currentStr as a number.
    if (self.numOfDigit > 0) {
        NSString* msg = [currentStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        int len = msg.length;
        NSRange tmpRange;
        tmpRange.location = 0;
        tmpRange.length = 1;
        NSString* tmp = nil;
        int commaCount = 0;
        for (int i = len - 1; i >= 0; i--) {
            tmpRange.location = i;
            tmp = [msg substringWithRange:tmpRange];
            if (([tmp isEqualToString:@","]) || ([tmp isEqualToString:@"."])){
                if ((len - 1 - i) > self.numOfDigit) {
                    if (string.length > 0) return NO;
                }
                commaCount ++;
            }
            if (commaCount>1) {
                return NO;
            }
        }
    }
    
    self.currentValue = currentStr;
    if ((self.delegate) && ([self.delegate respondsToSelector:@selector(inputCell:shouldChangeCharactersInRange: replacementString:)])) {
        return [self.delegate inputCell:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((self.delegate) && ([self.delegate respondsToSelector:@selector(inputCellShouldReturn:)])) {
        return [self.delegate inputCellShouldReturn:self];
    } else {
        return YES;
    }
}

#pragma mark - 
#pragma mark - Getting and Setting methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setTitleWidth:(float)titleWidth
{
    _titleWidth = titleWidth;
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setInputValue:(NSString *)inputValue
{
    _inputValue = inputValue;
    self.inputTextField.text = inputValue;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    self.inputTextField.placeholder = placeHolder;
}

- (NSString*)inputValue
{
    return self.inputTextField.text;
}

- (void)setInputKeyboardType:(UIKeyboardType)inputKeyboardType
{
    _inputKeyboardType = inputKeyboardType;
    self.inputTextField.keyboardType = inputKeyboardType;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    self.inputTextField.secureTextEntry = secureTextEntry;
}

- (void)setPosition:(GroupCellPosition)position
{
    _position = position;
    [self setNeedsDisplay];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self setNeedsDisplay];
}

- (UIColor*)borderColor
{
    return _borderColor;
}

- (void)setSeparateLineColor:(UIColor *)separateLineColor
{
    _separateLineColor = separateLineColor;
    [self setNeedsDisplay];
}

- (UIColor*)separateLineColor
{
    return  _separateLineColor;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (UIColor*)fillColor
{
    return _fillColor;
}

- (void)setHasAccessoryView:(BOOL)hasAccessoryView
{
    _hasAccessoryView = hasAccessoryView;
    [self setNeedsLayout];
}

- (BOOL)hasAccessoryView
{
    return _hasAccessoryView;
}

- (void)setEditableText:(BOOL)editableText
{
    _editableText = editableText;
    self.inputTextField.enabled = _editableText;
}

- (BOOL)editableText
{
    return _editableText;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self setNeedsLayout];
}

- (UIColor*)titleColor
{
    return _titleColor;
}

- (void)setValueColor:(UIColor *)valueColor
{
    _valueColor = valueColor;
    [self setNeedsLayout];
}

- (UIColor*)valueColor
{
    return _valueColor;
}

@end
