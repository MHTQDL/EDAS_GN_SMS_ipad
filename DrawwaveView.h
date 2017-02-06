//
//  DrawwaveView.h
//  EDAS_GN_SMS
//
//  Created by guan mofeng on 12-2-23.
//  Copyright 2012 北京. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CDSPCTL.h"
#define FONTSIZE 12.0f//字体大小
@interface DrawwaveView : UIView <UIActionSheetDelegate>{
	CDSPCTL * m_dspctl;//显示参数
	int m_real_time_status;//true-画实时波形
	CGRect m_rect;//屏幕显示尺寸（通道按钮＋时间码＋波形显示区）
	CGRect m_rectangle ;//波形显示区尺寸
	CGContextRef m_context;
	int m_xChar,m_yChar;//font size
	int m_origin_y;//toolbar heigh
	//true- 有新数据时，重画
	BOOL m_redraw_status;
	//TRUE-屏幕显示通道的显示幅度范围
	BOOL m_blabel;	
	BOOL  m_bclear;//TRUE-clear the screen ,FALSE- not clear
    //依次：网格，背景，波形颜色
	CGColorRef m_grid_color,m_bk_color,m_line_color;
	
	UIButton * m_stn_btn[13];//通道按钮
	int m_orient;//0-landscape,1-portraint
	
	UILabel * u_time_info;//数据时间显示
	UILabel * u_samp_info;//采样率显示信息
	UILabel * u_save_info;//存盘信息
	UIToolbar * u_statusbar;//状态栏信息
	
	
	
}
@property(nonatomic,retain) UIToolbar * u_statusbar;
@property(nonatomic,retain) IBOutlet UILabel *u_samp_info;
@property(nonatomic,retain) IBOutlet UILabel * u_save_info;
@property(nonatomic, retain) IBOutlet UILabel *u_time_info;
@property(nonatomic, retain)  CDSPCTL *  m_dspctl;//display parameters
@property  int  m_real_time_status;//true-show realtime wave
@property CGRect m_rect;//screen size
@property CGRect m_rectangle ;//drawwave rectange
//@property CGContextRef m_context;
@property BOOL m_bclear;
@property BOOL m_redraw_status;
@property int m_origin_y;
@property int m_orient;
//建立状态栏
-(void) CreateStatusbar;
//获得波形数据最大，最小值，data： 波形数据
-(void) GetDataRange: (long *) data;
//启动／停止显示波形 bview=1 启动显示波形，初始化参数 ， 0－不显示
-(void)OnRunView: (int)bview;
//初始化m_dspctl
-(void) InitDsp;
//绘制背景，网格等
-(void) init_draw;
//初始化m_rect,m_rectangle,rect： 框架的尺寸 
-(void) InitSize : (CGRect )rect;
-(void) setContextRef: (CGContextRef) context;
//计算通道显示尺寸
-(void)CalChannelRange;
//计算波形显示坐标 pin: 波形数据 l: 通道序号
-(void) dsp_data: (long *)pin : (int)l;
//擦除部分区域
//-(void) clear_eara: (CGRect *)rect: (int)posi : (int)step;
//画波形
-(void)  DrawWave;
//重画
-(void)ReDraw;
//复位CHANNEL中position,data_cnt,max_posi,cnt
-(void) ResetPos;
//计算波形坐标，统计最大，最小值，获得u_time_info，start：波形起始通道序号 chn_sum：通道总数 
-(void) OnData: (int)start : (int)chn_sum;
//显示文本 x: 坐标 y: 坐标 labels: 文本
-(void) Showlabel : (int)x : (int)y : (NSString *) labels;
//建立通道按钮 l：屏幕中通道序号 y：按钮中心位置坐标 title：按钮显示的文本
-(void) CreateStnButton  :(int)l : (int)y : (NSString *) title;

-(void) OnViewUp;

-(void) OnViewDown;

-(void) OnViewCenter;

-(void) OnScantime;
@end
