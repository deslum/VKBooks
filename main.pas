program Vkbooks;

{$mode delphi}{$H+}

uses

  httpsend,sysUtils,classes,RegExpr;

type
  TArr=array[0..60,0..8] of string;

type
  TVK = class
    private
      sl:TStringList;
      http:THttpSend;
      function str(http:thttpsend):string;
      function GetLocation(const headers:TStringList):string;
      function pars(text, a, b: string): string;
      function Exparse(S:string):Tarr;
    public
      procedure Find(S:string);
      constructor Create(login:string;password:string);

  end;

  function TVk.str(http:thttpsend):string;
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
  html:=UTF8toAnsi(str(http));
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

function TVk.Exparse(S:string):Tarr;
var
 reg1,reg:TRegexpr;
 a:Tarr;
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
      a[i,j]:=Reg1.Match[0];
      inc(j);
    until not Reg1.ExecNext;
      end;
    inc(i);
    until not Reg.ExecNext;
end;
Result:=a;
end;

procedure TVK.Find(S:String);
var
 i:integer;
 arr:Tarr;
begin
  http.HTTPMethod('get','http://vk.com/docs.php?act=search_docs&al=1&offset=0&oid=3370474&q='+S);
  sl.LoadFromStream(http.Document);
  arr:=exparse(sl.Text);
  for i:=0 to 49 do if arr[i,1]='''pdf''' then writeln(arr[i,2]+' '+'http://vk.com/doc'+arr[i,4]+'_'+arr[i,0]);
end;


var
 Vk:TVK;
begin
 Vk:=TVk.Create('abc@def.gh','abc');
 vk.Find('Java');
end.
