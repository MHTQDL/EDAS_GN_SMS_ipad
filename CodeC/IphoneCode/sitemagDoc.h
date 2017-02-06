// sitemagDoc.h : interface of the CSitemagDoc class
// 建立数据缓冲区 , 查询／解析参数帧，启动通信线程连接采集器
/////////////////////////////////////////////////////////////////////////////
#ifndef SITEMAGDOC
#define SITEMAGDOC

#include "netrcv.h"
#include "csaveevtarray.h"
#include "cmdascmd.h"
#include "rcvthd.h"
#include "CommonDef.h"
#include "SitelinkObj.h"


//#include "constatusdlg.h"
class CSitemagDoc
{
public: // create from serialization only
    CSitemagDoc();
    
    // Attributes
public:
    //1-settimer -1: nomessage
    int m_update_id;
    //1－完成内存分配，允许显示
    BOOL m_bshow;
    
    //process parameter frame, info: message information string
    void ProcessMessage(char * pdata,string & info);
    //reset das sytstem
    void ResetSys();
    //检查网络连接 返回： true－连接正常
    BOOL IsConnected();
    //重新连接网络
    void ReConnect();
    //check network connection , return 1-connected 0- disconnected -1: disconnected and timeout
    int ProcessCon();
    //save parameter message
    void SaveMessage();
    //通道缓冲区头指针
    CHANNEL * m_pchannels;
    //连接的台站
    CSitelinkObj * m_selsite;
    //1－保存数据
    BOOL m_save_status;
    //采集器参数
    DASCMDSTRUC m_das;
    //1--设置后重启动采集器 0－无需重启动
    BOOL m_btip;
    //0-不显示收到的gps信息
    BOOL m_bshow_gps;
    //台站纬度 经度 高程
    float m_lat,m_lon,m_alt;
    
    //监测系统电压v
    int m_bsysvolmon;
    //系统电压连接的辅助通道
    int m_sysvolad;
    //电压报警值v
    float m_sysvol;
    //监测零位电压v
    int m_bsensoffvolmon;
    //监测零位电压报警值v
    float m_sensoffvol;
public:
    //通信线程
    CRcvThd * m_thd;
    
    int m_selSite;
    //CObList m_sitelst;
    vector<CSitelinkObj*> m_sitelst;
    
    BOOL m_badmin;
    
    //存盘模式1－连续，0－分小时，2－定时
    int m_bctn_mode;
    //存盘开始时间
    long m_savefile_begin;
    //存盘数据长度
    int m_savefile_len;
    
    //1-转换asc文件
    BOOL m_btxt_file;
    //存盘类
    CSaveEVTArray m_save_file;
    //台站参数
    //STN_PAR m_stnpar[40];
    //1-启动片段纪录  0-停止记录
    int m_rec_stat;
    
    pthread_t m_thread;
    
    string m_exe_path;
    //1-显示心跳信息
    BOOL m_bview_heartbeat;
    long m_begin_con;
    
    //1-清除m_old_msg
    BOOL m_bmsg_clr;
    
    //事件前记录长度，事件后记录长度，秒
    int m_pre_evt,m_aft_evt;
    
    CHANNEL * m_pcur_chn;//current processed channel
    string m_old_msg;//old message before clear;
    string m_msg;//current message
    BOOL m_bshow_allmsg;//TRUE-show m_old_msg,FALSE-show m_msg
    
    int m_sensid;//the sensor id to be send message to, used at SensSet
public:
    //分配 m_pchannel
    BOOL AllocateChannel();
    int AllocRevblk(REVBLKS *prev,long samp);
    //分配 m_thd
    BOOL AllocThd();
    //释放 m_thd
    void FreeThd();
    
    //释放 m_pchannel
    void FreeChannel();
    void FreeRevblk(REVBLKS *prev);
    
    //连接台站
    BOOL ConnectSite();
    //关闭连接
    void CloseCon();
    
    void ChangeStatusbar(int index,string info);
    //读入台站参数文件
    BOOL LoadSiteinfo();
    //建立文件目录
    void CreateDir();
    //释放 m_sitelst
    void FreeSitelst();
    //Ã®’æπ‹¿Ì£¨flag:1 enable connection button
    int OnSelSite(int selIndex);
    //◊∞‘ÿÃ®’æ≤Œ ˝
    //void LoadStnpar();
    //BOOL SetStnpar(STN_PAR *spara,char * site,int local_id);
    //BOOL SetChnPar(CHA_PAR *par,char * site,int local_id,int total,int comp);
    //Ω®¡¢ ˝æ›Œƒº˛£¨channel:Õ®µ¿¥˙¬Î
    //BOOL CreateDataFile(int channel);
    //πÿ±’Œƒº˛ channel:Õ®µ¿¥˙¬Î
    //void CloseDataFile(int channel);
    //◊™ªª≥…∑÷µ¿µƒasccŒƒº˛ channel:Õ®µ¿¥˙¬Î
    //BOOL ConvertToASC(int channel);
    //–¥»ÎŒƒº˛≥§∂» channel:Õ®µ¿¥˙¬Î
    //	BOOL CopyDataToFl(int channel);
    //∑¢ÀÕ«Î«Û≤…ºØ∆˜≤Œ ˝√¸¡Ó
    void GetDASInfo();
    //生成查询命令帧 cmd：帧标志 id：地震计序号
    void SiteInquery(unsigned short cmd,int id);
    
    //查询环境参数
    void OnInqHeartInterval();
    //发送错误提示
    void SendErr();
    
    /* 以下处理参数帧，pdata： 参数帧  info： 返回的参数信息*/
    //台站参数
    void OnStnpar(char * pdata,string & info);
    //地震计参数
    void OnSenspar(char * pdata,string & info);
    //仪器响应
    void OnInstpar(char * pdata,string & info);
    
    //采样率
    void OnSmprate(char * pdata,string & info);
    
    //量程
    void OnGain(char * pdata,string & info);
    //零点偏移
    void OnDasoff(char * pdata,string & info);
    
    //脉冲标定
    void OnCalPulse(char * pdata,string & info);
    //正弦标定
    void OnCalSine(char * pdata,string & info);
    //随机码标定
    void OnCalPseudo(char * pdata,string & info);
    //强震
    void OnCalStrong(char * pdata,string & info);
    //标定等待时间
    void OnCalDelay(char * pdata,string & info);
    //启动标定响应
    void OnStartcal(char * pdata,string & info);
    //停止标定响应
    void OnStopcal(char * pdata,string & info);
    
    //启动调零命令响应
    void OnCfgSensoff(char *pdata,string & info);
    //停止调零响应
    void OnStopSensoff(char *pdata,string & info);
    //调整地震计零点
    void OnSensAdjStat(char * pdata,string &info);
    //锁摆
    void OnCmgLock(char *pdata,string & info);
    
    //实时网络数据服务
    void OnNetsrv(short cmd,char * pdata,string &info);
    //主动发送服务
    void OnDataSrv(char * pdata,string & info);
    //串口
    void OnIPUCom(char * pdata,string & info);
    //串口发送方式
    void OnComctl(char * pdata,string & info);
    
    //自动触发参数
    void OnTrigauto(char * pdata,string & info);
    //地震事件判定
    void OnDetevt(char * pdata,string & info);
    //地震事件触发
    void OnEvtTrig(char * pdata,string & info);
    //地震事件触发结束
    void OnEvtDetrig(char * pdata,string & info);
    
    //心跳信息间隔
    void OnHeartbeat(char * pdata,string & info);
    //电压
    void OnVOL(char * pdata,string & info);
    //温度
    void OnTEMP(char * pdata,string & info);
    //钟差
    void OnClkerr(char * pdata,string & info);
    //充电
    void OnBatcharge(char * pdata,string & info);
    //停止充电
    void OnBatchargeStop(char * pdata,string & info);
    //GPS状态
    void OnGpsStat(char * pdata,string & info);
    //环境参数
    void OnGetHeartbeat(char *pdata,string & info);
    //磁盘
    void OnHdStat(char *pdata,string & info);
    //gps
    void OnGPS(char * pdata,string & info);
    //地震计零点
    void OnGetSensoff(char *pdata,string & info);
    //地震计控制信号
    void OnSensSig(char * pdata,string & info);
    
    //sd卡写控制
    void OnWrctl(char * pdata,string & info);
    //清空sd 卡
    void OnClearSD(char * pdata,string & info);
    //文件管理策略
    void OnBackupRule(char * pdata,string & info);
    //网络地址
    void OnIp(char * pdata,string & info);
    //时区
    void OnTimezone(char * pdata,string & info);
    //系统时间
    void OnSysTm(char * pdata,string & info);
    //GPS对钟间隔
    void OnGpsInt(char * pdata,string & info);
    //系统重启动
    void OnResetSys(string & info);
    //恢复出厂参数
    void OnResettoDefault(string & info);
    //关闭采集器
    void OnStopSys(string & info);
    //事件记录
    void OnEvtrec(char * pdata,string & info);
    //烈度信息
    void OnLd(char * pdata,string & info);
    
    //灾评参数
    void OnZaiping(char * pdata,string & info);
    
    //广播帧
    void OnBroadcast(char * pdata,string & info);
    
    
    void ChangeChannelFactor(int sens_id,float factor);
    
    //查询输入信号零点偏移
    void OnInqInoff();
    
    //查询采样率
    void OnInqSmp(int sensid);
    
    
    
    // Operations
public:
    //±£¥Ê≤®–Œ
    //	void SaveData();
    //return 1-connected 0-disconnected
    int CheckConStat();
    //台站参数设置钟查 gps信息
    void OnSetGps();
    
    
public:
    virtual BOOL OnNewDocument();
    
    
    // Implementation
public:
    virtual ~CSitemagDoc();
    
protected:
    
    // Generated message map functions
public:
    
    void OnRunSitemag(int selIndex);
    void OnCfgSavemode();
    
    void OnRunConnect();
    
    
    /* void OnCfgStopcal();
     
     void OnCfgSensctlon();
     void OnCfgSensctloff();
     
     
     void OnCfgResetsys();
     void OnCfgReset();*/
    
    //////////////////////////////////////////////////////
    // UI to Data
    //////////////////////////////////////////////////////
    
    void OnInqDas();//查询采集参数
    void OnInqCal();//查询标定参数
    void OnInqGps();//查询gps参数
    void OnInqSens();//查询地震计参数
    void OnInqSite();//查询台站参数
    void OnInqSensoff();//查询地震计零点
    void OnInqNet();//查询网络地址
    void OnInqBackup();//查询文件管理策略
    void OnInqInst();//查询仪器响应
    void OnInqTrig();//查询触发参数
    void OnInqDatasrv();//查询数据服务参数
    void OnInqTimezone();//查询时区
    void OnInqEnv();//查询环境参数，零点偏移
    void OnInqHdstat();//查询磁盘
    
    
    void OnViewHeartbeat();
    
    //void OnFileSave();
    
    //void OnRunFtp();
    
    //void OnCfgSensctl();
    
    void OnInqSenssig();//查询地震计控制信号
    
    
    
};

/////////////////////////////////////////////////////////////////////////////

#endif

