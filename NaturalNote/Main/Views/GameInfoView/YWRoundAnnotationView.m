//
//  YWRoundAnnotationView.m
//  YWLJMapView
//
//  Created by NeiQuan on 16/7/27.
//  Copyright © 2016年 Mr-yuwei. All rights reserved.
//

#import "YWRoundAnnotationView.h"
#import "PointResponse.h"
#define kWidth  150.f
#define kHeight 60.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   200.0
#define kCalloutHeight  70.0
@interface YWRoundAnnotationView(){
    
    UILabel          *_countLable;
    UIView           *_contentView;
    NSString         *_typeString;
    CAShapeLayer     *_rlayer;
    UIImageView      *_starImg;
    UIView           *_centerV;
}

@end
@implementation YWRoundAnnotationView

- (void)dealloc{
    _countLable = nil;
    _contentView = nil;
    _starImg = nil;
    _centerV = nil;
}

-(instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        [self setBounds:CGRectMake(0, 0, 50, 50)];
        [self initWithContentViews];//
    }
    
    return self;
}
-(void)initWithContentViews{
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [view setBackgroundColor:[ UIColor  clearColor]];
    _contentView=view;
    [self addSubview:view];
    
    CAShapeLayer *layer=[ CAShapeLayer layer];
    layer.frame=view.frame;
    layer.path=[ UIBezierPath bezierPathWithRoundedRect:view.frame cornerRadius:25].CGPath;
    layer.fillColor = [UIColor colorWithHexRGB:0xB7DB74 alpha:1].CGColor;
    _rlayer = layer;
    [view.layer addSublayer:layer];
    layer.lineWidth=0.3f;
    layer.strokeColor=[ UIColor grayColor].CGColor;
    
    _centerV=[[UIView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [_centerV setBackgroundColor:[UIColor colorWithHexRGB:0xffffff alpha:1]];
    _centerV.layer.cornerRadius = 20;
    [_contentView addSubview:_centerV];
    
    UIImageView *Img = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, 23, 23)];
    Img.image = [UIImage imageNamed:@"star9"];
    Img.hidden = YES;
    _starImg = Img;
    [_centerV addSubview:Img];
    
    UILabel *countlable=[[ UILabel alloc] initWithFrame:CGRectMake(0,15, 50, 20)];
    countlable.textAlignment=NSTextAlignmentCenter;
    countlable.textColor = [UIColor colorWithHexRGB:0xB7DB74 alpha:1];
    countlable.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
    _countLable=countlable;
    [_contentView addSubview:countlable];
}

- (void)showInfoWithPointInfo:(PointResponse *)point{
    _pointSource = point;
    if (point.isZLPK==1) {
        if (point.isSelected) {
            _centerV.backgroundColor = [UIColor colorWithHexRGB:0x858585 alpha:1];
        }else{
            _centerV.backgroundColor = [UIColor colorWithHexRGB:0xffffff alpha:1];
        }
        if (point.isZhanling) {
            _rlayer.fillColor = [UIColor colorWithHexString:_pointSource.groupColor].CGColor;
        }else{
            _rlayer.fillColor = [UIColor colorWithHexRGB:0xB7DB74 alpha:1].CGColor;
        }
        if (point.isZhanling) {
            _starImg.hidden = YES;
            _countLable.hidden = NO;
            _countLable.text=_pointSource.groupCode;
            _countLable.textColor = [UIColor colorWithHexString:_pointSource.groupColor];
        }else{
            _countLable.hidden = YES;
            _starImg.hidden = NO;
            _countLable.textColor = [UIColor colorWithHexRGB:0xB7DB74 alpha:1];
        }
        
    }else{
        _starImg.hidden = YES;
        _countLable.hidden = NO;
        if (point.isZLPK==4) {
            if ([_pointSource.isEndPoint isEqualToString:@"Y"]) {
                _countLable.text= @"?";
            }else{
                _countLable.text=_pointSource.gameOrder;
            }
        }else{
            _countLable.text=_pointSource.gameOrder;
        }
        if (point.isSelected) {
            _centerV.backgroundColor = [UIColor colorWithHexRGB:0x858585 alpha:1];
        }else{
            _centerV.backgroundColor = [UIColor colorWithHexRGB:0xffffff alpha:1];
            
        }
        if (point.isFinished) {
            _rlayer.fillColor = [UIColor colorWithHexRGB:0x00bfd8 alpha:1].CGColor;
        }else{
            _rlayer.fillColor = [UIColor colorWithHexRGB:0x23cd77 alpha:1].CGColor;
        }
        if (point.isFinished) {
            _countLable.textColor = [UIColor colorWithHexRGB:0x00bfd8 alpha:1];
        }else{
            _countLable.textColor = [UIColor colorWithHexRGB:0x23cd77 alpha:1];
        }
    }
    
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    return inside;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    NSLog(@"jinru333444444");
    [ super setSelected:selected animated:animated];

}

@end


@interface YWRectAnnotationView()
{
    UILabel                     *_titleLable;
    UIView                      *_contentView;
}
@end
@implementation YWRectAnnotationView

- (void)dealloc{
    _titleLable = nil;
    _contentView = nil;
}

-(instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        [self initMakeSubViews];
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)initMakeSubViews{
  //需要根据字数的长度计算宽度
    
    UIView *contentView=[[ UIView alloc] init];
    [contentView setBackgroundColor:[ UIColor clearColor]];
    _contentView=contentView;
    
    UILabel *lable=[[ UILabel alloc] init];
    lable.textColor=[ UIColor whiteColor];
    lable.font=[ UIFont systemFontOfSize:13];
    _titleLable=lable;
    [contentView addSubview:lable];
    [self addSubview:contentView];
    
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    
    return inside;
}
-(void)setTitleText:(NSString *)titleText{
    
    _titleLable.text=titleText;
    //计算高度
    CGFloat Width = [titleText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:0 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize: 13]} context:nil].size.width;
    [_contentView setFrame:CGRectMake(0, 0, Width+30, 30)];
    [_titleLable setFrame:CGRectMake(15,5, Width, 22)];

    CGRect rect = _contentView.bounds;
    //创建Path
    CGMutablePathRef layerpath = CGPathCreateMutable();
    CGPathMoveToPoint(layerpath, NULL, 0, 0);
    CGPathAddLineToPoint(layerpath, NULL, CGRectGetMaxX(rect), 0);
    CGPathAddLineToPoint(layerpath, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGPathAddLineToPoint(layerpath, NULL, 45, CGRectGetMaxY(rect));
    CGPathAddLineToPoint(layerpath, NULL, 37.5, CGRectGetMaxY(rect)+5);
    CGPathAddLineToPoint(layerpath, NULL, 30, CGRectGetMaxY(rect));
    CGPathAddLineToPoint(layerpath, NULL, 0, CGRectGetMaxY(rect));
    
    CAShapeLayer *shapelayer=[CAShapeLayer  layer];
    UIBezierPath *path=[ UIBezierPath  bezierPathWithCGPath:layerpath];
    shapelayer.path=path.CGPath;
    shapelayer.fillColor=[ UIColor colorWithRed:83/255.0 green:180/255.0 blue:119/255.0 alpha:1.0].CGColor;
    shapelayer.cornerRadius=5;
    [_contentView.layer addSublayer:shapelayer];
    [_contentView bringSubviewToFront:_titleLable];
    self.bounds=_contentView.bounds;

    //销毁Path
    CGPathRelease(layerpath);
    
    [ self layoutIfNeeded];
    [self setNeedsDisplay];
}
-(void)layoutSubviews{
    
    [ super layoutSubviews];
}

@end
