//
//  SUPopView.m
//  SUPopViewDemo
//
//  Created by Superman on 2018/8/2.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "SUPopView.h"
#import "UIView+Addition.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define PRESENTATION_ANIMATION_DURATION 0.5
#define DISMISS_ANIMATION_DURATION 0.5

#define ScreenScale ([UIScreen mainScreen].bounds.size.width / 414.f)

@interface SUPopView()
@property (nonatomic, weak) UIImageView *containerView;

@end
@implementation SUPopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    
    return self;
}
+ (SUPopView *)popViewConfirmBtnTitle:(NSString *)confirmTitle cancleBtnTitle:(NSString *)cancleTitle {
    return [[self alloc] initWithConfirmBtnTitle:confirmTitle cancleBtnTitle:cancleTitle];
}


- (SUPopView *)initWithConfirmBtnTitle:(NSString *)confirmTitle cancleBtnTitle:(NSString *)cancleTitle {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        // 弹出框后面的背景视图
        UIView *shawdowView = [[UIView alloc] initWithFrame:self.bounds];
        shawdowView.backgroundColor  = [UIColor blackColor];
        shawdowView.alpha = 0.6;
        [self addSubview:shawdowView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCloseBtn)];
        [shawdowView addGestureRecognizer:tap];
        
        // 承载容器的视图
        UIImageView *containerView = [[UIImageView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT*0.2, SCREEN_WIDTH-60, SCREEN_HEIGHT*0.4)];
        containerView.userInteractionEnabled = YES;
        containerView.layer.cornerRadius = 5.0f;
        containerView.clipsToBounds = YES;
                containerView.backgroundColor=[UIColor greenColor];
        [self addSubview:containerView];
        _containerView = containerView;
        
        
        UIImageView *topImaBack=[[UIImageView alloc]init];
        topImaBack.frame=CGRectMake(50*ScreenScale,20*ScreenScale ,containerView.width-100*ScreenScale ,40*ScreenScale );
//        topImaBack.image=[UIImage imageNamed:@"yqmysc"];
        [_containerView addSubview:topImaBack];
        
        UILabel *titLabel=[[UILabel alloc]init];
        titLabel.frame=CGRectMake(60*ScreenScale,0 , topImaBack.width-60*ScreenScale, 40*ScreenScale);
        titLabel.font=[UIFont systemFontOfSize:19*ScreenScale];
        titLabel.textColor=[UIColor whiteColor];
        titLabel.text=@"你的邀请码已生成";
        [topImaBack addSubview:titLabel];
        
        UILabel *inviLabel=[[UILabel alloc]init];
        inviLabel.frame=CGRectMake(40*ScreenScale, topImaBack.bottom,containerView.width-80*ScreenScale , 40*ScreenScale);
        
        //        NSString *inviText=@"264826985";
        NSString *inviText=@"副标题副标题副标题副标题标题标题标题标题标题标题标题";
        NSDictionary *dicLine = @{NSKernAttributeName:@3.5f};
        NSMutableAttributedString  *inviString = [[NSMutableAttributedString alloc] initWithString:inviText attributes:dicLine];
        NSMutableParagraphStyle  *paragraphStyle0 = [[NSMutableParagraphStyle alloc] init];
        
        [inviString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle0 range:NSMakeRange(0, [inviText length])];
        // 设置Label要显示的text
        [inviLabel  setAttributedText:inviString];
        inviLabel.textAlignment=NSTextAlignmentCenter;
        
        inviLabel.font=[UIFont systemFontOfSize:21*ScreenScale];
        inviLabel.textColor=[UIColor whiteColor];
        [_containerView addSubview:inviLabel];
        
        
        UIButton *dismissBtn=[[UIButton alloc]init];
        dismissBtn.frame=CGRectMake(containerView.width-40*ScreenScale,10,25*ScreenScale,25*ScreenScale);
        [dismissBtn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [dismissBtn setBackgroundColor:[UIColor redColor]];
        [dismissBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:dismissBtn];
        
        
        UIImageView *operateImage=[[UIImageView alloc]init];
        operateImage.frame=CGRectMake(40*ScreenScale, inviLabel.bottom+30*ScreenScale,containerView.width-80*ScreenScale ,100*ScreenScale );
        operateImage.image=[UIImage imageNamed:@"explain_bg"];
        [_containerView addSubview:operateImage];
        
        UILabel *explainLabel=[[UILabel alloc]init];
        explainLabel.numberOfLines=3;
        explainLabel.textColor=[UIColor cyanColor];
        
        //
        NSString *s= @"标题标题标题标题标题标题标题标题";
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle  setLineSpacing:8*ScreenScale];
        NSDictionary *dic = @{NSKernAttributeName:@2.5f};


        NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:s attributes:dic];
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [s length])];
        // 设置Label要显示的text
        [explainLabel  setAttributedText:setString];
        explainLabel.textAlignment=NSTextAlignmentCenter;
        explainLabel.frame=CGRectMake(0, 0, operateImage.width-10, 100*ScreenScale);
        [operateImage addSubview:explainLabel];
        
        
        // 确认按钮
        UIButton *sureBtn = [UIButton new];
        sureBtn.frame = CGRectMake(30*ScreenScale, operateImage.bottom+10*ScreenScale, containerView.width/2-50*ScreenScale, 40*ScreenScale);
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"paste_button"] forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:[UIColor yellowColor]];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:17.0*ScreenScale];
        sureBtn.layer.cornerRadius = 5.0f;
        [sureBtn setTitle:confirmTitle forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_containerView addSubview:sureBtn];
        [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 取消按钮
        UIButton *cancelBtn = [UIButton new];
        cancelBtn.frame = CGRectMake(sureBtn.right+40*ScreenScale, operateImage.bottom+10*ScreenScale, containerView.width/2-50*ScreenScale, 40*ScreenScale);
        [cancelBtn setBackgroundColor:[UIColor yellowColor]];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.0*ScreenScale];
        cancelBtn.layer.cornerRadius = 5.0f;
        [cancelBtn setTitle:cancleTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_containerView addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// 点击右上角关闭按钮,弹出框消失
- (void)clickCloseBtn {
    [self dismiss];
}

-(void)cancelClick{
    if ([self.delegate respondsToSelector:@selector(cancelAction)]) {
        [self.delegate cancelAction];
    }
    [self dismiss];
}
// 点击确定按钮，执行代理方法,弹出框消失
- (void)sureClick {
    if ([self.delegate respondsToSelector:@selector(sureAction)]) {
        [self.delegate sureAction];
    }
    [self dismiss];
}

- (void)showInView:(UIView *)view {
    
    _containerView.alpha = 0;
    [view addSubview:self];
    
    _containerView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:PRESENTATION_ANIMATION_DURATION
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _containerView.alpha = 1.0f;
                         _containerView.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)dismiss {
    [UIView animateWithDuration:DISMISS_ANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         _containerView.alpha = 0.0;
                         self.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                         
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
