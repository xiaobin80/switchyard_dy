unit u_about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, ShellApi;

type
  Tfrm_about = class(TForm)
    mo_about: TMemo;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Image1: TImage;
    Label2: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Label1: TLabel;
    procedure Label10Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    verStr:string;
    function GetCDPFileVersion(FileName:String):String;
    { Public declarations }
  end;

var
  frm_about: Tfrm_about;

implementation

{$R *.dfm}

procedure Tfrm_about.Label10Click(Sender: TObject);
begin
//
    ShellExecute(Handle,
				 nil,
				 PChar(Label10.Caption),
				 nil,
				 nil,
				 SW_SHOWNORMAL);
end;

function Tfrm_about.GetCDPFileVersion(FileName:String):String;
var
  InfoSize,Wnd:DWORD;
  VerBuf:Pointer;
  VerInfo:^VS_FIXEDFILEINFO;
begin
    Result:='1.0.0.0';
    InfoSize:=GetFileVersionInfoSize(PChar(FileName),Wnd);
    if InfoSize<>0 then
    begin
      GetMem(VerBuf,InfoSize);
      try
        if GetFileVersionInfo(PChar(FileName),Wnd,InfoSize,VerBuf) then
        begin
          VerInfo:=nil;
          VerQueryValue(VerBuf,'\',Pointer(VerInfo),Wnd);
          if VerInfo<>nil then Result:=Format('%d.%d.%d.%d',[VerInfo^.dwFileVersionMS shr 16,
                                                             VerInfo^.dwFileVersionMS and $0000ffff,
                                                             VerInfo^.dwFileVersionLS shr 16,
                                                             VerInfo^.dwFileVersionLS and $0000ffff]);
        end;
      finally
        FreeMem(VerBuf,InfoSize);
      end;

    end;
end;

procedure Tfrm_about.FormShow(Sender: TObject);
var
  szExePathname:array [0..266]of char;
  hMoudleA:DWORD;
begin
  hMoudleA:=GetModuleHandle(nil);
  GetModuleFileName(hMoudleA,szExePathname,MAX_PATH);
  verStr:=GetCDPFileVersion(string(szExePathname));
  mo_about.Lines.Append(#13);
  mo_about.Lines.Append('Ö÷³ÌÐò°æ±¾ºÅ:');
  mo_about.Lines.Add('             '+verStr);
end;

end.
