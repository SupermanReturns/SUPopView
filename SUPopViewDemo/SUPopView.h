//
//  SUPopView.h
//  SUPopViewDemo
//
//  Created by Superman on 2018/8/2.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SUPopView;
@protocol SUPopViewDelegate <NSObject>
@optional
- (void)cancelAction;
- (void)sureAction;


@end
@interface SUPopView : UIView

@property (nonatomic, weak) id<SUPopViewDelegate> delegate;

@property(nonatomic,copy)NSString *strUID;
+ (SUPopView *)popViewConfirmBtnTitle:(NSString *)confirmTitle cancleBtnTitle:(NSString *)cancleTitle;
/**
 *  展示在哪个视图上
 */
- (void)showInView:(UIView *)view;
@end
