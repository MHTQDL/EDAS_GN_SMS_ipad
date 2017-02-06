//
//  SiteListViewController.h
//
//  Created by guan mofeng on 12-1-12.
//  Copyright 2012 北京. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SiteListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate> {
	IBOutlet UISegmentedControl *btnSegment;
    IBOutlet UITableView *tableSite;//台站列表
    IBOutlet UITextField *txtAddress;//ip地址
    IBOutlet UITextField *txtChNum;//地震计数
    IBOutlet UITextField *txtName;//连接名
    IBOutlet UITextField *txtPassword;//密码
    IBOutlet UITextField *txtPort;//端口
    IBOutlet UITextField *txtUser;//用户名
	int selectPos;
	NSTimer * m_timer;
	UIAlertView *baseAlert;
	uint m_ret; //1-connect 2-close
	BOOL m_benable_connect; //1-enable connect button at initialize
	BOOL m_isconnected; //1-正处于连接状态
	float currConnetTime;
}
- (IBAction)btnOnClick:(id)sender;

-(void) addSite;//增加台站
-(void) editSite;//修改台站参数
-(void) deleteSite;//删除台站
-(void) connectSite;//连接台站
-(void) quitSite;//退出
-(BOOL) saveSiteinfo;//保存台站参数
-(BOOL) isValidator;//输入验证

@end
