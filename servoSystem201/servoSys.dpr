program servoSys;

uses
  Forms,
  windows,
  Messages,
  SysUtils,
  UmainServo in 'UmainServo.pas' {frmServoMain};

{$R *.res}

Var

  hMutex:HWND;

  Ret:Integer;
  //
  loginParStr:WideString;
  showMWindow:WideString;

  aHandle:HWND;
  param1Int:Integer;

begin
  hMutex:=CreateMutex(nil,False,'servoSystem2631');
  Ret:=GetLastError;
  //
  loginParStr:=ParamStr(1);
  showMWindow:=ParamStr(2);
  If Ret<>ERROR_ALREADY_EXISTS Then
  begin
    //
    param1Int:=0;
    if loginParStr='-I' then param1Int:=1
      else if loginParStr='-O' then param1Int:=2;

    case param1Int of
      1://entry flag(have)
      begin
        if showMWindow='' then
        begin
          Application.Initialize;
          Application.Title := 'servoSystem2631';
          Application.CreateForm(TfrmServoMain, frmServoMain);
          Application.ShowMainForm:=False;
          Application.Run;
        end
        else if showMWindow='-S' then
        begin
          Application.Initialize;
          Application.Title := 'servoSystem2631';
          Application.CreateForm(TfrmServoMain, frmServoMain);
          Application.Run;
        end
        else
        begin
          Application.MessageBox('Error Parameter,Can not run this program!','Hint',MB_OK);
          Application.Terminate;
        end;
      end;
      2:
      begin

      end;
      //
      else//entry flag(have not)
      begin
        Application.MessageBox('No Enough Parameter,You can not run this program!','Hint',MB_OK);
        Application.Terminate;
      end;
    end;
  end
  else
  begin
    if loginParStr='-Q' then
    begin
      aHandle:=FindWindow(nil,'servoSystem2631');
      SendMessageW(aHandle,WM_CLOSE,0,0);
    end;
    //Application.MessageBox('servoSystem2631 running!Can not new run instance','HINT',MB_OK+MB_ICONHAND);
    Exit;
  end;

end.
