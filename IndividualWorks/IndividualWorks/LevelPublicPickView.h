//
//  LevelPublicPickView.h
//  BasketballApp
//
//  Created by 陈黔 on 2016/11/11.
//  Copyright © 2016年 BlackChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LevelPublicPickViewDelegate <NSObject>
//按钮点击
@required
- (void)levelPickerButtonClick:(UIButton *)sender;

@optional

@end

@interface LevelPublicPickView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, assign) id <LevelPublicPickViewDelegate>delegate;

@property (nonatomic, copy) NSIndexPath *indexPath;

//列树
@property (nonatomic, assign) NSInteger component;

@property (strong,nonatomic)NSArray *dataArray;

/** 省 **/
@property (strong,nonatomic)NSArray *provinceList;
/** 市 **/
@property (strong,nonatomic)NSArray *cityList;
/** 区 **/
@property (strong,nonatomic)NSArray *areaList;
/** 第一级选中的下标 **/
@property (assign, nonatomic)NSInteger selectOneRow;
/** 第二级选中的下标 **/
@property (assign, nonatomic)NSInteger selectTwoRow;
/** 第三级选中的下标 **/
@property (assign, nonatomic)NSInteger selectThreeRow;

/** 省 **/
@property (copy,nonatomic)NSString *provinceString;
/** 市 **/
@property (copy,nonatomic)NSString *cityString;
/** 区 **/
@property (copy,nonatomic)NSString *areaString;

- (void)getAreaDate:(NSInteger)row;
- (void)getCitydate:(NSInteger)row;

//标题
@property (nonatomic, copy) UILabel *titlelabel;
//按钮数组
@property (nonatomic, strong) NSArray *btnArray;

//选择的字符串
@property (nonatomic, copy) NSString *selecetedString;
//选择的字符串数组
@property (nonatomic, strong) NSMutableArray *selecetedStringArray;


@end
