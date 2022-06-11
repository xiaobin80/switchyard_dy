program manager;

uses
  Forms,
  windows,
  SysUtils,
  Ulogin in 'Ulogin.pas' {frm_login},
  Usupermanager in 'Usupermanager.pas' {frm_supermanager};

{$R *.res}
Var
  hMutex:HWND;
  Ret:Integer;

begin
  hMutex:=CreateMutex(nil,False,'��������Ա������');
  Ret:=GetLastError;
  If Ret<>ERROR_ALREADY_EXISTS Then
  begin
    Application.Initialize;
    Application.Title := '��������Ա������';
  try
      frm_login :=Tfrm_login.Create(nil);
      frm_login.ShowModal;
    finally
      frm_login.Free;
    end;
    if handlers<>'' then
    begin
      application.MessageBox('û����ȷ��¼������ʹ�ñ����!','��ʾ',mb_ok);
      exit ;
    end ;

    Application.CreateForm(Tfrm_supermanager, frm_supermanager);
  Application.Run;
  end
  else
  begin
    Application.MessageBox('�����Ѿ������У�','��ʾ',MB_OK+MB_ICONHAND);
    Exit;
  end;
end.
