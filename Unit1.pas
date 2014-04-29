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
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1DblClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Vk:TVk;

implementation

{$R *.dfm}

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  Vk.Download(listbox1.ItemIndex);
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Icon: TIcon;
  Offset: Integer;
begin
  with (Control as TListBox).Canvas do
  begin
    FillRect(Rect);
    Offset := 2;
    Icon := TIcon((Control as TListBox).Items.Objects[Index]);
    if Icon <> nil then
    begin
      Draw(Rect.Left + 1, Rect.Top + 2, TIcon((Control as
      TListBox).Items.Objects[Index]));
      Offset := Icon.width + 9;
    end;
    TextOut(Rect.Left + Offset, Rect.Top + 7, (Control as TListBox).Items[Index])
  end;
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
var
  i: Integer;
  Dibujo: TIcon;
begin
  Listbox1.Clear;
  Vk:=TVk.Create('Zaj87@bk.ru','Random43Dos431');
  Vk.Find(edit1.Text);
  for i := 0 to length(vk.arr)-1 do
  begin
    Dibujo := TIcon.create;
    if (Vk.arr[i,1]=#039+'pdf'+#039) then
    begin
      Dibujo.LoadFromFile('pdf.ico');
      listbox1.Items.AddObject(Vk.arr[i,2], Dibujo);
    end
    else if (Vk.arr[i,1]=#039+'djvu'+#039) then
    begin
      Dibujo.LoadFromFile('djvu.ico');
      listbox1.Items.AddObject(Vk.arr[i,2], Dibujo);
    end;
  end;
end;


procedure TForm1.N5Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
