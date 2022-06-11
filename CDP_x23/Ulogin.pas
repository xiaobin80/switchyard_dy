unit Ulogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB;

type
  Tfrm_login = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edit_pass: TEdit;
    btn_login: TButton;
    btn_cancel: TButton;
    img_user: TImage;
    img_pass: TImage;
    adoconnect_login: TADOConnection;
    adodataset_login: TADODataSet;
    edit_user: TComboBox;
    preserve1: TADOQuery;
    procedure btn_loginClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edit_passKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_login: Tfrm_login;
  opertor:string;

implementation
uses
  Udispatch;

function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;
                external 'XBFGenerate.dll';


{$R *.dfm}

procedure Tfrm_login.btn_loginClick(Sender: TObject);
begin
  handlers:='';
  if edit_pass.Text='' then
  begin
    Application.MessageBox('����������!','��ʾ',MB_OK);
    Exit;
  end;
  //
  adodataset_login.Close;
  adodataset_login.CommandText:='select OperID, OperPassWord from operator where OperID='+''+edit_user.Text+''+' and OperPassWord='+''''+edit_pass.Text+'''';
  adodataset_login.Open;
  //
  if adodataset_login.RecordCount<>0 then
  begin
    opertor:=edit_user.Text;
    //������
    preserve1.Close;
    preserve1.SQL.Clear;
    preserve1.SQL.Text:='select OperID, OperPassWord from operator where OperID='+''+edit_user.Text+''+' and preserve1=1';
    preserve1.Open;
    if preserve1.RecordCount<>0 then
    begin
      Application.MessageBox('�û��Ѿ��ڲ����У��㲻�ܵ�¼��','��ʾ',MB_OK+MB_ICONINFORMATION);
      edit_pass.Text:='';
      Exit;
    end;
    //
    preserve1.Close;
    preserve1.SQL.Clear;
    preserve1.SQL.Text:='update operator set preserve1=1 where OperID='+''+edit_user.Text+'';
    preserve1.ExecSQL;
    Close;
  end
  else
  begin
    Application.MessageBox('����������벻��ȷ��','��ʾ',MB_OK+MB_ICONINFORMATION);
    edit_pass.Text:='';
    Exit;
  end;
end;

procedure Tfrm_login.btn_cancelClick(Sender: TObject);
begin
  Close;
  handlers:='123';
end;

procedure Tfrm_login.FormShow(Sender: TObject);
var
  i:integer;
  user1:string;
begin
  adodataset_login.Close;
  adodataset_login.CommandText:='select OperID, OperPassWord from operator';
  adodataset_login.Open;

  for i:=0 to adodataset_login.RecordCount-1 do
  begin
    user1:=adodataset_login.Fields[0].Text;
    edit_user.Items.Append(user1);
    adodataset_login.Next;
  end;

  edit_user.ItemIndex:=0;
  
end;

procedure Tfrm_login.FormCreate(Sender: TObject);
begin
  xbf:=ExtractFilePath(ParamStr(0))+'zlnr1.xbf';
  adoconnect_login.Close;
  adoconnect_login.ConnectionString:=readXBF(-1,xbf);
  adoconnect_login.Open;
end;

procedure Tfrm_login.edit_passKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    btn_loginClick(nil);
  end;
end;

end.
