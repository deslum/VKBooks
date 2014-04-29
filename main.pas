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
      procedure Download(Index:Integer);
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

procedure TVK.Download(Index:Integer);
var
  url:string;
  FS:TStream;
  Text:String;
  regex:Tregex;
begin
  regex:=TRegex.Create('var src = \''(.*?)\'';');
  FS:=TFileStream.Create(arr[Index,2],fmCreate);
  http.Request.Clear;
  url:='http://vk.com/doc'+arr[Index,4]+'_'+arr[Index,0];
  try
    Text:=http.Get(url);
    if regex.IsMatch(Text) then begin
      http.Request.CustomHeaders.Add('MimeType: application/pdf');
      http.Get(regex.Match(Text).Value,FS);
    end;
  finally
    fs.Free;
  end;
end;


procedure TVk.Exparse(S:string);
var
  reg1,reg:TRegex;
  i,j,n:integer;
  M1,M2:TMatchCollection;
begin
Reg:=TRegex.Create('\[(.*?)\]');
Reg1:=TRegex.Create('\''(.*?)\''|[\-0-9]+');
if Reg.IsMatch(S) then
  begin
    M1:=reg.Matches(S);
    n:=0;
    for i := 0 to M1.Count-1 do
    begin
      M2:=reg1.Matches(M1.Item[i].Value);
      if (m2.Item[1].Value=#039+'pdf'+#039) or (m2.Item[1].Value=#039+'djvu'+#039) then
      begin
        for j := 0 to M2.Count-1 do
            arr[n,j]:=m2.Item[j].Value;
        inc(n);
      end;
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
end.
