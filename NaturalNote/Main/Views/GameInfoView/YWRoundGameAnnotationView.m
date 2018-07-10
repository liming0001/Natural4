//
//  YWRoundAnnotationView.m
//  YWLJMapView
//
//  Created by NeiQuan on 16/7/27.
//  Copyright © 2016年 Mr-yuwei. All rights reserved.
//

#import "YWRoundGameAnnotationView.h"
#import "GameResponse.h"

@interface YWRoundGameAnnotationView(){
    
    UIView           *_contentView;
    UIImageView      *_bgImg;
    UIImageView      *_annotationImg;
}

@end
@implementation YWRoundGameAnnotationView

- (void)dealloc{
    _contentView = nil;
    _bgImg = nil;
    _annotationImg = nil;
}

-(instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        [self setBounds:CGRectMake(0, 0, 60, 60)];
        [self initWithContentViews];//
    }
    
    return self;
}
-(void)initWithContentViews{
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 52, 67)];
    [view setBackgroundColor:[ UIColor  clearColor]];
    _contentView=view;
    [self addSubview:view];
    
    UIImageView *Img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 52, 67)];
    _bgImg = Img;
    [_contentView addSubview:Img];
    
    UIImageView *annotationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 11, 35, 35)];
    annotationImageView.layer.masksToBounds = YES;
    annotationImageView.layer.cornerRadius = 8;
    _annotationImg = annotationImageView;
    [_contentView addSubview:annotationImageView];
    
}

- (void)showInfoWithPointInfo:(GameResponse *)game{
    _gameSource = game;
    if ([_gameSource.gameStatus isEqualToString:@"CREATED"]) {
        _bgImg.image = [UIImage imageNamed:@"game_created"];
    }else if ([_gameSource.gameStatus isEqualToString:@"PLAYING"]){
        _bgImg.image = [UIImage imageNamed:@"game_playing"];
    }else if ([_gameSource.gameStatus isEqualToString:@"PLAYED"]){
        _bgImg.image = [UIImage imageNamed:@"game_played"];
    }
    [_annotationImg sd_setImageWithURL:[NSURL URLWithString:_gameSource.gameImageUrl] placeholderImage:[UIImage imageNamed:@"pic_loading_v"]];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    return inside;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [ super setSelected:selected animated:animated];

}

@end

