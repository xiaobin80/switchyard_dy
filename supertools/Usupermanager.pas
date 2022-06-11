unit Usupermanager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Grids, DBGrids, StdCtrls, DB, ADODB, jpeg, IniFiles;

type
  Tfrm_supermanager = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    clearTAG: TADOQuery;
    ADOConnection1: TADOConnection;
    Panel3: TPanel;
    Image1: TImage;
    btnData: TButton;
    btnFile: TButton;
    btn_app: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnDataClick(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure btn_appClick(Sender: TObject);
  private
    count1:integer;
    { Private declarations }
  public
    xbf:string;
    inipath:string;
    myIni:TIniFile;
    { Public declarations }
  end;

var
  frm_supermanager: Tfrm_supermanager;

  handlers:string;
implementation
  
function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;
                        external 'XBFGenerate.dll';

{$R *.dfm}

procedure Tfrm_supermanager.FormShow(Sender: TObject);
begin
  ADODataSet1.Close;
  ADODataSet1.Open;
  count1:=myIni.ReadInteger('cumulateConsist','1',43);
  //
  try
    clearTAG.Close;
    clearTAG.SQL.Clear;
    clearTAG.SQL.Text:='update operator set preserve1=0 where preserve1=1';
    clearTAG.ExecSQL;
  except

  end;
end;

procedure Tfrm_supermanager.Button1Click(Sender: TObject);
begin
  DBGrid1.ReadOnly:=False;
  ADODataSet1.Edit;
  Button2.Enabled:=True;
end;

procedure Tfrm_supermanager.Button2Click(Sender: TObject);
begin
  try
    ADODataSet1.Post;
    DBGrid1.ReadOnly:=True;
    count1:=count1+1;
    myIni.WriteInteger('cumulateConsist','1',count1);
    if count1=911 then Panel3.Visible:=True;
    Application.MessageBox('����ɹ���','��ʾ',MB_OK); 
  except
    Application.MessageBox('����ʧ�ܣ�','��ʾ',MB_OK);
    Exit;
  end;
end;

procedure Tfrm_supermanager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure Tfrm_supermanager.FormCreate(Sender: TObject);
begin
  xbf:=ExtractFilePath(ParamStr(0))+'zlnr1.xbf';
  inipath:=ExtractFilePath(ParamStr(0))+'CDPconfig.ini';
  ADOConnection1.Close;
  ADOConnection1.ConnectionString:=readXBF(-1,xbf);
  ADOConnection1.Open;
  myIni:=TIniFile.Create(inipath);
end;

procedure Tfrm_supermanager.btnDataClick(Sender: TObject);
begin
  clearTAG.Close;
  clearTAG.SQL.Clear;
  clearTAG.SQL.Text:='truncate table trainOrder';
  clearTAG.ExecSQL;

  clearTAG.Close;
  clearTAG.SQL.Clear;
  clearTAG.SQL.Text:='truncate table switchyard';
  clearTAG.ExecSQL;
  
  Application.MessageBox('���ݳ�ʼ����ɣ�','��ʾ',MB_OK+MB_ICONINFORMATION);
  Exit;
end;

procedure Tfrm_supermanager.btnFileClick(Sender: TObject);
begin
  myIni.WriteInteger('cumulateConsist','2',1);
  myIni.WriteInteger('cumulateConsist','3',1);
  Application.MessageBox('�ļ���ʼ����ɣ�','��ʾ',MB_OK+MB_ICONINFORMATION);
  Exit;
end;

procedure Tfrm_supermanager.btn_appClick(Sender: TObject);
begin
  ADODataSet1.Append;
end;

end.
