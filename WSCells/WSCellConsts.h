//
//  WSCellConsts.h
//  WSCellsDemo
//
//  Created by guo gloria on 13-4-17.
//  Copyright (c) 2013年 wshan. All rights reserved.
//

#ifndef WSCellsDemo_WSCellConsts_h
#define WSCellsDemo_WSCellConsts_h

//layout
#define UI_TINY_GAP     2
#define UI_SMALL_GAP    5
#define UI_MIDDLE_GAP   9
#define UI_BIG_GAP      15
#define UI_LARGE_GAP    20
#define UI_HUGE_GAP     30
#define UI_SCREEN_HEIGHT    ([[UIScreen mainScreen] bounds].size.height)
#define UI_SCREEN_WIDTH     ([[UIScreen mainScreen] bounds].size.width)
#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_STATUS_BAR_HEIGHT            20
#define UI_KEYBOARD_HEIGHT              216

//font
#define FONT_TINY   12
#define FONT_SMALL  14
#define FONT_MIDDLE 17
#define FONT_LARGE  20
#define FONT_HUGE   23

//color
#define COLOR(c)[UIColor colorWithRed:((c>>24)&0xFF)/255.0      \
                                green:((c>>16)&0xFF)/255.0      \
                                 blue:((c>>8)&0xFF)/255.0       \
                                alpha:((c)&0xFF)/255.0]

#define C_CLEAR         [UIColor clearColor];

//size
#define S_SHADOW_OFFSET CGSizeMake(0.0,1.0)

#endif
