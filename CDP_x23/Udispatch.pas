unit Udispatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, StrUtils, Grids, DBGrids, Menus, DB, ADODB,
  Mask, DBCtrls, UGeneralADO, Printers, IniFiles, ShellApi, GridsEh,
  DBGridEh, PrnDbgeh;

type
  Thread_readLog = class(TThread)
  private
    m_hInPipe:THandle;
    { Private declarations }
  protected
    procedure readPipeData;
    procedure Execute; override;
    
  end;

type
  Tfrm_main = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Memo_04: TMemo;
    Memo_02: TMemo;
    Memo_07: TMemo;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    Panel5: TPanel;
    Label1: TLabel;
    cmbox_pTime: TComboBox;
    DBGrid1: TDBGrid;
    Panel6: TPanel;
    btn_print: TButton;
    btn_csv: TButton;
    PopupMenu1: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    ADODataSet1: TADODataSet;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    ADODataSet2: TADODataSet;
    add8car: TMenuItem;
    DataSource2: TDataSource;
    Popup2: TPopupMenu;
    del1car: TMenuItem;
    addDispatch: TADOQuery;
    delDispatch: TADOQuery;
    judgmentPtime: TDBEdit;
    add1del: TADOConnection;
    N2: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    Memo_station04: TMemo;
    Memo_station05: TMemo;
    checkCPS_: TTimer;
    ADOQuery_temp1: TADOQuery;
    ADOQuery_temp2: TADOQuery;
    connectMDB: TADOConnection;
    ADODataSet_traintotalh: TADODataSet;
    ADOQuery_Exec: TADOQuery;
    ADODataSet_carNumber: TADODataSet;
    ADODataSet2train_number: TIntegerField;
    ADODataSet2seriary_number: TIntegerField;
    ADODataSet2car_number: TStringField;
    ADODataSet2car_marque: TStringField;
    ADODataSet2carry_weight1: TBCDField;
    ADODataSet2self_weight1: TBCDField;
    ADODataSet2past_time: TWideStringField;
    ADODataSet2outFlag: TWideStringField;
    ADODataSet2sn: TAutoIncField;
    DBGridEh1: TDBGridEh;
    PrintDBGridEh1: TPrintDBGridEh;
    switchyard: TADODataSet;
    switchyardjournalID: TAutoIncField;
    switchyardmineName: TStringField;
    switchyarddirection_PS: TStringField;
    switchyarddirection_SC: TStringField;
    switchyardcar_number: TStringField;
    switchyardcar_marque: TStringField;
    switchyardcarry_weight1: TBCDField;
    switchyardself_weight1: TBCDField;
    switchyardcargo_generalID: TStringField;
    switchyardtonNumber: TBCDField;
    switchyardbreed: TStringField;
    switchyardswitchyardNotepad: TStringField;
    switchyardpast_time: TStringField;
    switchyardseriary_number: TIntegerField;
    Label_Dest: TLabel;
    Panel7: TPanel;
    CHB_heavy: TCheckBox;
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_csvClick(Sender: TObject);
    procedure add8carClick(Sender: TObject);
    procedure del1carClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure checkCPS_Timer(Sender: TObject);
    procedure cmbox_pTimeChange(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
  private
    execpath:string;
    csvPath:string;
    //
    h1:THandle;
    connectStr,colName1,tableName1,exportName1:WideString;
    colCount1:integer;
    //2007.3.5
    currentPtimeStr:WideString;
    periodicityInt:Integer;
    { Private declarations }
  public
    mineCountINT:Integer;
    mineSTR1,mineSTR2,mineSTR3:string;
    CDP_INI:TIniFile;
    //2007.3.5
    function dest(id_masterWStrA:WideString):integer;
    function GetDest(pTimeStrA:WideString):WideString;
    function maxCar_number:integer;
    function maxTrainTotalH:Integer;
    function compareTrain2car_number:Boolean;
    function addTrainOrder(idMaster:integer):Boolean;
    function addCar_nmuber(train_number:integer):Boolean;
    function RefreshPastTimeList(comboBoxX:TComboBox):Integer;
    function viewDataTrain(pTimeStrA:WideString):Integer;
    { Public declarations }
  end;

type
  Tpro_saveFCN=procedure(saveFile1,CheckFilePath:WideString);stdcall;

var
  frm_main: Tfrm_main;

  saveFCNA:Tpro_saveFCN;
  //
  handlers:string;
  xbf:string;
  
implementation
uses
Ulogin,u_about,Udatatotal,Ustation;

function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;
                        external 'XBFGenerate.dll';

function connectNMP:DWORD;stdcall;
     external 'npSupport.dll';
     
{$R *.dfm}

procedure Tfrm_main.N4Click(Sender: TObject);
begin
  frm_about:=Tfrm_about.Create(Application);
  frm_about.Update;
  frm_about.ShowModal;
end;

procedure Tfrm_main.N5Click(Sender: TObject);
begin
  frm_sa:=Tfrm_sa.Create(Application);
  frm_sa.Update;
  frm_sa.ShowModal;
end;

procedure Tfrm_main.N7Click(Sender: TObject);
begin
  frm_station:=Tfrm_station.Create(Application);
  frm_station.Update;
  frm_station.ShowModal;
end;


procedure Tfrm_main.FormCreate(Sender: TObject);
var
  configini:string;
begin
  execpath:=ExtractFilePath(ParamStr(0));
  configini:=execpath+'CDPconfig.ini';
  CDP_INI:=TIniFile.Create(configini);
  csvPath:=execpath+'history\';
  
  if not DirectoryExists(csvPath)then MkDir(csvPath);
  try
    ADOConnection1.Close;
    ADOConnection1.ConnectionString:=readXBF(-1,xbf);
    ADOConnection1.Open;
    add1del.Close;
    add1del.ConnectionString:=readXBF(-1,xbf);
    add1del.Open;
   Except
     Application.MessageBox('数据库位置不对！','提示',MB_OK+MB_ICONINFORMATION);
     Exit;
   end;
  //
  periodicityInt:=CDP_INI.ReadInteger('RunTime','3',0);
  checkCPS_.Interval:=periodicityInt;   
  if checkCPS_.Interval=0 then Exit;
  try
   connectMDB.Close;
   connectMDB.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0'
                              +';Password=""'
                              +';Data Source='+execpath+'VeicRfidCps.mdb'
                              +';Persist Security Info=True';
   connectMDB.Open;
  except
   Application.MessageBox('连接CPS失败，请重试！','提示',MB_OK+MB_ICONINFORMATION);
   Exit;
  end;
end;

procedure Tfrm_main.FormShow(Sender: TObject);
begin
  //
  ADODataSet1.Close;
  ADODataSet1.CommandText:='select OperName from operator where OperID='+opertor;
  ADODataSet1.Open;

  StatusBar1.Panels[1].Text:='调度员:'+ADODataSet1.Fields[0].AsString;
  StatusBar1.Panels[2].Text:='登录时间：'+RightStr(DateTimeToStr(Time),8);

  //Refresh switchyard
  switchyard.Close;
  //switchyard.CommandText:='select * from switchyard';
  switchyard.Open;
  //
  //comboBox Add
  cmbox_pTime.ItemIndex:=RefreshPastTimeList(cmbox_pTime);
  viewDataTrain(cmbox_pTime.Text);
  //
  //read thread
  Thread_readLog.Create(False);
end;


procedure Tfrm_main.btn_csvClick(Sender: TObject);
var
 loop1,recI3:integer;
 ConsistCount,ConsistCount1:integer;
 sqlstr5,sqlstr6,sqlstr7,sqlstr8,sqlstr9:string;
 //
 heavyStr,directionStr:WideString;
 //
 weightFlag:Boolean;
begin
  //退出的几种情况
  if switchyard.RecordCount=0 then Exit;
  ConsistCount:=CDP_INI.ReadInteger('cumulateConsist','2',2);
  ConsistCount1:=CDP_INI.ReadInteger('cumulateConsist','3',2);
  if ConsistCount<>ConsistCount1 then Exit;

  //输出CSV文件
  connectStr:=ADOConnection1.ConnectionString;
  tableName1:='switchyard';

  weightFlag:=CHB_heavy.Checked;
  if weightFlag then heavyStr:='0'
        else heavyStr:='1';

  if Label_Dest.Caption='上行' then directionStr:='0'
        else directionStr:='1';
        
  colName1:='seriary_number,car_marque,car_number,carry_weight1,self_weight1';
  colCount1:=5;

  if weightFlag then exportName1:=csvPath+'datasb0'{+DateTimeToStr(Now)}+'.txt'
                        else exportName1:=csvPath+'datasb1'{+DateTimeToStr(Now)}+'.txt';
  //exportName1:=csvPath+'datasb'{+DateTimeToStr(Now)}+'.txt';
  //
  if FileExists(exportName1) then
  begin
    Application.MessageBox('有数据没有发送，不能进行数据发送！','提示',MB_OK);
    exit;
  end;
  
  if generalCSV(connectStr,IntToStr(ConsistCount),colName1,heavyStr,directionStr,
                        switchyardpast_time.AsString,tableName1,exportName1,colCount1)then
  begin
    h1:=0;
    try
    h1:=LoadLibrary('FCN.dll');

    if h1<>0 then
      @saveFCNA:=GetprocAddress(h1,'saveFCN');
    if (@saveFCNA<>nil)then
      if weightFlag then saveFCNA(csvPath+'datasb0.fcn',exportName1)
                else saveFCNA(csvPath+'datasb1.fcn',exportName1);
      //saveFCNA(csvPath+'datasb.fcn',exportName1);
   finally
     FreeLibrary(h1);
   end;
  end
  else
  begin
    Exit;
  end;
  //Application.MessageBox('形成数据报文成功！', '提示', mb_ok + mb_iconinformation);
  //把dispatchTemplate表的数据添加到TotalTable表中

  recI3:=switchyard.RecordCount;
  for loop1:=0 to recI3-1 do
  begin
    //

    sqlstr5:='insert into OldSwitchyard';
    sqlstr6:=' (journalID,mineName,direction_PS,direction_SC,car_marque,car_number,'
        +'carry_weight1,self_weight1,cargo_generalID,tonNumber,breed,past_time,'
        +'switchyardNotepad,seriary_number,cumulateConsist,OperID)';
    sqlstr7:=' values('+IntToStr(switchyardjournalID.Value)+','
                        +''''+switchyardmineName.Text+''''+','
                        +''''+switchyarddirection_PS.Text+''''+','
                        +''''+switchyarddirection_SC.Text+''''+','
                        +''''+switchyardcar_marque.Text+''''+','
                        +''''+switchyardcar_number.Text+''''+','
                        +switchyardcarry_weight1.Text+','
                        +switchyardself_weight1.Text; 
    sqlstr8:=','+''''+switchyardcargo_generalID.Text+''''+','
                        +FloatToStr(switchyardtonNumber.Value)+','
                        +''''+switchyardbreed.Text+''''+','
                        +''''+switchyardpast_time.Text+''''+','
                        +''''+switchyardswitchyardNotepad.Text+''''+','
                        +IntToStr(switchyardseriary_number.Value);
    sqlstr9:=','+IntToStr(ConsistCount)+','+''''+opertor+'''';
    //
    try
      add1del.BeginTrans;
      delDispatch.Close;
      delDispatch.SQL.Clear;
      delDispatch.SQL.Text:=sqlstr5+sqlstr6+sqlstr7+sqlstr8+sqlstr9+')';
      delDispatch.ExecSQL;
      add1del.CommitTrans;
      //dispatchTemplate.Delete;
      addDispatch.Close;
      addDispatch.SQL.Clear;
      addDispatch.SQL.Text:='delete from switchyard where journalID='
                                        +IntToStr(switchyardjournalID.Value);
      addDispatch.ExecSQL;

      switchyard.Close;
      switchyard.Open;
    except
      add1del.RollbackTrans;
      CDP_INI.WriteString('RunTime','2',DateToStr(now));
      Application.MessageBox('数据上报失败！','提示',MB_OK);
      Exit;
    end;

  end;//for end;
  CDP_INI.WriteInteger('cumulateConsist','2',ConsistCount+1);//增加计数
  CDP_INI.WriteInteger('cumulateConsist','3',ConsistCount+1);
  //
  StatusBar1.Panels[0].Text:='共有 '+IntToStr(recI3)+' 条数据上报成功！'
end;

procedure Tfrm_main.add8carClick(Sender: TObject);
var
  sqlstr1,sqlstr2:string;
  carX,carN,time2:string;
  //
  snCarStr:WideString;
  notepadStr:WideString;
begin
  //
  if DataSource1.DataSet.IsEmpty then Exit;
  snCarStr:=ADODataSet2seriary_number.AsString;
  carX:=ADODataSet2car_marque.Value;
  carN:=ADODataSet2car_number.Value;
  time2:=ADODataSet2past_time.Value;
  //
  notepadStr:='过车时间：'+time2+' 辆序：'+snCarStr;
  //
  sqlstr1:='insert into switchyard(seriary_number,car_marque,car_number,'
        +'carry_weight1,self_weight1,past_time,switchyardNotepad)';
  sqlstr2:=' values('+snCarStr+','+''''+carX+''''+','+''''+carN+''''+','
        +FloatToStr(ADODataSet2carry_weight1.Value)+','
        +FloatToStr(ADODataSet2self_weight1.Value)+','
        +''''+time2+''''+','
        +''''+notepadStr+'''';

  //判断过车时间是否是添加的过车时间
  if (judgmentPtime.Text<>currentPtimeStr)and(judgmentPtime.Text<>'') then
  begin
    Exit;
  end;
  
  try
    addDispatch.Close;
    addDispatch.SQL.Clear;
    addDispatch.SQL.Text:=sqlstr1+sqlstr2+')';
    addDispatch.ExecSQL;

    delDispatch.Close;
    delDispatch.SQL.Clear;
    delDispatch.SQL.Text:='delete from trainOrder where sn='+IntToStr(ADODataSet2sn.Value);;
    delDispatch.ExecSQL;

    switchyard.Close;
    switchyard.Open;
    //
    StatusBar1.Panels[0].Text:='共有 '
                          +IntToStr(viewDataTrain(currentPtimeStr))+' 辆车';
  except
    Application.MessageBox('添加编车组失败！','提示',MB_OK);
    Exit;
  end;

end;

procedure Tfrm_main.del1carClick(Sender: TObject);
var
  sqlstr3,sqlstr4,sqlstr5:string;
  carX,carN,time2:string;
  //
  carryWF,selfWF:Double;
  seriary_numberInt:integer;
begin
  //
  if switchyard.RecordCount=0 then Exit;

  if currentPtimeStr='' then
  begin
    Exit;
  end;

  //
  carX:=switchyardcar_marque.Value;
  carN:=switchyardcar_number.Value;
  time2:=switchyardpast_time.Value;
  carryWF:=switchyardcarry_weight1.Value;
  selfWF:=switchyardself_weight1.Value;
  seriary_numberInt:=switchyardseriary_number.Value;

  sqlstr3:='insert into trainOrder';
  sqlstr4:=' (car_marque,car_number,carry_weight1,self_weight1,seriary_number,past_time)';
  sqlstr5:=' values('+''''+carX+''''+','+''''+carN+''''+','
        +FloatToStr(carryWF)+','
        +FloatToStr(selfWF)+','
        +IntToStr(seriary_numberInt);
  //判断过车时间是否是添加的过车时间
  if judgmentPtime.Text<>currentPtimeStr then
  begin
    Exit;
  end;
  //
  try
    addDispatch.Close;
    addDispatch.SQL.Clear;
    addDispatch.SQL.Text:=sqlstr3+sqlstr4+sqlstr5+','+''''+time2+''''+')';
    addDispatch.ExecSQL;
    //
    delDispatch.Close;
    delDispatch.SQL.Clear;
    delDispatch.SQL.Text:='delete from switchyard where journalID='
                                +IntToStr(switchyardjournalID.Value);;
    delDispatch.ExecSQL;

    switchyard.Close;
    switchyard.Open;
  except
    Application.MessageBox('删除编车组失败！','提示',MB_OK);
    Exit;
  end;
  //
  StatusBar1.Panels[0].Text:='共有 '
                        +IntToStr(viewDataTrain(currentPtimeStr))+' 辆车';  
end;

procedure Tfrm_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CDP_INI.Destroy;
  delDispatch.Close;
  delDispatch.SQL.Clear;
  delDispatch.SQL.Text:='update operator set preserve1=0 where OperID='+opertor;
  delDispatch.ExecSQL;
end;

//2007.3.5 xiaobin add code
//because switchyard
//below code from sinopec_sjz.dpr in the DataModule 
function Tfrm_main.maxCar_number:integer;
var
  car_NO:Integer;
begin
  ADOQuery_temp1.Close;
  ADOQuery_temp1.SQL.Clear;
  ADOQuery_temp1.SQL.Text:='select Max(train_number) from car_number';
  ADOQuery_temp1.Open;

  car_NO:=ADOQuery_temp1.Fields[0].AsInteger;

  Result:=car_NO;
end;

function Tfrm_main.maxTrainTotalH:Integer;
var
  train_NO:integer;
begin
  ADOQuery_temp2.Close;
  ADOQuery_temp2.SQL.Clear;
  ADOQuery_temp2.SQL.Text:='select Max(id_master) from traintotalh';
  ADOQuery_temp2.Open;

  train_NO:=ADOQuery_temp2.Fields[0].AsInteger;

  Result:=train_NO;
end;

function Tfrm_main.dest(id_masterWStrA:WideString):integer;
var
  destInt:integer;
  //outFlagStr:WideString;
begin
  ADOQuery_temp2.Close;
  ADOQuery_temp2.SQL.Clear;
  ADOQuery_temp2.SQL.Text:='select DISTINCT destination from trainmaster where id_master='
                        +id_masterWStrA;
  ADOQuery_temp2.Open;

  destInt:=ADOQuery_temp2.Fields[0].AsInteger;

  Result:=destInt;
end;

function Tfrm_main.compareTrain2car_number:Boolean;
begin
  if maxTrainTotalH-maxCar_number=0 then
  begin
    Result:=False;
  end
  else
  begin
    Result:=True;
  end;
end;

function Tfrm_main.addTrainOrder(idMaster:integer):Boolean;
var
  recI2,I2:Integer;
  snStr,cNumStr,tNumStr,cMarqueStr:WideString;
  lableweightStr,selfweightStr:WideString;
  //
  outFlagStr:WideString;
  time_rportStr:WideString;
begin
  //
  ADODataSet_traintotalh.Close;
  ADODataSet_traintotalh.CommandText:='select train_no,number,id_master,'
                        +'time_report,type,lableweight,selfweight'
                        +' from traintotalh where id_master>'
                        +''+IntToStr(idMaster)+'';
  ADODataSet_traintotalh.Open;
  //
  recI2:=ADODataSet_traintotalh.RecordCount;
  //
  for I2:=0 to recI2-1 do
  begin
    snStr:=ADODataSet_traintotalh.Fields[0].AsString;
    cNumStr:=ADODataSet_traintotalh.Fields[1].AsString;
    time_rportStr:=ADODataSet_traintotalh.Fields[3].AsString;
    cMarqueStr:=ADODataSet_traintotalh.Fields[4].AsString;
    lableweightStr:=ADODataSet_traintotalh.Fields[5].AsString;
    selfweightStr:=ADODataSet_traintotalh.Fields[6].AsString;
    //
    tNumStr:=ADODataSet_traintotalh.FieldByName('id_master').AsString;
    if dest(tNumStr)=0 then outFlagStr:='up'
          else outFlagStr:='down';     
    //insert trainOrder
    ADOQuery_Exec.Close;
    ADOQuery_Exec.SQL.Clear;
    ADOQuery_Exec.SQL.Text:='INSERT INTO trainOrder(seriary_number,car_number,'
        +'train_number,past_time,car_marque,carry_weight1,self_weight1,outFlag'
        +') values('
        +''+snStr+''+','+''''+cNumStr+''''+','+''+tNumStr+''+','
        +''''+time_rportStr+''''+','
        +''''+cMarqueStr+''''+','
        +lableweightStr+','
        +selfweightStr+','
        +''''+outFlagStr+''''
        +')';
    ADOQuery_Exec.ExecSQL;
      
    ADODataSet_traintotalh.Next;
  end;

  Result:=True;
end;

function Tfrm_main.addCar_nmuber(train_number:integer):Boolean;
var
  recI3,I3:Integer;
  snStr,cNumStr,tNumStr,cMarqueStr:WideString;
  //
  past_timeStr:WideString;
begin
 //
  ADODataSet_carNumber.Close;
  ADODataSet_carNumber.CommandText:='select seriary_number,car_number,'
                        +'train_number,past_time,car_marque from trainOrder'
                        +' where train_number>'
                        +''+IntToStr(train_number)+'';
  ADODataSet_carNumber.Open;
  //
  recI3:=ADODataSet_carNumber.RecordCount;
  for I3:=0 to recI3-1 do
  begin
    snStr:=ADODataSet_carNumber.Fields[0].AsString;
    cNumStr:=ADODataSet_carNumber.Fields[1].AsString;
    tNumStr:=ADODataSet_carNumber.Fields[2].AsString;
    past_timeStr:=ADODataSet_carNumber.Fields[3].AsString;
    cMarqueStr:=ADODataSet_carNumber.Fields[4].AsString;
    //insert Car_nmuber
    ADOQuery_Exec.Close;
    ADOQuery_Exec.SQL.Clear;
    ADOQuery_Exec.SQL.Text:='INSERT INTO Car_number(seriary_number,car_number,'
                        +'train_number,past_time,car_marque) values('
                        +''+snStr+''+','+''''+cNumStr+''''+','+''+tNumStr+''+','
                        +''''+past_timeStr+''''+','
                        +''''+cMarqueStr+''''+')';
    ADOQuery_Exec.ExecSQL;
      
    ADODataSet_carNumber.Next;
  end;

  Result:=True;
end;

function Tfrm_main.RefreshPastTimeList(comboBoxX:TComboBox):Integer;
var
  I1,recI1:integer;
  pTimeStr:WideString;
begin
  //2007.8.5 add clear combobox
  comboBoxX.Items.Clear;
  //
  ADOQuery_Exec.Close;
  ADOQuery_Exec.SQL.Clear;
  ADOQuery_Exec.SQL.Text:='select DISTINCT past_time,train_number from trainOrder'
                                +' order by train_number';
  ADOQuery_Exec.Open;

  recI1:=ADOQuery_Exec.RecordCount;
  for I1:=0 to recI1-1 do
  begin
    pTimeStr:=ADOQuery_Exec.FieldByName('past_time').AsString;
    comboBoxX.Items.Add(pTimeStr);
    ADOQuery_Exec.Next;
  end;
  Result:=recI1-1;
end;

function Tfrm_main.viewDataTrain(pTimeStrA:WideString):Integer;
var
  recI2:Integer;
begin
  ADODataSet2.Close;
  ADODataSet2.CommandText:='select train_number,seriary_number,car_number,car_marque,'
                        +'carry_weight1,self_weight1,past_time,outFlag,sn'
                        +' from trainOrder where past_time='
                        +''''+pTimeStrA+''''
                        +' order by seriary_number';
  ADODataSet2.Open;

  recI2:=ADODataSet2.RecordCount;
  Result:=recI2;
end;

function Tfrm_main.GetDest(pTimeStrA:WideString):WideString;
begin
  ADOQuery_Exec.Close;
  ADOQuery_Exec.SQL.Clear;
  ADOQuery_Exec.SQL.Text:='select outFlag from trainOrder where past_time='
                        +''''+pTimeStrA+'''';
  ADOQuery_Exec.Open;

  Result:=ADOQuery_Exec.Fields[0].AsString;
end;

procedure Tfrm_main.cmbox_pTimeChange(Sender: TObject);
var
  strlist:TStringList;
  sq:string;
  //
  destinationStr:WideString;
  strListMine:TStringList;
begin
  currentPtimeStr:=cmbox_pTime.Text;
  StatusBar1.Panels[0].Text:='共有 '
                        +IntToStr(viewDataTrain(currentPtimeStr))+' 辆车';
  //
  ADODataSet1.Close;
  ADODataSet1.CommandText:='select Jan from arrivestation';
  ADODataSet1.Open;
  strlist:=TStringList.Create;
  while not ADODataSet1.Eof do
  begin
    sq:=ADODataSet1.Fields[0].AsString;
    strlist.Add(sq);
    ADODataSet1.Next;
  end;

  DBGridEh1.Columns[1].PickList:=strlist;
  //
  strListMine:=TStringList.Create;


  mineCountINT:=CDP_INI.ReadInteger('mineCount','1',3);
  case mineCountINT of
    1:
      begin
        mineSTR1:=CDP_INI.ReadString('mineName','1','my1');
        strListMine.Add(mineSTR1);
      end;
    2:
      begin
        mineSTR1:=CDP_INI.ReadString('mineName','1','my1');
        mineSTR2:=CDP_INI.ReadString('mineName','2','my2');
        strListMine.Add(mineSTR1);
        strListMine.Add(mineSTR2);
      end;
    3:
      begin
        mineSTR1:=CDP_INI.ReadString('mineName','1','my1');
        mineSTR2:=CDP_INI.ReadString('mineName','2','my2');
        mineSTR3:=CDP_INI.ReadString('mineName','3','my3');
        strListMine.Add(mineSTR1);
        strListMine.Add(mineSTR2);
        strListMine.Add(mineSTR3);
      end;
    end;
  DBGridEh1.Columns[0].PickList:=strListMine;
  //
  destinationStr:=GetDest(currentPtimeStr);
  if destinationStr='up' then
  begin
    Label_Dest.Font.Color:=clGreen;
    Label_Dest.Caption:='上行';
  end
  else
  begin
    Label_Dest.Font.Color:=clBlue;
    Label_Dest.Caption:='下行';
  end;
end;

procedure Tfrm_main.btn_printClick(Sender: TObject);
begin
  PrintDBGridEh1.Preview;
end;

procedure Tfrm_main.checkCPS_Timer(Sender: TObject);
begin
  if compareTrain2car_number then
  begin
    StatusBar1.Panels[0].Text:='检测到新数据';
    addTrainOrder(maxCar_number);
    addCar_nmuber(maxCar_number);
    cmbox_pTime.ItemIndex:=RefreshPastTimeList(cmbox_pTime);
    currentPtimeStr:=cmbox_pTime.Text;
    viewDataTrain(currentPtimeStr);
  end;
end;

///////////////////////////////////////////////////THREAD
procedure Thread_readLog.readPipeData;
var
  readSuccess:Boolean;
  readBuf:array[0..253]of char;
  cbBytesRead:DWORD;
  //msg
  msgStr:WideString;
  msgLen:integer;
begin
  //
  readBuf:='';
  readSuccess:= ReadFile(m_hInPipe,
      readBuf,
      254,
      cbBytesRead,
      nil);
  if readSuccess=true then
  begin
   if readBuf<>'' then
   begin
     msgStr:=readBuf;
     msgLen:=length(msgStr);
     msgStr:=RightStr(msgStr,msgLen-1);
     frm_main.StatusBar1.Panels[0].Text:=msgStr;
     frm_main.cmbox_pTime.ItemIndex:=frm_main.RefreshPastTimeList(frm_main.cmbox_pTime);
     frm_main.currentPtimeStr:=frm_main.cmbox_pTime.Text;
     frm_main.viewDataTrain(frm_main.currentPtimeStr);
   end;
  end;
end;

procedure Thread_readLog.Execute;
begin
  m_hInPipe:=connectNMP;
  while m_hInPipe<>0 do
  begin
    readPipeData;
  end;
end;

end.
