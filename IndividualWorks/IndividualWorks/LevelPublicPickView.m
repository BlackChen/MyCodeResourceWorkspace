//
//  LevelPublicPickView.m
//  BasketballApp
//
//  Created by 陈黔 on 2016/11/11.
//  Copyright © 2016年 BlackChen. All rights reserved.
//

#import "LevelPublicPickView.h"

@implementation LevelPublicPickView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        _selecetedStringArray = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
        [self creatPickerUI];

    }
    return self;
}

- (void)creatPickerUI{
    UIView *pickBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 80, 240 )];
    pickBGView.center = self.center;
    pickBGView.layer.cornerRadius = 15;
    pickBGView.clipsToBounds = YES;
    [self addSubview:pickBGView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDis:)];
    [self addGestureRecognizer:tap];
    
    _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 80, 39  )];
    _titlelabel.font = [UIFont systemFontOfSize:17];
    _titlelabel.textAlignment = NSTextAlignmentLeft ;
    _titlelabel.backgroundColor = [UIColor whiteColor];
    UILabel *lablebottom = [[UILabel alloc]initWithFrame:CGRectMake(0,39 , SCREEN_WIDTH - 80, 1)];
    lablebottom.backgroundColor = KColor(78, 132, 247);
    [pickBGView addSubview:lablebottom];
    [pickBGView addSubview:_titlelabel];
    
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 39   +1, SCREEN_WIDTH - 80, 160  )];
    picker.backgroundColor = [UIColor whiteColor];
    picker.delegate = self;
    picker.dataSource = self;
    //线
    for (int i = 0; i < 2; i ++) {
        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 32  * (2 + i), SCREEN_WIDTH - 80, 1)];
        lineImageView.backgroundColor = KColor(244, 244, 244);
        [picker addSubview:lineImageView];
    }
    [pickBGView addSubview:picker];
    
    _btnArray = @[@"取消", @"确定"];
    [_btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(idx * (SCREEN_WIDTH - 80)/_btnArray.count, 200  , (SCREEN_WIDTH - 80)/_btnArray.count, 40  );
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:KColor(78, 132, 247) forState:UIControlStateNormal];
        btn.tag = 10+idx;
        [btn setTitle:_btnArray[idx] forState:UIControlStateNormal];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.backgroundColor = [UIColor whiteColor];
        btn.clipsToBounds = YES;
        [pickBGView addSubview:btn];
    }];
}

- (void)getCitydate:(NSInteger)row{
    if ([self.provinceList[row][@"type"] intValue] == 0) {
        NSArray *cityArr = [[NSArray alloc] initWithObjects:self.provinceList[row], nil];
        self.cityList = cityArr;
    }else{
        NSMutableArray *cityList = [[NSMutableArray alloc] init];
        for (NSArray *cityArr in self.provinceList[row][@"sub"]) {
            [cityList addObject:cityArr];
        }
        self.cityList = cityList;
    }
}

- (void)getAreaDate:(NSInteger)row{
    if ([self.provinceList[self.selectOneRow][@"type"] intValue] == 0) {
        NSMutableArray *areaList = [[NSMutableArray alloc] init];
        for (NSArray *cityDict in self.provinceList[self.selectOneRow][@"sub"]) {
            [areaList addObject:cityDict];
        }
        self.areaList = areaList;
    }else{
        NSMutableArray *areaList = [[NSMutableArray alloc] init];
        for (NSArray *cityDict in self.cityList[row][@"sub"]) {
            [areaList addObject:cityDict];
        }
        self.areaList = areaList;
    }
}

#pragma mark ----UIPickerViewDataSource,UIPickerViewDelegate
//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

//行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    
    
    if (component == 0) {
        return self.provinceList.count;
    }else if (component == 1){
        return self.cityList.count;
    }else if (component == 2){
        return self.areaList.count;
    }
    return 0;
}

//高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 32  ;
}

//被选的行,替换
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    static NSInteger oneRow = 0;
    static NSInteger tweRow = 0;
    static NSInteger threeRow = 0;
    if (component == 0) {
        self.selectOneRow = row;
        [self getCitydate:row];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [self getAreaDate:0];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        if ([self.provinceList[self.selectOneRow][@"type"] intValue] == 0) {
            self.selectTwoRow = 0;
        }
        oneRow = row;
        tweRow = 0;
        threeRow = 0;
    }
    if (component == 1){
        self.selectTwoRow = row;
        [self getAreaDate:row];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        tweRow = row;
        threeRow = 0;
    }
    if (component == 2){
        self.selectThreeRow = row;
        threeRow = row;
    }
    NSMutableString *mstring = [[NSMutableString alloc] init];
    if (oneRow > 0 &&[self.provinceList[self.selectOneRow][@"type"] intValue] != 0 ) {
        [mstring appendFormat:@"%@省",self.provinceList[self.selectOneRow][@"name"]];
    }
    if (tweRow > 0 || [self.provinceList[self.selectOneRow][@"type"] intValue] == 0){
        [mstring appendFormat:@"%@市",self.cityList[self.selectTwoRow][@"name"]];
    }
    if (threeRow > 0 ){
        [mstring appendFormat:@"%@",self.areaList[self.selectThreeRow][@"name"]];
    }
    [self.selecetedStringArray replaceObjectAtIndex:component withObject:mstring];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    float width = (SCREEN_WIDTH - 80)/4;

    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 32  )];
    textLabel.font = [UIFont systemFontOfSize:17];
    //    textLabel.backgroundColor = [UIColor redColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    view = textLabel;
    view.centerX = (SCREEN_WIDTH - 80)/4*component;
    
    if (component == 0) {
        textLabel.text = self.provinceList[row][@"name"];
    }
    if (component == 1){
        if ([self.provinceList[self.selectOneRow][@"type"] intValue] == 0) {
            textLabel.text = self.cityList[0][@"name"];
        }else {
            textLabel.text = self.cityList[row][@"name"];
        }
    }
    if (component == 2){
        textLabel.text = self.areaList[row][@"name"];
    }
    

    return view;
}

- (void)tapDis:(UITapGestureRecognizer *)tap{
    [self removeFromSuperview];
}

#pragma mark ----确定取消的的点击
- (void)btnClick:(UIButton *)btn {
    
    NSLog(@"色还能份额阿森N卡就很啊1111:%@",_selecetedStringArray);

    
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(levelPickerButtonClick:)]) {
        [self.delegate levelPickerButtonClick:btn];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
