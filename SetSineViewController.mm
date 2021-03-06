//
//  SetSineViewController.m
//  正弦标定
//  Created by guan mofeng on 12-3-30.
//  Copyright 2012 北京. All rights reserved.
//

#import "SetSineViewController.h"
#include "GlobalData.h"
#define NUMBERSINT @"0123456789\n"
#define NUMBERSFLOAT @"-0123456789.\n"

extern char sens_id[];
extern SINES m_sine[];

@implementation SetSineViewController


- (void) initUI {
	
	int i = 0;
	char temp[100];
	NSMutableArray *comboSensData = [NSMutableArray array];
	for(i=0;i<siteDoc.m_das.stnpar.sens_num;i++)
	{
		sprintf(temp,"地震计 %c",  sens_id[i]);
		[comboSensData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	if(siteDoc.m_das.stnpar.sens_num != 0) {
		[cmboSens setItems:comboSensData];
		[self comboBox:cmboSens selectItemAtIndex:0];
		//[comboSensData release];
	}
	
	
	
	
}
- (void) initUI1: (NSInteger)m_sensid
{
	//int m_sensid = [cmboSens getSelectIndex];
	char temp[1024];
	[ckBTimer setChecked:siteDoc.m_das.sens[m_sensid].sines.btimer];
	
	//sprintf(temp,"%d", siteDoc.m_das.sens[m_sensid].pulse.amp);
	//txtAmp.text = [[NSString alloc]initWithUTF8String : temp];
	//[cmboAmpType setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.amptype]; 
	
	//m_type=m_das->sens[m_sensid].pulse.amptype;
	//m_dur=m_das->sens[m_sensid].pulse.dur/10.f;
	
	//sprintf(temp,"%f", siteDoc.m_das.sens[m_sensid].pulse.dur/10.f);
	//txtDur.text = [[NSString alloc]initWithUTF8String : temp];
	
	//m_tm_method=m_das->sens[m_sensid].pulse.method;
	[cmbMethod setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.method];
	
	if(siteDoc.m_das.sens[m_sensid].sines.method==0)
	{
		[cmboHour setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start1];
		[cmboMin setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start2];
		labDay.text = @"日：";
		//m_tm_hr=m_das->sens[m_sensid].pulse.tm_start1;
		//m_tm_min=m_das->sens[m_sensid].pulse.tm_start2;
		//m_static_date.LoadString(IDS_TMLABEL1); "日：
		
	}else if(siteDoc.m_das.sens[m_sensid].sines.method==1)
	{
		
		[cmboDay setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start1 - 1];
		[cmboHour setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start2];
		[cmboMin setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start3];
		labDay.text = @"星期：";
		//m_tm_date=m_das->sens[m_sensid].pulse.tm_start1-1;
		//m_tm_hr=m_das->sens[m_sensid].pulse.tm_start2;
		//m_tm_min=m_das->sens[m_sensid].pulse.tm_start3;
		//m_static_date.LoadString(IDS_TMLABEL2); //"星期："
	}else if(siteDoc.m_das.sens[m_sensid].sines.method==2){
		
		[cmboDay setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start1 - 1];
		[cmboHour setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start2];
		[cmboMin setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start3];
		labDay.text = @"日：";
		//m_tm_date=m_das->sens[m_sensid].pulse.tm_start1-1;
		//m_tm_hr=m_das->sens[m_sensid].pulse.tm_start2;
		//m_tm_min=m_das->sens[m_sensid].pulse.tm_start3;
		//m_static_date.LoadString(IDS_TMLABEL1); "日：
	}else if(siteDoc.m_das.sens[m_sensid].sines.method==3){
		
		[cmboMon setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start1 - 1];
		[cmboDay setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start2 - 1];
		[cmboHour setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start3];
		[cmboMin setSelectIndex:siteDoc.m_das.sens[m_sensid].sines.tm_start4];
		labDay.text = @"日：";

	}
	 
	//m_freqnum=m_das->sens[m_sensid].sines.prd_num;
	//m_type=m_das->sens[m_sensid].sines.amptype;
	
	sprintf(temp, "%d" , siteDoc.m_das.sens[m_sensid].sines.prd_num);
	txtFrqNum.text = [[NSString alloc] initWithUTF8String:temp];
	if(siteDoc.m_das.sens[m_sensid].sines.amptype == 1){
		[radioGroup checkButtonClicked:radioAmp];
 
	}else {
		[radioGroup checkButtonClicked:radioAtten];
	}

	
	[self EnableCtl:siteDoc.m_das.sens[m_sensid].sines.method];
	
	for(int i=0;i<siteDoc.m_das.sens[m_sensid].sines.prd_num && i<100;i++)
	{
		m_sine[i].aten=siteDoc.m_das.sens[m_sensid].sines.sine[i].aten;
		m_sine[i].cycle=siteDoc.m_das.sens[m_sensid].sines.sine[i].cycle;
		m_sine[i].prd=siteDoc.m_das.sens[m_sensid].sines.sine[i].prd;
	}
	[tableSines reloadData];
	//UpdateData(FALSE);
}



- (void) EnableCtl: (NSInteger)index 
{
	//int m_tm_method = [cmbMethod getSelectIndex];
	int m_tm_method = index;
	if(m_tm_method==0)
	{
		[cmboMon setEnabled:FALSE];
		[cmboDay setEnabled:FALSE];
		[cmboHour setEnabled:TRUE];
		[cmboMin setEnabled:TRUE];
		/*
		 m_combo_mon.EnableWindow(FALSE);
		 m_combo_date.EnableWindow(FALSE);
		 m_combo_hr.EnableWindow(TRUE);
		 m_combo_min.EnableWindow(TRUE);
		 */
		
	}else if(m_tm_method==1 || m_tm_method==2){
		
		[cmboMon setEnabled:FALSE];
		[cmboDay setEnabled:TRUE];
		[cmboHour setEnabled:TRUE];
		[cmboMin setEnabled:TRUE];
		/*
		 m_combo_mon.EnableWindow(FALSE);
		 m_combo_date.EnableWindow(TRUE);
		 m_combo_hr.EnableWindow(TRUE);
		 m_combo_min.EnableWindow(TRUE);
		 */
		//		m_edit_interval.EnableWindow(FALSE);
	}else if(m_tm_method==3)
	{
		[cmboMon setEnabled:TRUE];
		[cmboDay setEnabled:TRUE];
		[cmboHour setEnabled:TRUE];
		[cmboMin setEnabled:TRUE];
		/*
		 m_combo_mon.EnableWindow(TRUE);
		 m_combo_date.EnableWindow(TRUE);
		 m_combo_hr.EnableWindow(TRUE);
		 m_combo_min.EnableWindow(TRUE);
		 */
		//		m_edit_interval.EnableWindow(FALSE);
	}else if(m_tm_method==4){
		[cmboMon setEnabled:FALSE];
		[cmboDay setEnabled:FALSE];
		[cmboHour setEnabled:FALSE];
		[cmboMin setEnabled:FALSE];
		/*
		 m_combo_mon.EnableWindow(FALSE);
		 m_combo_date.EnableWindow(FALSE);
		 m_combo_hr.EnableWindow(FALSE);
		 m_combo_min.EnableWindow(FALSE);
		 */
		//		m_edit_interval.EnableWindow(TRUE);
	}
	
	//m_combo_date.ResetContent();
	if(m_tm_method==1){
		NSArray *cmboDay1 = [[NSArray alloc] initWithObjects: @"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",nil];
		[cmboDay setItems:cmboDay1];
	}else {
		NSMutableArray *cmboDay2 = [NSMutableArray array];
		char temp[1024];
		for(int i=1;i<=31;i++)
		{
			sprintf(temp,"  %d  ",  i);
			[cmboDay2 addObject:[[NSString alloc] initWithUTF8String:temp]];
		}
		
		[cmboDay setItems:cmboDay2];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	//if(siteDoc.m_das.stnpar.sens_num == 0) {return;}
	[self initUI];
	[cmboSens setSelectIndex:0];
	[self initUI1:0];
	
	
}

- (void)viewDidLoad
{
	self.title = @"设置正弦标定";
	int xW = 310;
	int yH = 5;
	//-------------------------------------------- 
	UILabel *labSens = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 30+yH , 180 , 30 )];
	labSens.text = @"选择地震计：";
	[scrollView addSubview:labSens];[labSens release];
	
	cmboSens= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 30+yH , 200 , 28 )];
	cmboSens.dropMaxHeigth  = 32*4;
	cmboSens.delegate = self;
	NSMutableArray *comboSensData = [NSMutableArray array];
	int i = 0;
	char temp[100];
	for(i=0;i<siteDoc.m_das.stnpar.sens_num;i++)
	{
		sprintf(temp,"地震计 %c",  sens_id[i]);
		[comboSensData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	if(siteDoc.m_das.stnpar.sens_num != 0) {
		[cmboSens setItems:comboSensData];
		//[comboSensData release];
	}
	[scrollView addSubview :cmboSens];
	[cmboSens release];
	
	//-------------------------------------------- 
	ckBTimer = [[ UICheckButton alloc ] initWithFrame : CGRectMake ( 50+xW , 65+yH , 200 , 30 )];
	ckBTimer.label.text = @"定时标定" ;
	ckBTimer.value =[[ NSNumber alloc ] initWithInt:0 ];
	ckBTimer.style = CheckButtonStyleBox ;
	[scrollView addSubview :ckBTimer];
	[ckBTimer release];
	
	
	//-------------------------------------------- 
	UILabel *labMothed = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 100+yH , 180 , 30 )];
	labMothed.text = @"定时方式：";
	[scrollView addSubview:labMothed];[labMothed release];
	
	cmbMethod= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 100+yH , 200 , 28 )];
	cmbMethod.dropMaxHeigth  = 32*4;
	cmbMethod.delegate = self;
	
	NSArray *cmbMethodData = [[NSArray alloc] initWithObjects:@"每日",@"每星期",@"每月", @"每年",nil];
	
	[cmbMethod setItems:cmbMethodData];
	[scrollView addSubview :cmbMethod];
	[cmbMethod release];
	[cmbMethodData release];
	
	
	//-------------------------------------------- 
	UILabel *labMon = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 135+yH , 180 , 30 )];
	labMon.text = @"月：";
	[scrollView addSubview:labMon];[labMon release];
	
	
	cmboMon= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 135+yH , 200 , 28 )];
	cmboMon.dropMaxHeigth  = 32*4;
	cmboMon.delegate = self;
	NSMutableArray *comboMonData = [NSMutableArray array];
	
	for(i=1;i<=12;i++)
	{
		sprintf(temp,"  %d  ",  i);
		[comboMonData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	[cmboMon setItems:comboMonData];
	[scrollView addSubview :cmboMon];
	[cmboMon release];
	
	//-------------------------------------------- 
	labDay = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 170+yH , 180 , 30 )];
	labDay.text = @"日：";
	[scrollView addSubview:labDay];[labDay release];
	
	
	cmboDay= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 170+yH , 200 , 28 )];
	cmboDay.dropMaxHeigth  = 32*4;
	cmboDay.delegate = self;
	NSMutableArray *comboDayData = [NSMutableArray array];
	
	for(i=1;i<=31;i++)
	{
		sprintf(temp,"  %d  ",  i);
		[comboDayData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	[cmboDay setItems:comboDayData];
	[scrollView addSubview :cmboDay];
	[cmboDay release];
	
	
	//----------------------------------------------------------------------------  
	UILabel *labHour = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 205+yH , 180 , 30 )];
	labHour.text = @"时：";
	[scrollView addSubview:labHour];[labHour release];
	
	
	cmboHour = [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 205+yH , 200 , 28 )];
	cmboHour.dropMaxHeigth  = 32*4;
	cmboHour.delegate = self;
	NSMutableArray *comboHourData = [NSMutableArray array];
	
	for(i=0;i<=23;i++)
	{
		sprintf(temp,"  %d  ",  i);
		[comboHourData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	[cmboHour setItems:comboHourData];
	[scrollView addSubview :cmboHour];
	[cmboHour release];
	
	//----------------------------------------------------------------------------  
	UILabel *labMin = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 240+yH , 180 , 30 )];
	labMin.text = @"分：";
	[scrollView addSubview:labMin];[labMin release];
	
	
	cmboMin = [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 240+yH , 200 , 28 )];
	cmboMin.dropMaxHeigth  = 32*4;
	cmboMin.delegate = self;
	NSMutableArray *comboMinData = [NSMutableArray array];
	
	for(i=0;i<=59;i++)
	{
		sprintf(temp,"  %d  ",  i);
		[comboMinData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	[cmboMin setItems:comboMinData];
	[scrollView addSubview :cmboMin];
	[cmboMin release];
	
	
	//----------------------------------------------------------------------------  
	UILabel *labDrqNum = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 275+yH , 180 , 30 )];
	labDrqNum.text = @"频点数：";
	[scrollView addSubview:labDrqNum];[labDrqNum release];
	
	
	txtFrqNum = [[UITextField alloc] initWithFrame:CGRectMake(165+xW, 275+yH, 200, 30)];
	txtFrqNum.borderStyle =  UITextBorderStyleRoundedRect;
	txtFrqNum.delegate =self;
	[scrollView addSubview:txtFrqNum];	
	
	//----------------------------------------------------------------------------
	radioGroup =[[ RadioGroup alloc ] init ];
	
	radioAtten =[[ UICheckButton alloc ] initWithFrame : CGRectMake ( 50+xW , 310+yH , 160 , 32 )];
	radioAtten.label.text = @"衰减值" ;
	radioAtten.value =[[ NSNumber alloc ] initWithInt:0 ];	
	radioAtten.style = CheckButtonStyleRadio ;
	[radioGroup add :radioAtten];
	[ scrollView addSubview :radioAtten];
	[radioAtten release];
	
	radioAmp =[[ UICheckButton alloc ] initWithFrame : CGRectMake ( 165+xW , 310+yH , 200 , 32 )];
	radioAmp.label.text = @"正弦波单峰值" ;
	radioAmp.value =[[ NSNumber alloc ] initWithInt:1 ];	
	radioAmp.style = CheckButtonStyleRadio ;
	[radioGroup add :radioAmp];
	[ scrollView addSubview :radioAmp];
	[radioAmp release];
	
	//----------------------------------------------------------------------------
	//tableScrollView = [[UIScrollView alloc] initWithFrame : CGRectMake ( 50 , 345 , 360 , 300 )];
	//[scrollView addSubview :tableScrollView];
	tableSines = [[SineTable alloc] initWithFrame: CGRectMake ( 50+xW , 345+yH , 330 , 200 )];
	//[tableScrollView addSubview :tableSines];
	[ scrollView addSubview :tableSines];
	
	
	//-------------------------------------------- 
	/*
	模板名
	文件 
	短周期地震计
	sine_short.cal
	宽频带地震计 
	sine_band.cal
	甚宽频带地震计 
	sine_vband.cal
	BBVS-60_50HZ
	sine_bbvs60_50.cal
	BBVS-60_100HZ
	sine_bbvs60_100.cal
	BBVS-60_200HZ
	sine_bbvs60_200.cal
	BBVS-120_50HZ
	sine_bbvs120_50.cal
	BBVS-120_100HZ
	sine_bbvs120_100.cal
	BBVS-120_200HZ
	sine_bbvs120_200.cal
	*/
	
	UILabel *labFraModel = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 558+yH , 150 , 30 )];
	labFraModel.text = @"频点模板：";
	[scrollView addSubview:labFraModel];[labFraModel release];
	
	cmbFraModel = [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 130+xW , 560 +yH, 150 , 28 )];
	cmbFraModel.dropMaxHeigth  = 32*4;
	cmbFraModel.delegate = self;
	
	
	
	NSArray *cmbFraModelData = [[NSArray alloc] initWithObjects:@"短周期地震计",@"宽频带地震计",@"甚宽频带地震计", @"BBVS-60_50HZ",
								@"BBVS-60_100HZ",@"BBVS-60_200HZ",@"BBVS-120_50HZ",@"BBVS-120_100HZ", @"BBVS-120_200HZ",
								nil];
	
	[cmbFraModel setItems:cmbFraModelData];
	[scrollView addSubview :cmbFraModel];
	[cmbFraModel release];
	[cmbFraModelData release];
	/*
	UIButton *btnFraModel = [[UIButton alloc] initWithFrame : CGRectMake ( 285 , 450 , 50 , 30 )];
	//btnFraModel.label = @"保存模板";
	[scrollView addSubview :btnFraModel];
	[btnFraModel release];
	*/
	
	UIButton *btnFraModel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btnFraModel.frame = CGRectMake( 285+xW , 558+yH , 90 , 30 );
	
	[btnFraModel setTitle:@"保存模板" forState:UIControlStateNormal];
	[btnFraModel setTitle:@"保存模板" forState:UIControlStateHighlighted];
	[btnFraModel addTarget:self action:@selector(saveFeqModeAction:) forControlEvents:UIControlEventTouchUpInside];
	[scrollView addSubview :btnFraModel];
	//[btnFraModel release];
	
	
}
-(void) saveFeqToFile :(char *) fileName{

	// TODO: Add your control notification handler code here
	
	FILE * fp;
	fp=fopen(fileName, "w");
	if(fp==NULL)
	{
		return;
	}
	int m_freqnum = [txtFrqNum.text intValue];
	if(m_freqnum <=0 || m_freqnum > 100) {fclose(fp);	return;}
		
	fprintf(fp,"%d\n",m_freqnum);
	for(int i=0;i<m_freqnum ;i++)
	{
			fprintf(fp,"%d ",m_sine[i].cycle);
			fprintf(fp,"%.2hd ",m_sine[i].prd);
			fprintf(fp,"%d\n",m_sine[i].aten);
	}
	fclose(fp);	
	
	UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"信息" message:@"已成功保存频点模板" 
												 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[av show];	
}

-(void) importFraFromFile:(char *) fileName
{
	
	FILE * fp;
		
	fp=fopen(fileName,"r");
	if(fp==NULL)
	{
		printf("File no find : %s \n", fileName);
		return;
	}
	
	int sine_n;
	float f;
	fscanf(fp,"%d\n",&sine_n);
	if(sine_n<=0)
	{
		fclose(fp);
		return;
	}
	char temp[100];
	sprintf(temp,"%d", sine_n);
	txtFrqNum.text = [[NSString alloc] initWithUTF8String:temp];
	
	memset(&m_sine, 0, sizeof(SINES) * 100);
		
	for(int i=0;i<sine_n && i<100;i++){
		fscanf(fp,"%hd %f %hd\n",&m_sine[i].cycle,&f,&m_sine[i].aten);
		m_sine[i].prd=(short)(f*10.0);
	}
	
	fclose(fp);
	[tableSines reloadData];
}


- (void) importFeqModeAction:(NSInteger)index {
	
	char temp[1000];
	if(index == 0) // 短周期地震计 sine_short.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_short.cal");
	
	}else if(index ==1) // 宽频带地震计  sine_band.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_band.cal");
	}else if(index ==2) // 甚宽频带地震计  sine_vband.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath,"sine_vband.cal");
	
	}else if(index == 3) // BBVS-60_50HZ sine_bbvs60_50.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs60_50.cal");
		
	}else if(index == 4) //BBVS-60_100HZ sine_bbvs60_100.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs60_100.cal");
	}else if(index == 5) // BBVS-60_200HZ sine_bbvs60_200.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs60_200.cal");
	
	}else if(index == 6) // BBVS-120_50HZ sine_bbvs120_50.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs120_50.cal");
	
	}else if (index == 7) //BBVS-120_100HZ sine_bbvs120_100.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs120_100.cal");
	
	}
	else if (index == 8) //BBVS-120_200HZ sine_bbvs120_200.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs120_200.cal");
	}
	[self importFraFromFile:temp];
	printf("import model %d\n", index);
}
- (void) saveFeqModeAction:(id)sender{
	int index = [cmbFraModel getSelectIndex];
	
	char temp[1000];
	if(index == 0) // 短周期地震计 sine_short.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_short.cal");
		
	}else if(index ==1) // 宽频带地震计  sine_band.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_band.cal");
	}else if(index ==2) // 甚宽频带地震计  sine_vband.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_vband.cal");
		
	}else if(index == 3) // BBVS-60_50HZ sine_bbvs60_50.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs60_50.cal");
		
	}else if(index == 4) //BBVS-60_100HZ sine_bbvs60_100.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs60_100.cal");
	}else if(index == 5) // BBVS-60_200HZ sine_bbvs60_200.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs60_200.cal");
		
	}else if(index == 6) // BBVS-120_50HZ sine_bbvs120_50.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs120_50.cal");
		
	}else if (index == 7) //BBVS-120_100HZ sine_bbvs120_100.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath, "sine_bbvs120_100.cal");
		
	}
	else if (index == 8) //BBVS-120_200HZ sine_bbvs120_200.cal
	{
		sprintf(temp, "%s/cfg/%s", theApp.m_taskpath,"sine_bbvs120_200.cal");
		
	}
	[self saveFeqToFile:temp];
	
	
	printf("save model %d \n", index);
}

- (void)comboBox: (UIComboBox *)comboBox selectItemAtIndex: (NSInteger)index {
	if(comboBox == cmboSens){
		[self initUI1:index];
	}else if(comboBox == cmbMethod){
		
		if(index==1){
			labDay.text = @"星期:";
		}else{
			labDay.text = @"日:";
		}
		[self EnableCtl:index];
		
	}else if(comboBox == cmbFraModel){
		[self importFeqModeAction:index];
	}
	
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{	
	
	 if(textField == txtFrqNum) {
	 NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSINT] invertedSet];
	 NSString *filter = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
	 BOOL basiTest = [string	isEqualToString:filter];
	 if(!basiTest){
	 UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入数字" 
	 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	 [av show];
	 return NO;
	 }else{
	 return YES;
	 }
	 
	 
	 }
	 
	
	return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	 if(textField == txtFrqNum){
		 int aa = [txtFrqNum.text intValue];
		 if(aa > 100 || aa < 0)	{
			 UIAlertView *av = [[[UIAlertView alloc]
                                 initWithTitle:@"提示"
                                 message:@"请输入大于 0 小于 100 的整数"
                                 delegate:nil cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil] autorelease];
			 return NO;
		 }
	 }
	 
	
	[textField resignFirstResponder];
	return YES;
}


- (IBAction)btnOKClick:(id)sender {
    
	int m_tm_method = [cmbMethod getSelectIndex];
	int m_tm_mon =[cmboMon getSelectIndex];
	int m_tm_date =[cmboDay getSelectIndex];
	int m_tm_hr = [cmboHour getSelectIndex];
	int m_tm_min = [cmboMin	getSelectIndex];
	short m_sensid = (short) [cmboSens getSelectIndex];
	short m_btimer = [ckBTimer isChecked];
	
	long t=theApp.CalcStarttime(m_tm_method,m_tm_mon,m_tm_date+1,m_tm_hr,m_tm_min);
	char m_cmd[1024];
	int m_cmd_len = 0;
	
	m_cmd[0]=0xbf;
	m_cmd[1]=0x13;
	m_cmd[2]=0x97;
	m_cmd[3]=0x74;
	
	CM_SINEFRM frm;
	
	memset(&frm,0,sizeof(frm));
	frm.head.cmd=0x6021;
	frm.head.sens_id=m_sensid;
	//frm.head.length=20;
	frm.btimer=m_btimer;
	frm.time=t;//t.GetTime();
	frm.method=m_tm_method;
	
	if(m_tm_method==0)
	{
		frm.tm_start1=m_tm_hr;
		frm.tm_start2=m_tm_min;
		frm.tm_start3=frm.tm_start4=0;
	}else if(m_tm_method==1 || m_tm_method==2)
	{
		frm.tm_start1=m_tm_date+1;
		frm.tm_start2=m_tm_hr;
		frm.tm_start3=m_tm_min;
		frm.tm_start4=0;
	}else if(m_tm_method==3){
		frm.tm_start1=m_tm_mon+1;
		frm.tm_start2=m_tm_date+1;
		frm.tm_start3=m_tm_hr;
		frm.tm_start4=m_tm_min;
	}//else frm.tm_start1=m_interval;
	
	
	
	frm.prd_num=[txtFrqNum.text intValue];
	
	frm.amptype=(short)[radioGroup.value intValue];
	frm.head.length=24+6*frm.prd_num;
	
	memcpy(&m_cmd[4],(char *)&frm,28);
	short *p=(short *)&m_cmd[32];
	int i = 0;
	
	for( i=0;i<frm.prd_num && i<100;i++)
	{
		
		p[i*3] = m_sine[i].cycle;
		p[1+i*3]= m_sine[i].prd;
		p[2+i*3] = m_sine[i].aten;
		//printf("%d , %d , %d \n", p[i*3], p[1+i*3], p[2+i*3]);
	}
	
	frm.chk_sum=0;
	p=(short *)&m_cmd[4];
	for(i=0;i<(frm.head.length+6)/2-1;i++)
		frm.chk_sum-=p[i];
	p[i]=frm.chk_sum;
	m_cmd_len=frm.head.length+10;
	
	if(!siteDoc.m_thd->Send(m_cmd,m_cmd_len))
	{	//SendErr();
		UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"错误" message:@"网路连接失败" 
													 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[av show];	
	}else {
		UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"信息" message:@"设置正弦标定成功" 
													 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[av show];	
	}
	 
	
	
}

- (IBAction)btnCancelClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
@end
