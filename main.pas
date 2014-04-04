unit main;


interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,idHttp,RegularExpressionsAPI,RegularExpressionsCore,
  RegularExpressionsConsts,RegularExpressions;



type
  TArr=array[0..60,0..8] of string;

type
  TVK = class
    private
      sl:TStringList;
      http:TidHttp;
      function pars(text, a, b: string): string;
      procedure Exparse(S:string);
    public
      arr:TArr;
      procedure Find(S:string);
      constructor Create(login:string;password:string);

  end;


implementation

function TVk.pars(text, a, b: string): string;
var
  temp:string;
begin
  temp:=copy(text,pos(a,text)+length(a),length(text)  -(pos(a,text)+length(a)-1));
  pars:=copy(temp,1,pos(b,temp)-1);
end;



constructor TVK.Create(login:string;password:string);
var
 s:TStringList;
 html,ip_h:string;
begin
  s:=TStringList.Create;
  s.Add('email='+login);
  s.Add('pass='+password);
  http:=Tidhttp.Create;
  html:=http.Get('http://m.vk.com/login');
  html:=UTF8toAnsi(html);
  ip_h:=pars(html,'ip_h=','&');
  http.HandleRedirects:=true;
  http.Request.CustomHeaders.Add('MimeType: application/x-www-form-urlencoded');
  http.Post('http://login.vk.com/?act=login&to=&from_host=m.vk.com&'+
  'from_protocol=http&ip_h='+ip_h+'&pda=1',s);
  http.Get(http.Response.Location);
  FreeAndNil(s);
end;


procedure TVk.Exparse(S:string);
var
 reg1,reg:TRegex;
 i,j:integer;
 M1,M2:TMatchCollection;
begin
Reg:=TRegex.Create('\[(.*?)\]');
Reg1:=TRegex.Create('\''(.*?)\''|[0-9]+');
if Reg.IsMatch(S) then
  begin
    M1:=reg.Matches(S);
    for i := 0 to M1.Count-1 do begin
      M2:=reg1.Matches(M1.Item[i].Value);
      for j := 0 to M2.Count-1 do
        arr[i,j]:=m2.Item[j].Value;
    end;
  end;
end;

function UrlEncode(const s: AnsiString): string;
var
  I: integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    case S[i] of
      '%', ' ', '&', '=', '@', '.', #13, #10, #128..#255: Result := Result + '%'
        + IntToHex(Ord(S[i]), 2);
    else
      Result := Result + S[i];
    end;
end;


procedure TVK.Find(S:String);
var
 i:integer;
 text:String;
begin
  s:=Urlencode(ansitoutf8(s));
  text:=http.get('http://vk.com/docs.php?act=search_docs&al=1&offset=0&oid=3370474&q='+S);
  exparse(text);
end;

{
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
}


end.
