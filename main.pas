unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,HttpSend,Regexpr;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    ListBox1: TListBox;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;


  type
  TArr=array[0..60,0..8] of string;

type
  TVK = class
    private
      sl:TStringList;
      http:THttpSend;
      arr:TArr;
      function str:string;
      function GetLocation(const headers:TStringList):string;
      function pars(text, a, b: string): string;
      procedure Exparse(S:string);
    public
      procedure Find(S:string);
      constructor Create(login:string;password:string);

  end;

var
  Form1: TForm1;

implementation

  { TForm1 }

{$R *.lfm}

  function TVk.str:string;
    var
     t:tstringlist;
    begin
     t:= tstringlist.Create;
     t.LoadFromStream(http.Document);
     result:=t.Text;
     t.Free;
    end;


  function TVk.GetLocation(const headers:TStringList):string;
   var i:integer;
   begin
    for I := 0 to headers.Count - 1 do
      if pos('Location: ',headers[i])>0 then
          begin
            Result:=copy(headers[i],10,length(headers[i])-9);
            break;
          end;
   end;

   function TVk.pars(text, a, b: string): string;
   var
    temp:string;
   begin
    temp:=copy(text,pos(a,text)+length(a),length(text)  -(pos(a,text)+length(a)-1));
    pars:=copy(temp,1,pos(b,temp)-1);
   end;



constructor TVK.Create(login:string;password:string);
var
 s:string;
 html,ip_h,url:string;
begin
  http:=THTTPSend.Create;
  http.HTTPMethod('GET', 'http://m.vk.com/login');
  html:=UTF8toAnsi(str);
  ip_h:=pars(html,'ip_h=','&');
  s:='email='+login+'&pass='+password;
  HTTP.Document.Clear;
  HTTP.Headers.Clear;
  http.MimeType:='application/x-www-form-urlencoded';
  http.Document.Write(Pointer(s)^, Length(s));
  http.HTTPMethod('post', 'http://login.vk.com/?act=login&to=&from_host=m.vk.com&from_protocol=http&ip_h='+ip_h+'&pda=1');
  url:=GetLocation(http.Headers);
  sl:=TStringList.Create;
  HTTP.Document.Clear;
  HTTP.Headers.Clear;
  http.HTTPMethod('get',url);
  HTTP.Document.Clear;
  HTTP.Headers.Clear;
end;

procedure TVk.Exparse(S:string);
var
 reg1,reg:TRegexpr;
 i,j:integer;
begin
reg:=TRegexpr.Create;
reg1:=TRegexpr.Create;
reg.Expression:='\[(.*?)\]';
reg1.Expression:='\''(.*?)\''|[0-9]+';
if Reg.Exec(s) then
  begin
    i:=0;
    repeat
      if reg1.Exec(Reg.Match[0]) then begin
      j:=0;
    repeat
      self.arr[i,j]:=Reg1.Match[0];
      inc(j);
    until not Reg1.ExecNext;
      end;
    inc(i);
    until not Reg.ExecNext;
end;
end;

procedure TVK.Find(S:String);
var
 i:integer;
begin
  http.HTTPMethod('get','http://vk.com/docs.php?act=search_docs&al=1&offset=0&oid=3370474&q='+S);
  sl.LoadFromStream(http.Document);
  exparse(sl.Text);
  for i:=0 to 49 do form1.ListBox1.Items.Add(arr[i,2]);
end;

var
  VK:TVk;
  procedure TForm1.Button1Click(Sender: TObject);
  begin
  listbox1.Clear;
  if edit1.Text<>'' then vk.Find(edit1.Text);
  end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Vk:=TVk.Create('Zaj87@bk.ru','Random43Dos431');
  listbox1.ItemHeight:=50;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var
  url:string;
  FS:TFileStream;
  SL:TStringList;
  regex:Tregexpr;
begin

  regex:=TRegexpr.Create;
  sl:=TStringList.Create;
  regex.Expression:='var src = \''(.*?)\'';';
  FS:=TFileStream.Create('do.pdf',fmCreate);
  vk.http.Clear;
  url:='http://vk.com/doc-'+vk.arr[listbox1.ItemIndex,4]+'_'+vk.arr[listbox1.ItemIndex,0];
  vk.http.HTTPMethod('get',url);
  sl.LoadFromStream(vk.http.Document);
  if regex.Exec(sl.Text) then begin
  vk.http.MimeType:='application/pdf';
    if vk.http.HTTPMethod('get',regex.Match[1]) then
       vk.http.Document.SaveToStream(fs);
  end;
  regex.Free;
  sl.Free;
  fs.Free;
end;

procedure TForm1.Panel1Click(Sender: TObject);
begin

end;



end.
