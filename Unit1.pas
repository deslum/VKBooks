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
    procedure N3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Icon: TIcon;
  Offset: Integer; { ширина отступа текста }
begin
  with (Control as TListBox).Canvas do
    { рисуем на холсте элемента управления, не на форме }
  begin
    FillRect(Rect); { очищаем прямоугольник }
    Offset := 2; { обеспечиваем отступ по умолчанию }
    Icon := TIcon((Control as TListBox).Items.Objects[Index]);
      { получаем иконку для данного элемента }
    if Icon <> nil then
    begin
      Draw(Rect.Left + 1, Rect.Top + 2, TIcon((Control as
        TListBox).Items.Objects[Index]));

      Offset := Icon.width + 9;
        { добавляем четыре пикселя между иконкой и текстом }
    end;
    TextOut(Rect.Left + Offset, Rect.Top + 7, (Control as TListBox).Items[Index])
      { выводим текст }
  end;
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
var
  vk:TVk;
  i: Integer;
  Dibujo: TIcon;
begin
  Listbox1.Clear;
  vk:=TVk.Create('79166935403','Random43Dos4316');
  vk.Find(edit1.Text);
  for i := 0 to 48 do
  begin
    Dibujo := TIcon.create;
    if (vk.arr[i,1]=#039+'pdf'+#039) then
    begin
      Dibujo.LoadFromFile('pdf.ico');
      listbox1.Items.AddObject(vk.arr[i,2], Dibujo);
    end
    else if (vk.arr[i,1]=#039+'djvu'+#039) then begin
      Dibujo.LoadFromFile('djvu.ico');
      listbox1.Items.AddObject(vk.arr[i,2], Dibujo);
    end;

  end;
end;


procedure TForm1.N3Click(Sender: TObject);
begin
Application.Terminate;
end;

end.
