unit Hasil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Buka1: TMenuItem;
    Simpan1: TMenuItem;
    Reset1: TMenuItem;
    StatusBar1: TStatusBar;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    imghasil: TImage;
    mmOutput: TMemo;
    Home1: TMenuItem;
    Keluar1: TMenuItem;
    iterasi: TMenuItem;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Dashboard1Click(Sender: TObject);
    procedure Keluar1Click(Sender: TObject);
    procedure Buka1Click(Sender: TObject);
    procedure Simpan1Click(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure iterasiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Awal, Unit3;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  imghasil.Canvas.Brush.Color := clWhite;
  imghasil.Canvas.FillRect(Rect(0, 0, imghasil.Width, imghasil.Height));
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  if Application.MessageBox('Anda Yakin Ingin Keluar?','Konfirmasi',MB_ICONINFORMATION+MB_YESNO)=IDYES
  then Form1.Close;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Form1.Simpan;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Form1.Hapus;
  Form2.Close;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.Dashboard1Click(Sender: TObject);
begin
  Form2.Close;
  Form1.Awal;
end;

procedure TForm2.Keluar1Click(Sender: TObject);
begin
  if Application.MessageBox('Anda Yakin Ingin Keluar?','Konfirmasi',MB_ICONINFORMATION+MB_YESNO)=IDYES
  then Form1.Close;
end;

procedure TForm2.Buka1Click(Sender: TObject);
var namafile: string;
begin
  if opendialog1.Execute then
  begin
    form1.Hapus;
    namafile := opendialog1.FileName;
    if form1.tformat(namafile)='xml' then form1.dataset(namafile) else form1.buka(namafile);
  end;
end;

procedure TForm2.Simpan1Click(Sender: TObject);
begin
  Form1.Simpan;
end;

procedure TForm2.Reset1Click(Sender: TObject);
begin
  Form1.Hapus;
end;

procedure TForm2.iterasiClick(Sender: TObject);
begin
  Form3.Show;
  form3.PageControl1.ActivePageIndex:=0;
end;

end.
