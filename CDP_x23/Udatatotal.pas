unit Udatatotal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Grids, DBGrids, StdCtrls, DB, ADODB, Printers,
  GridsEh, DBGridEh, PrnDbgeh, StrUtils;

type
  Tfrm_sa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    cmbox_dz: TComboBox;
    Label2: TLabel;
    cmbox_mz: TComboBox;
    Label4: TLabel;
    cmbox_dd: TComboBox;
    DataSource1: TDataSource;
    totals1: TADODataSet;
    FindData: TADOQuery;
    pnl_btn: TPanel;
    btn_find: TButton;
    btn_print2: TButton;
    Label3: TLabel;
    cmb_gs: TComboBox;
    CheckBox1: TCheckBox;
    DBGridEh1: TDBGridEh;
    DTP_sTime: TDateTimePicker;
    DTP_oTime: TDateTimePicker;
    PrintDBGridEh1: TPrintDBGridEh;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_findClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure btn_print2Click(Sender: TObject);
  private
    { Private declarations }
  public
    recCountInt:Integer;
    { Public declarations }
  end;

var
  frm_sa: Tfrm_sa;

implementation
uses
  Udispatch;

{$R *.dfm}

procedure Tfrm_sa.FormShow(Sender: TObject);
var
  PstationStr,breedStr,OperatorStr:string;
  gsStr:string;
begin
  totals1.Close;
  totals1.CommandText:='select * from OldSwitchyard';
  totals1.Open;
  //
  //到站添加
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  direction_PS from OldSwitchyard';
  FindData.Open;  
  while not FindData.Eof do
  begin
    PstationStr:=FindData.Fields[0].AsString;
    cmbox_dz.Items.Add(PstationStr);
    FindData.Next;
  end;
  //
  //煤种添加
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  breed from OldSwitchyard';
  FindData.Open;  
  while not FindData.Eof do
  begin
    breedStr:=FindData.Fields[0].AsString;
    cmbox_mz.Items.Add(breedStr);
    FindData.Next;
  end;
  //
  //调度员添加
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  OperID from OldSwitchyard';
  FindData.Open;  
  while not FindData.Eof do
  begin
    OperatorStr:=FindData.Fields[0].AsString;
    cmbox_dd.Items.Add(OperatorStr);
    FindData.Next;
  end;
  //
  //钩数添加
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  cumulateConsist from OldSwitchyard';
  FindData.Open;  
  while not FindData.Eof do
  begin
    gsStr:=FindData.Fields[0].AsString;
    cmb_gs.Items.Add(gsStr);
    FindData.Next;
  end;
  //

end;

procedure Tfrm_sa.FormCreate(Sender: TObject);
var
  pClockInt:integer;
  curTimeInt:integer;
  nowTimeStr:WideString;
begin
  //
  DateTimePicker1.Date:=Date-1;
  DateTimePicker2.Date:=Date;
  //
  nowTimeStr:=TimeToStr(now);
  pClockInt:=pos(':',nowTimeStr);
  curTimeInt:=StrToInt(LeftStr(nowTimeStr,pClockInt-1));
  if curTimeInt>18 then
  begin
    DTP_sTime.Time:=StrToTime('18:00:00');
    DTP_oTime.Time:=StrToTime('6:00:00');
  end
  else
  begin
    DTP_sTime.Time:=StrToTime('6:00:00');
    DTP_oTime.Time:=StrToTime('18:00:00');
  end;
  //
  StatusBar1.SimplePanel:=True;
end;

procedure Tfrm_sa.btn_findClick(Sender: TObject);
var
  sqlstr11,sqlstr12,sqlstr13,sqlstr14,sqlstr15:string;
  datestr1,datestr2:string;
  //
  sqlCollocation:integer;
  cmb_dzINT,cmb_mzINT,cmb_ddINT:integer;
begin
  sqlstr11:='select * from OldSwitchyard';
  //
  DataSource1.DataSet:=FindData;
  //
  datestr1:=DateToStr(DateTimePicker1.Date)+' '+TimeToStr(DTP_sTime.Time);
  datestr2:=DateToStr(DateTimePicker2.Date)+' '+TimeToStr(DTP_oTime.Time);

  sqlstr12:=' where past_time between '+''''+datestr1+''''+' and '+''''+datestr2+'''';
  sqlstr13:=' and direction_PS='+''''+cmbox_dz.Text+'''';//到站
  sqlstr14:=' and breed='+''''+cmbox_mz.Text+'''';   //煤种
  sqlstr15:=' and OperID='+''''+cmbox_dd.Text+'''';  //调度员

  //检查高级查询是否选中
  if CheckBox1.Checked then
  begin
    if cmb_gs.Text='' then
    begin
      Exit;
    end;
    FindData.Close;
    FindData.SQL.Clear;
    FindData.SQL.Text:=sqlstr11+' where cumulateConsist='+trim(cmb_gs.Text);
    FindData.Open;
    Exit;
  end;

  //
  if cmbox_dz.Text='' then
  begin
    cmb_dzINT:=1;
  end
  else
  begin
    cmb_dzINT:=2;
  end;
  if cmbox_mz.Text='' then
  begin
    cmb_mzINT:=10;
  end
  else
  begin
    cmb_mzINT:=20;
  end;
  if cmbox_dd.Text='' then
  begin
    cmb_ddINT:=100;
  end
  else
  begin
    cmb_ddINT:=200;
  end;
  
  sqlCollocation:=cmb_dzINT+cmb_mzINT+cmb_ddINT;
  
  case sqlCollocation of
  //到站为空的
  111:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12;
      FindData.Open;
    end;
  211:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr15;
      FindData.Open;
    end;
  121:
     begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr14;
      FindData.Open;
    end;
  221:
     begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr14+sqlstr15;
      FindData.Open;
    end;
  //到站为非空的
  112:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13;
      FindData.Open;
    end;
  212:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13+sqlstr15;
      FindData.Open;
    end;
  122:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13+sqlstr14;
      FindData.Open;
    end;
  222:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13+sqlstr14+sqlstr15;
      FindData.Open;
    end;
  end;

  //
  recCountInt:=FindData.RecordCount;
  StatusBar1.SimpleText:='18点简报：'+datestr1+' 至 '+datestr2
                                +'    共有 '+IntToStr(recCountInt)+' 辆车'
end;

procedure Tfrm_sa.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Label1.Visible:=False;
    Label2.Visible:=False;
    Label4.Visible:=False;
    cmbox_dz.Visible:=False;
    cmbox_mz.Visible:=False;
    cmbox_dd.Visible:=False;
    //
    Label3.Visible:=True;
    cmb_gs.Visible:=True;
  end
  else
  begin
    Label1.Visible:=True;
    Label2.Visible:=True;
    Label4.Visible:=True;
    cmbox_dz.Visible:=True;
    cmbox_mz.Visible:=True;
    cmbox_dd.Visible:=True;
    //
    Label3.Visible:=False;
    cmb_gs.Visible:=False;
  end;
end;

procedure Tfrm_sa.btn_print2Click(Sender: TObject);
begin
//
  PrintDBGridEh1.Preview;
end;

end.
