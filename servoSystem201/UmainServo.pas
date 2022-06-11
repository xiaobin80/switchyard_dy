//****************************************************************************//
//******     unit name:UmainServo.pas                                   ******//
//******     purpose  :convert any data to My use DB                    ******//
//******     author   :Guibin.Li                                        ******//
//******     date     :2007.05.19                                       ******//
//******     copyright (c) 2022 TDTC Corporation all proprietary        ******//
//****************************************************************************//

unit UmainServo;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, DB, ADODB, Inifiles, Menus,
  StdCtrls, ExtCtrls, jpeg;

type
  Pipe_writeData = class(TThread)
  private
    msgLog1:WideString;
    //NMP parameter
    m_hOutPipe:THandle;
    { Private declarations }
  protected
    //NMP procedure
    procedure writePipeData(msg:WideString);
    procedure Execute; override;
  public
    constructor Create(flag:Boolean;NMP_handle:DWORD;msgLog:WideString);
  end;

type
  TfrmServoMain = class(TForm)
    Timer1: TTimer;
    pnlLeft1: TPanel;
    imgSs: TImage;
    pnlRside: TPanel;
    pnlLside: TPanel;
    pnlMain: TPanel;
    pnlBside: TPanel;
    btnClose: TButton;
    memoLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    //log information
    logStrInf:WideString;
    logPathWstr:WideString;
    //
    xbfini:TIniFile;    
    richstring:TStringList;
    ADODataSetX,ADODataSetMDB_1,ADODataSetMDB_2:TADODataSet;
    ADOQuery_Exec:TADOQuery;
    { Private declarations }
  public
    connectStrA,connectStrMDB:WideString;
    ADOConnectX:TADOConnection;
    ADOConnectMDB:TADOConnection;
    //NMP handle
    hPipe:DWORD;
    //
    parade1:integer;
    periodicityInt:Integer;
    //
    procedure DISservo;
    //
    function maxCar_number(ADOQueryXA:TADOQuery):integer;
    function maxTrainTotalH(ADODataSetMDB2:TADODataSet):Integer;
    function compareTrain2car_number(ADODataSetMDB2:TADODataSet;
                                                ADOQueryXA:TADOQuery):Boolean;
    function dest(ADODataSetXA:TADODataSet;id_masterWStrA:WideString):integer;
    function addTrainOrder(ADODataSetMDB1,ADODataSetMDB2:TADODataSet;
                                ADOQueryXA:TADOQuery;idMaster:integer):Boolean;
    function myExecSQL(ADOQueryXA:TADOQuery;sqlWStrA:WideString):Boolean;
    function addCar_nmuber(ADODataSetXA:TADODataSet;
                                ADOQueryXA:TADOQuery;train_number:integer):Boolean;
    function writeLogFun:Boolean;
    //
    function CreateADOConnectA(var ADOConnect1:TADOConnection;var connStr:WideString):Boolean;
    function DestoryADOConnectA(var ADOConnect1:TADOConnection):Boolean;    
    { Public declarations }
  protected
    procedure WndProc(var Message : TMessage); override;

  end;

var
  frmServoMain: TfrmServoMain;

  function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;
                        external 'XBFGenerate.dll';

  function createNMP:DWORD;stdcall;
     external 'npSupport.dll';

implementation

{$R *.dfm}

function TfrmServoMain.CreateADOConnectA(var ADOConnect1:TADOConnection;
                                                var connStr:WideString):Boolean;
begin
  try
    ADOConnect1:=TADOConnection.Create(nil);
    ADOConnect1.LoginPrompt:=False;
    ADOConnect1.ConnectionString:=connStr;
    
    Result:=True;
  except
    Result:=False;
  end;

end;

function TfrmServoMain.DestoryADOConnectA(var ADOConnect1:TADOConnection):Boolean;
begin
  try
    ADOConnect1.Close;
    ADOConnect1.Free;

    Result:=True;
  except
    Result:=False;
    ADOConnect1.Destroy;
  end;
  
end;

procedure TfrmServoMain.FormCreate(Sender: TObject);
var
  xbffilepath:string;
  xbfname:string;  
  //h1:THandle;
begin
  //h1:=0;
  xbfini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'servoSys.ini');

  xbfname:=ExtractFilePath(ParamStr(0))+xbfini.ReadString('file name','1','');
  xbffilepath:=xbfini.ReadString('file path','9','');
  try
    connectStrMDB:='Provider=Microsoft.Jet.OLEDB.4.0'
                +';Password=""'
                +';Data Source='+xbffilepath
                +';Persist Security Info=True';
    connectStrA:=readXBF(-1,xbfname);
    //
    CreateADOConnectA(ADOConnectMDB,connectStrMDB);
    CreateADOConnectA(ADOConnectX,connectStrA)
  except
    Application.MessageBox('servoSystem connect DB fail!','HINT',MB_OK);
    Application.Terminate;
  end;

  //NMP
  hPipe:=createNMP;
  //timer
  periodicityInt:=xbfini.ReadInteger('undo','clock',15000);
  Timer1.Interval:=periodicityInt;
end;

//
function TfrmServoMain.dest(ADODataSetXA:TADODataSet;id_masterWStrA:WideString):integer;
var
  destInt:integer;
begin
  ADODataSetXA.Close;
  ADODataSetXA.CommandText:='';
  ADODataSetXA.CommandText:='select DISTINCT destination from trainmaster where id_master='
                        +id_masterWStrA;
  ADODataSetXA.Open;

  destInt:=ADODataSetXA.Fields[0].AsInteger;

  Result:=destInt;
end;

function TfrmServoMain.myExecSQL(ADOQueryXA:TADOQuery;sqlWStrA:WideString):Boolean;
begin
  ADOQueryXA.Close;
  ADOQueryXA.SQL.Clear;
  ADOQueryXA.SQL.Text:=sqlWStrA;
  ADOQueryXA.ExecSQL;

  Result:=True;
end;

function TfrmServoMain.addTrainOrder(ADODataSetMDB1,ADODataSetMDB2:TADODataSet;
                                ADOQueryXA:TADOQuery;idMaster:integer):Boolean;
var
  recI2,I2:Integer;
  snStr,cNumStr,tNumStr,cMarqueStr:WideString;
  lableweightStr,selfweightStr:WideString;
  //
  outFlagStr:WideString;
  time_rportStr:WideString;
  //
  sqlTempStr:WideString;
begin
  //
  ADODataSetMDB1.Close;
  ADODataSetMDB1.CommandText:='select train_no,number,id_master,'
                        +'time_report,type,lableweight,selfweight'
                        +' from traintotalh where id_master>'
                        +''+IntToStr(idMaster)+'';
  ADODataSetMDB1.Open;
  //
  recI2:=ADODataSetMDB1.RecordCount;
  //
  for I2:=0 to recI2-1 do
  begin
    snStr:=ADODataSetMDB1.Fields[0].AsString;
    cNumStr:=ADODataSetMDB1.Fields[1].AsString;
    time_rportStr:=ADODataSetMDB1.Fields[3].AsString;
    cMarqueStr:=ADODataSetMDB1.Fields[4].AsString;
    lableweightStr:=ADODataSetMDB1.Fields[5].AsString;
    selfweightStr:=ADODataSetMDB1.Fields[6].AsString;
    //
    tNumStr:=ADODataSetMDB1.FieldByName('id_master').AsString;
    if dest(ADODataSetMDB2,tNumStr)=0 then outFlagStr:='up'
          else outFlagStr:='down';     
    //insert trainOrder
    sqlTempStr:='INSERT INTO trainOrder(seriary_number,car_number,'
        +'train_number,past_time,car_marque,carry_weight1,self_weight1,outFlag'
        +') values('
        +''+snStr+''+','+''''+cNumStr+''''+','+''+tNumStr+''+','
        +''''+time_rportStr+''''+','
        +''''+cMarqueStr+''''+','
        +lableweightStr+','
        +selfweightStr+','
        +''''+outFlagStr+''''
        +')';
    myExecSQL(ADOQueryXA,sqlTempStr);
      
    ADODataSetMDB1.Next;
  end;

  Result:=True;
end;

function TfrmServoMain.addCar_nmuber(ADODataSetXA:TADODataSet;
                                ADOQueryXA:TADOQuery;train_number:integer):Boolean;
var
  recI3,I3:Integer;
  snStr,cNumStr,tNumStr,cMarqueStr:WideString;
  //
  past_timeStr:WideString;
  //
  sqlTempStr:WideString;
begin
 //
  ADODataSetXA.Close;
  ADODataSetXA.CommandText:='select seriary_number,car_number,'
                        +'train_number,past_time,car_marque from trainOrder'
                        +' where train_number>'
                        +''+IntToStr(train_number)+'';
  ADODataSetXA.Open;
  //
  recI3:=ADODataSetXA.RecordCount;
  for I3:=0 to recI3-1 do
  begin
    snStr:=ADODataSetXA.Fields[0].AsString;
    cNumStr:=ADODataSetXA.Fields[1].AsString;
    tNumStr:=ADODataSetXA.Fields[2].AsString;
    past_timeStr:=ADODataSetXA.Fields[3].AsString;
    cMarqueStr:=ADODataSetXA.Fields[4].AsString;
    //insert Car_nmuber
    sqlTempStr:='INSERT INTO Car_number(seriary_number,car_number,'
                        +'train_number,past_time,car_marque) values('
                        +''+snStr+''+','+''''+cNumStr+''''+','+''+tNumStr+''+','
                        +''''+past_timeStr+''''+','
                        +''''+cMarqueStr+''''+')';
    myExecSQL(ADOQueryXA,sqlTempStr);
      
    ADODataSetXA.Next;
  end;

  Result:=True;
end;
//
function TfrmServoMain.maxCar_number(ADOQueryXA:TADOQuery):integer;
var
  car_NO:Integer;
begin
  ADOQueryXA.Close;
  ADOQueryXA.SQL.Clear;
  ADOQueryXA.SQL.Text:='select Max(train_number) from car_number';
  ADOQueryXA.Open;

  car_NO:=ADOQueryXA.Fields[0].AsInteger;

  Result:=car_NO;
end;

function TfrmServoMain.maxTrainTotalH(ADODataSetMDB2:TADODataSet):Integer;
var
  train_NO:integer;
begin
  ADODataSetMDB2.Close;
  ADODataSetMDB2.CommandText:='';
  ADODataSetMDB2.CommandText:='select Max(id_master) from traintotalh';
  ADODataSetMDB2.Open;

  train_NO:=ADODataSetMDB2.Fields[0].AsInteger;

  Result:=train_NO;
end;


function TfrmServoMain.compareTrain2car_number(ADODataSetMDB2:TADODataSet;
                                                ADOQueryXA:TADOQuery):Boolean;
begin
  if maxTrainTotalH(ADODataSetMDB2)-maxCar_number(ADOQueryXA)=0 then
  begin
    Result:=False;
  end
  else
  begin
    Result:=True;
  end;
end;

procedure TfrmServoMain.Timer1Timer(Sender: TObject);
begin
  DISservo;
end;

procedure TfrmServoMain.DISservo;
begin
  ADODataSetX:=TADODataSet.Create(nil);
  ADODataSetMDB_1:=TADODataSet.Create(nil);
  ADODataSetMDB_2:=TADODataSet.Create(nil);
  ADOQuery_Exec:=TADOQuery.Create(nil);
  if CreateADOConnectA(ADOConnectX,connectStrA)=false then
  begin
    CreateADOConnectA(ADOConnectX,connectStrA);
  end;
  if CreateADOConnectA(ADOConnectMDB,connectStrMDB)=false then
  begin
    CreateADOConnectA(ADOConnectMDB,connectStrMDB);
  end;
  ADODataSetMDB_1.Connection:=ADOConnectMDB;
  ADODataSetMDB_2.Connection:=ADOConnectMDB;
  ADODataSetX.Connection:=ADOConnectX;
  ADOQuery_Exec.Connection:=ADOConnectX;
  //
  if compareTrain2car_number(ADODataSetMDB_2,ADOQuery_Exec) then
  begin
    addTrainOrder(ADODataSetMDB_1,ADODataSetMDB_2,ADOQuery_Exec,maxCar_number(ADOQuery_Exec));
    addCar_nmuber(ADODataSetX,ADOQuery_Exec,maxCar_number(ADOQuery_Exec));
    //NMP msg
    logStrInf:=DateTimeToStr(Now)+': senseing new data...';
    //NMP create
    Pipe_writeData.Create(False,hPipe,logStrInf);    
  end;
  //process lock
  ADODataSetMDB_1.Connection:=nil;
  ADODataSetMDB_2.Connection:=nil;
  ADODataSetX.Connection:=nil;
  ADOQuery_Exec.Connection:=nil;
  //free and nil
  FreeAndNil(richstring);
  FreeAndNil(ADODataSetMDB_1);
  FreeAndNil(ADODataSetMDB_2);
  FreeAndNil(ADODataSetX);
  FreeAndNil(ADOQuery_Exec);
  FreeAndNil(ADOConnectX);
  FreeAndNil(ADOConnectMDB);

end;

////write Thread Exec
procedure Pipe_writeData.writePipeData(msg:WideString);
var
  //wStr:array[0..253]of char;
  wStr:string[254];
  lenStr:DWORD;
  dwSent:DWORD;
  sendS:Boolean;
  //
  logStrInf_thread:WideString;
begin
  if msg<>'' then
  begin
    wStr:=msg;
    lenStr:=length(wStr)+1;
    sendS:=WriteFile(m_hOutPipe,
          wStr,
          lenStr,
          dwSent,
          nil);
    if (sendS=false) or (lenStr<>dwSent) then
    begin
      //CloseHandle(m_hOutPipe);
      frmServoMain.memoLog.Lines.Add(DateTimeToStr(Now)+': disconnect NMP');
      DisconnectNamedPipe(m_hOutPipe);
      ConnectNamedPipe(m_hOutPipe,nil);
      frmServoMain.memoLog.Lines.Add(DateTimeToStr(Now)+': recast connect NMP');
      //reset connect NMP
      logStrInf_thread:=DateTimeToStr(Now)+': reset connect...';
      //NMP create
      Pipe_writeData.Create(False,m_hOutPipe,logStrInf_thread);
    end;
  end;
end;

constructor Pipe_writeData.Create(flag:Boolean;NMP_handle:DWORD;msgLog:WideString);
begin
  inherited Create(False);
  msgLog1:=msgLog;
  frmServoMain.memoLog.Lines.Add(msgLog1);
  m_hOutPipe:=NMP_handle;
end;

procedure Pipe_writeData.Execute;
begin
  {while m_hOutPipe<>0 do
  begin
    if msgLog1<>'' then
    begin}
      writePipeData(msgLog1);
    {end;
  end;}

end;

//
function TfrmServoMain.writeLogFun:Boolean;
var
  CStrTemp:TStringList;
begin
  memoLog.Lines.Add(DateTimeToStr(now)+': Quit ServoSystem');
  logPathWstr:=ExtractFilePath(ParamStr(0))+'servoSys.log';
  CStrTemp:=TStringList.Create;
  //
  if FileExists(logPathWstr)then
  begin
    CStrTemp.LoadFromFile(logPathWstr);
  end
  else
  begin
    CStrTemp.Add('           *****************************************');
    CStrTemp.Add('           ***  Cationsoft ServoSystem Log File  ***');
    CStrTemp.Add('           *****************************************');
    CStrTemp.Add(EmptyStr);
    CStrTemp.Add(EmptyStr);
  end;
  CStrTemp.AddStrings(memoLog.Lines);
  CStrTemp.Add(EmptyStr);
  CStrTemp.Add('==============================================================');
  CStrTemp.SaveToFile(logPathWstr);  
  //
  CStrTemp.Destroy;
  //
  Result:=True;
end;

procedure TfrmServoMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

//acquire system message(wm_close) course self is method 
procedure TfrmServoMain.WndProc(var Message: TMessage);
begin
  if Message.Msg=$0011 then
  begin
    if hPipe<>0 then
    begin
      DisconnectNamedPipe(hPipe);//disconnect NP
      CloseHandle(hPipe);
    end;  
    writeLogFun;
  end;
  inherited WndProc(Message);
end;

end.
