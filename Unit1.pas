unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons,main;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    procedure N3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  vk:TVk;
  arr:Tarr;
  i: Integer;
begin
  Listbox1.Clear;
  vk:=TVk.Create('','');
  vk.Find(edit1.Text);
  for i := 0 to 48 do
    if (vk.arr[i,1]=#039+'pdf'+#039) or (vk.arr[i,1]=#039+'djvu'+#039) then
    listbox1.Items.Add(vk.arr[i,2]);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
Application.Terminate;
end;

end.
