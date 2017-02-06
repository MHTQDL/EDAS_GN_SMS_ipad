//
//  RootViewController.h
//
//  Created by guan mofeng on 11-12-9.
//  Copyright 2011 北京. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SetDsp1ViewController.h"
#import "ModalViewController.h"
#import "QueryMenuViewController.h"
#import "RunMenuViewController.h"
#import "SetMenuViewController.h"
//#import "DrawrtwaveViewController.h"
#import "QueryinfoViewController.h"
#import "DrawwaveView.h"



static DrawwaveView *uU_drawview;


@interface RootViewController : UIViewController<UIAlertViewDelegate> {
	
	RunMenuViewController *runMenuViewController;
	SetMenuViewController *setMenuViewController;
	QueryMenuViewController *queryMenuViewController;
	ModalViewController *modalViewController;
	//	DrawrtwaveViewController *drawwaveViewController;
	QueryinfoViewController * queryinfoViewController;
	DrawwaveView * u_drawview;//屏幕显示：波形，通道按钮，时间尺，网格
	UILabel * u_cal_info;//calibration information
	
	SetDsp1ViewController *setDsp1ViewContoller;
	
}


@property(nonatomic,retain) IBOutlet UILabel * u_cal_info;
@property (nonatomic, retain) SetMenuViewController *setMenuViewController;
@property (nonatomic, retain) QueryMenuViewController *queryMenuViewController;
@property (nonatomic, retain) RunMenuViewController *runMenuViewController;
@property (nonatomic, retain) ModalViewController *modalViewController;
@property (nonatomic, retain) SetDsp1ViewController *setDsp1ViewContoller;
@property (nonatomic,retain) QueryinfoViewController *queryinfoViewController;
@property (nonatomic,retain) DrawwaveView * u_drawview;

//+(DrawwaveView) gu_drawview;//draw lines and timespan

-(IBAction) OnScantime: (id)sender;//改变显示时间
-(IBAction) OnViewUp: (id)sender;//放大波形幅度
-(IBAction) OnViewDown: (id)sender;//缩小波形幅度
-(IBAction) OnViewCenter: (id)sender;//波形居中
-(void) alertView: (UIAlertView *)alertView clickedButtonAtIndex: (int) index;
-(void) ontimer_display: (NSTimer *)timer; //响应定时显示新的波形帧和信息帧
-(void) ontimer_savedata:(NSTimer *)timer; //响应存盘定时
-(void) ontimer_checkcon:(NSTimer *)timer; //响应检查网络连接定时
-(void) DisplayData;//定时显示新的波形帧和信息帧
//根据标定标志确定标定类型，保存到calistr  , cali_flag：标定标志 local_id： 地震计序号
-(void) ShowCaliflag: (int) cali_flag : (int) local_id : (char *) calist;
-(void) OnMessage;//处理接收的信息帧
-(void) OnCloseCon;//关闭连接

-(void) settimer;
-(void) ontimer_processcon: (NSTimer *)timer;//响应网络连接定时

-(void) showDsp1ViewController :(NSString *) labetext;

+ (RootViewController*) U_RootViewController;

+ (DrawwaveView*) U_drawview;

@end

