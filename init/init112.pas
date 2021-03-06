//****************************************************************************//
//用途：大雁煤业有限责任公司
//****************************************************************************//
unit init112;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Gauges;

type
  Tfrm_init = class(TForm)
    ADOConnection_init: TADOConnection;
    Gauge1: TGauge;
    btn_star: TButton;
    btn_stop: TButton;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edt_dbpass: TEdit;
    edt_dbname: TEdit;
    edt_db: TEdit;
    edt_srv: TEdit;
    ADOCommand1: TADOCommand;
    procedure FormCreate(Sender: TObject);
    procedure btn_starClick(Sender: TObject);
    procedure btn_stopClick(Sender: TObject);
  private
    { Private declarations }
  public
    xbf:WideString;
    { Public declarations }
  end;

//
  type
  TreadXBF=function(DimRecord: Integer;filename1:WideString):WideString;stdcall;
  //

var
  frm_init: Tfrm_init;
  connstring:TreadXBF;
implementation

{$R *.dfm}

function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;
                                external 'XBFGenerate.dll';

procedure Tfrm_init.FormCreate(Sender: TObject);
begin
  frm_init.Caption:='初始化程序';
  xbf:=ExtractFilePath(ParamStr(0))+'zlnr1.xbf';
end;

procedure Tfrm_init.btn_starClick(Sender: TObject);
var
  h1:THandle;
begin
  if btn_stop.Enabled=false then
  begin
    Exit;
  end;
  try
     h1:=0;
     try
      h1:=LoadLibrary('XBFGenerate.dll');
    
      if h1<>0 then
        @connstring:=GetprocAddress(h1,'readXBF');
      if (@connstring<>nil)then
          ADOConnection_init.Close;
          ADOConnection_init.ConnectionString:=connstring(-1,xbf);
          ADOConnection_init.Open;
     finally
       FreeLibrary(h1);
     end;
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;
  Gauge1.Visible:=True;
  try
    ADOCommand1.CommandText:='CREATE TABLE [dbo].[trainOrder] ('+#13+
                             '[train_number] [int] NULL ,'+#13+
                             '[seriary_number] [int] NULL ,'+#13+
                             '[car_number] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                             '[car_marque] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                             '[carry_weight1] [numeric](9, 3) NULL ,'+#13+
                             '[self_weight1] [numeric](9, 3) NULL ,'+#13+
                             '[past_time] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                             '[outFlag] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                             '[sn] [int] IDENTITY (1001, 1) NOT NULL'+#13+
                             ') ON [PRIMARY]';

    ADOCommand1.Execute;
    Gauge1.Progress:=25;
    //

    ADOCommand1.CommandText:='CREATE TABLE [dbo].[car_number] ('+#13+
                              '[train_number] [int] NOT NULL ,'+#13+
                              '[seriary_number] [int] NOT NULL ,'+#13+
                              '[car_number] [nvarchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[past_time] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[car_marque] [nvarchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                              ') ON [PRIMARY]';
    ADOCommand1.Execute;
    Gauge1.Progress:=50;
     //
    ADOCommand1.CommandText:='CREATE TABLE [dbo].[switchyard] ('+#13+
                              '[journalID] [int] IDENTITY (1001, 1) NOT NULL ,'+#13+
                              '[mineName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[direction_PS] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[direction_SC] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[car_number] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[car_marque] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[carry_weight1] [numeric](9, 3) NULL ,'+#13+
                              '[self_weight1] [numeric](9, 3) NULL ,'+#13+
                              '[cargo_generalID] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[tonNumber] [numeric](9, 3) NULL ,'+#13+
                              '[breed] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[switchyardNotepad] [varchar] (90) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[past_time] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[seriary_number] [int] NULL'+#13+
                              ') ON [PRIMARY]';
    ADOCommand1.Execute;
     //
    Gauge1.Progress:=61;
    //
    {ADOCommand1.CommandText:='CREATE TABLE [dbo].[operator] ('+#13+
                             '[OperID] [int] IDENTITY (1001, 1) NOT NULL ,'+#13+
                             '[OperName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                             '[OperPassWord] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                             '[preserve1] [bit] NULL ,'+#13+
                             '[OperMemo] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                             ') ON [PRIMARY]';
    ADOCommand1.Execute;}
    Sleep(1000);
    Gauge1.Progress:=100;
    //
    Application.MessageBox('初始化完成！','提示',MB_OK);
    btn_stop.Enabled:=False;
  except

  end;
end;

procedure Tfrm_init.btn_stopClick(Sender: TObject);
var
  h1:THandle;
begin
  try
     h1:=0;
     try
      h1:=LoadLibrary('XBFGenerate.dll');
    
      if h1<>0 then
        @connstring:=GetprocAddress(h1,'readXBF');
      if (@connstring<>nil)then
          ADOConnection_init.Close;
          ADOConnection_init.ConnectionString:=connstring(-1,xbf);
          ADOConnection_init.Open;
     finally
       FreeLibrary(h1);
     end;
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;
  //
  try
    ADOCommand1.CommandText:='drop table trainOrder';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop table car_number';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop table switchyard';
    ADOCommand1.Execute;
    //
  except

  end;
  //
  try
    ADOCommand1.CommandText:='CREATE TABLE [dbo].[OldSwitchyard] ('+#13+
	                        '[journalID] [int] NOT NULL ,'+#13+
	                        '[mineName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                        '[direction_PS] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                        '[direction_SC] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                        '[car_number] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                        '[car_marque] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                        '[carry_weight1] [numeric](9, 3) NULL ,'+#13+
	                        '[self_weight1] [numeric](9, 3) NULL ,'+#13+
	                        '[cargo_generalID] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                        '[tonNumber] [numeric](9, 3) NULL ,'+#13+
	                        '[breed] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                        '[switchyardNotepad] [varchar] (90) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                        '[past_time] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
	                        '[seriary_number] [int] NULL ,'+#13+
	                        '[heavy] [bit] NULL ,'+#13+
	                        '[cumulateConsist] [int] NULL ,'+#13+
	                        '[OperID] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL'+#13+
                                ') ON [PRIMARY]';
    ADOCommand1.Execute;
  except

  end;

  //
  btn_star.Enabled:=True;
  Application.MessageBox('预处理完成！','提示',MB_OK);
end;


end.
