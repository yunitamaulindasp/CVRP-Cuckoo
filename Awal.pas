unit Awal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Menus, Grids, Math, xmldom,
  Provider, Xmlxform, XMLIntf, msxmldom, XMLDoc, jpeg;

type  matriks = array of array of real;
      Graph = record
        mtBobot : matriks;
        size    : integer;
      end;

type  Titik = record
        posisi  : TPoint;
        warna   : TColor;
      end;

type  Customer = record
        Cust, Permintaan : integer;
      end;

type  iterasi = record
        nilai   : array of real;
        urutan  : array of integer;
      end;

type  matrik = array of array of integer;
      Solusi = record
        rute  : matrik;
      end;

type  Best = record
        rute   : matrik;
        sarang : integer;
      end;

type  Permut = record
        satu,dua   : integer;
      end;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Home1: TMenuItem;
    Mulai1: TMenuItem;
    Keluar1: TMenuItem;
    File1: TMenuItem;
    Buka1: TMenuItem;
    Simpan1: TMenuItem;
    Reset1: TMenuItem;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    imgTitik: TImage;
    sgMatriks: TStringGrid;
    sgCust: TStringGrid;
    Label9: TLabel;
    edKapasitas: TEdit;
    edSarang: TEdit;
    edPa: TEdit;
    edIterMax: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    XMLDocument1: TXMLDocument;
    Label1: TLabel;
    Label2: TLabel;
    edA: TEdit;
    edB: TEdit;
    Label8: TLabel;
    procedure Keluar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Dashboard1Click(Sender: TObject);
    procedure imgTitikMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sgMatriksKeyPress(Sender: TObject; var Key: Char);
    procedure sgMatriksSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure sgMatriksDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgMatriksSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgCustKeyPress(Sender: TObject; var Key: Char);
    procedure sgCustSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure edKapasitasKeyPress(Sender: TObject; var Key: Char);
    procedure edSarangKeyPress(Sender: TObject; var Key: Char);
    procedure Mulai1Click(Sender: TObject);
    procedure Buka1Click(Sender: TObject);
    procedure Simpan1Click(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure edPaKeyPress(Sender: TObject; var Key: Char);
    procedure edBanyakKeyPress(Sender: TObject; var Key: Char);
    procedure edIterMaxKeyPress(Sender: TObject; var Key: Char);
    procedure edAKeyPress(Sender: TObject; var Key: Char);
    procedure edBKeyPress(Sender: TObject; var Key: Char);
  private
    G : Graph;
    arTitik   : array of Titik;
    arCust    : array of Customer;
    arSarang, arLevy, arBRW  : array of Iterasi;
    arSolusi, arSem  : array of Solusi;
    XBest     : Best;
    arPermut  : array of permut;
  public
    procedure Awal;
    procedure GambarTitik (const index : Integer; const repaint: Boolean);
    procedure GambarSisi(const v1, v2: byte);
    procedure GambarBobot(const v1, v2: byte);
    procedure GambarHasil;
    procedure HapusBobot(const v1, v2: byte);
    procedure HapusSisi(const v1, v2: byte);
    procedure Hapussisihasil(const v1, v2: byte);
    procedure Hapus;
    procedure Buka(const files: string);
    procedure Simpan;
    function HitungJarak(s: array of integer): real;
    function TotalJarak(r: matrik): real;
    function VKeputusan(s: matriks): string;
    function cekdemands(d: array of Customer): string;
    procedure buatrute(const sarang: array of Iterasi; const rute: String);
    procedure cariXBest;
    procedure Cuckoo;
    procedure Proses;
    procedure Dataset(const files: string);
    function tformat (value : string): string;
    procedure hapusiter;
  end;

var
  Form1: TForm1;
  Q, bykSarang, iterMax : integer;
  Pa,alfa,beta : real;
  arU, arV, arS, arK : array of array of real;
  himV: set of byte;

implementation

uses Hasil, Unit3, dataset;

{$R *.dfm}

procedure TForm1.Awal;
begin
end;

function TForm1.cekdemands(d: array of Customer): string;
var a: integer;
begin
  result:='terisi';
  for a:=0 to length(d)-1 do
    if inttostr(d[a].Permintaan)='0' then
      result:='';
end;

procedure TForm1.GambarTitik(const index: Integer; const repaint: Boolean);
var X, Y : Integer;
begin
  X := arTitik[index].posisi.X;
  Y := arTitik[index].posisi.Y;

  imgTitik.Canvas.Pen.Color := clBlack;
  imgTitik.Canvas.Ellipse(X-6, Y-6, X+6, Y+6);
  imgtitik.Canvas.Brush.Color := arTitik[index].warna;

  imgTitik.Canvas.FloodFill(X, Y, clBlack, fsBorder);
  imgTitik.Canvas.Brush.Color := clWhite;
  imgTitik.Canvas.Font.Color := clRed;
  imgTitik.Canvas.Font.Style := [fsBold];

  imgTitik.Canvas.TextOut(X-5, Y+10, Format('%d', [index]));
  imgTitik.Canvas.Font.Color := clBlack;
  imgTitik.Canvas.Font.Style := [];


  Form2.imghasil.Canvas.Pen.Color := clBlack;
  Form2.imghasil.Canvas.Ellipse(X-6, Y-6, X+6, Y+6);
  Form2.imghasil.Canvas.Brush.Color := arTitik[index].warna;

  Form2.imghasil.Canvas.FloodFill(X, Y, clBlack, fsBorder);
  Form2.imghasil.Canvas.Brush.Color := clWhite;
  Form2.imghasil.Canvas.Font.Color := clRed;
  Form2.imghasil.Canvas.Font.Style := [fsBold];

  Form2.imghasil.Canvas.TextOut(X-5, Y+10, Format('%d', [index]));
  Form2.imghasil.Canvas.Font.Color := clBlack;
  Form2.imghasil.Canvas.Font.Style := [];

  if repaint then imgTitik.Repaint();
end;

procedure TForm1.GambarSisi(const v1, v2: byte);
var P1, P2: TPoint;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;
  imgTitik.Canvas.Pen.Color := clBlack;
  imgTitik.Canvas.MoveTo(P1.X, P1.Y);
  imgTitik.Canvas.LineTo(P2.X, P2.Y);

  GambarBobot(v1, v2);
  GambarTitik(v1, true);
  GambarTitik(v2, true);
end;

procedure TForm1.GambarBobot(const v1, v2: byte);
var P1, P2: TPoint; xC, yC: integer; bobot : real;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;

  xC := Round((P1.X + P2.X)/2);
  yC := Round((P1.Y + P2.Y)/2);
  bobot := G.mtBobot[v1, v2];

  imgTitik.Canvas.Font.Color := clBlue;
  imgTitik.Canvas.TextOut(xC, yC+6, FloatToStr(bobot));
  imgTitik.Canvas.Font.Color := clBlack;
end;

procedure TForm1.GambarHasil;
var i,j,u,v,xC,yC,plh: integer;
    P1,P2: TPoint;
    bobot: real;
    wrn: string;
    tplh: set of byte;
begin
  tplh:=[];
    for i:= 0 to Length(XBest.rute)-1 do
    begin
      repeat
        plh:=random(15)+1;
      until not(plh in tplh);
      wrn:=inttostr(plh)+'0000';
      tplh:=tplh+[plh];
      for j:=0 to length(XBest.rute[i])-2 do
      begin
        u:= XBest.rute[i, j];
        v:= XBest.rute[i, j+1];
        P1 := arTitik[u].posisi;
        P2 := arTitik[v].posisi;
        form2.imghasil.Canvas.Pen.Width := 2;
        form2.imghasil.Canvas.Pen.Color := strtoint(wrn);
        form2.imghasil.Canvas.MoveTo(P1.X, P1.Y);
        form2.imghasil.Canvas.LineTo(P2.X, P2.Y);

        xC := Round((P1.X + P2.X)/2);
        yC := Round((P1.Y + P2.Y)/2);
        bobot := G.mtBobot[u,v];
        form2.imghasil.Canvas.Font.Color := clBlue;
        form2.imghasil.Canvas.TextOut(xC, yC+6, FloatToStr(bobot));
        form2.imghasil.Canvas.Font.Color := clBlack;
      end;
    end;
end;

procedure TForm1.HapusBobot(const v1, v2: byte);
var P1, P2: TPoint; xC, yC: integer; bobot : real;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;

  xC := Round((P1.X + P2.X)/2);
  yC := Round((P1.Y + P2.Y)/2);
  bobot := G.mtBobot[v1, v2];

  imgTitik.Canvas.Font.Color := clwhite;
  imgTitik.Canvas.TextOut(xC, yC+6, FloatToStr(bobot));
  imgTitik.Canvas.Font.Color := clBlack;
end;

procedure TForm1.HapusSisi(const v1, v2: byte);
var p1, p2: TPoint;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;
  imgTitik.Canvas.Pen.Color := clWhite;
  imgTitik.Canvas.MoveTo(P1.X, P1.Y);
  imgTitik.Canvas.LineTo(P2.X, P2.Y);

  HapusBobot(v1, v2);
  GambarTitik(v1, true);
  GambarTitik(v2, true);
end;

procedure TForm1.Hapussisihasil(const v1, v2: byte);
var p1, p2: TPoint; xC, yC: integer; bobot : real;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;
  form2.imghasil.Canvas.Pen.Color := clWhite;
  form2.imghasil.Canvas.MoveTo(P1.X, P1.Y);
  form2.imghasil.Canvas.LineTo(P2.X, P2.Y);

  xC := Round((P1.X + P2.X)/2);
  yC := Round((P1.Y + P2.Y)/2);
  bobot := G.mtBobot[v1, v2];

  form2.imghasil.Canvas.Font.Color := clwhite;
  form2.imghasil.Canvas.TextOut(xC, yC+6, FloatToStr(bobot));
  form2.imghasil.Canvas.Font.Color := clBlack;
end;

procedure TForm1.Hapus;
var i, j, bykTitik: byte;
begin
  Form1.Show;
  Form2.mmOutput.Lines.Clear;
  imgTitik.Canvas.Brush.Color := clWhite;
  imgTitik.Canvas.FillRect(Rect(0, 0, imgTitik.Width, imgTitik.Height));
  Form2.imghasil.Canvas.Brush.Color := clWhite;
  Form2.imghasil.Canvas.FillRect(Rect(0, 0, Form2.imghasil.Width, Form2.imghasil.Height));
  bykTitik := G.size;
  if bykTitik <> 0 then
  begin
    setLength(arTitik, 0);
    for i := 1 to bykTitik do
      for j := 1 to bykTitik do
        sgMatriks.Cells[i, j] := '';
    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        G.mtBobot[i,j] := 0;
    G.size := 0;
    setLength(G.mtBobot, 0, 0);
    sgMatriks.ColCount := 2;
    sgMatriks.RowCount := 2;
  end;
  for i:=1 to 2 do
    for j:=1 to length(arCust) do
      sgCust.Cells[i,j]:='';
  sgCust.Cells[0,1]:='';
  sgCust.ColCount := 2;
  sgCust.RowCount := 2;
  setlength(arCust, 0);
  setlength(arSarang,0);
  setlength(arSolusi,0);
  edKapasitas.Text:='';
  edSarang.Text:='';
  edPa.Text:='';
  edIterMax.Text:='';
  edA.Text:='';
  edB.Text:='';
  hapusiter;
end;

procedure TForm1.Buka(const files: string);
var myFile: TextFile;
    jenis, namafile: string;
    i, j, bykTitik, bykParameter: byte;
    X, Y, permintaan, kapasitas: integer;
    bobot: real;
begin
    assignfile(myfile, files);
    reset(myfile);
    readln(myfile, jenis);
    readln(myfile, bykTitik);
    setlength(G.mtBobot, bykTitik, bykTitik);
    G.size := bykTitik;
    sgMatriks.ColCount := bykTitik+1;
    sgMatriks.RowCount := bykTitik+1;
    readln(myfile, jenis);
    for i:=0 to bykTitik-1 do
      for j:=0 to bykTitik-1 do
        if j > i then
        begin
          readln(myfile, bobot);
          G.mtBobot[i,j]:=bobot;
          G.mtBobot[j,i]:=bobot;
          sgMatriks.Cells[j+1,i+1]:=floattostr(bobot);
          sgMatriks.Cells[i+1,j+1]:=floattostr(bobot);
        end;
    for i:=1 to bykTitik do
    begin
      sgMatriks.Cells[0,i]:=Format('%d',[i-1]);
      sgMatriks.Cells[i,0]:=Format('%d',[i-1]);
    end;
    sgCust.ColWidths[0]:=100;
    sgCust.ColWidths[1]:=120;
    readln(myfile, jenis);
    readln(myfile, bykParameter);
    setlength(arCust, bykParameter);
    sgCust.RowCount:=bykParameter+1;
    sgCust.Cells[0, 0] := 'Customer';
    sgCust.Cells[1, 0] := 'Permintaan';
    for i:=0 to length(arCust)-1 do
    begin
      arCust[i].Cust := i+1;
      sgCust.Cells[0, i+1] := Format('%d', [i+1]);
    end;
    readln(myfile, jenis);
    for i:=0 to length(arCust)-1 do
    begin
      readln(myfile, permintaan);
      arCust[i].Permintaan:=permintaan;
      sgCust.Cells[1,i+1]:=inttostr(permintaan);
    end;
    readln(myfile, jenis);
    readln(myfile, kapasitas);
    edKapasitas.Text:=inttostr(kapasitas);
    setLength(arTitik, bykTitik);
    readln(myfile, jenis);
    for i := 0 to bykTitik-1 do
    begin
      readln(myfile, X, Y);
      arTitik[i].posisi := Point(X, Y);
      if i=0 then arTitik[i].warna := clGreen
      else arTitik[i].warna := clYellow;
    end;
    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        if j > i then
          if G.mtBobot[i, j] <> 0 then
            GambarSisi(i, j);
    closefile(myfile);
end;

procedure TForm1.proses;
var i,j,u,v: integer;
begin
  if (VKeputusan(G.mtBobot)='0') or (cekdemands(arCust)='') or
  (edIterMax.Text='') or (edKapasitas.Text='') or (edPa.Text='') or
  (edSarang.Text='') or (edA.Text='') or (edB.Text='') then
    Application.MessageBox('Data yang dimasukkan tidak lengkap!',
    'Information', MB_OK or MB_ICONEXCLAMATION)
  else if (edIterMax.Text='0') or (edKapasitas.Text='0') or
  (edPa.Text='0') or (edSarang.Text='0') then
    Application.MessageBox('Data yang dimasukkan TIDAK BOLEH NOL!!','Information', MB_OK or MB_ICONEXCLAMATION)
  else
  begin
    if form2.mmoutput.Lines.Text<>'' then
    begin
      Form2.mmOutput.Clear;
      hapusiter;
      for i:= 0 to Length(XBest.rute)-1 do
        for j:=0 to length(XBest.rute[i])-2 do
        begin
          u:= XBest.rute[i, j];
          v:= XBest.rute[i, j+1];
          hapussisihasil(u,v);
        end;
    end;
    Q := strtoint(edKapasitas.Text);
    bykSarang:= strtoint(edSarang.Text);
    Pa:= strtofloat(edPa.Text);
    iterMax:= strtoint(edIterMax.Text);
    alfa:= strtofloat(edA.Text);
    beta:= strtofloat(edB.Text);

    Form3.mmIter.Lines.Add('Perhitungan CVRP-Cuckoo');
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('1. Menentukan Parameter');
    Form3.mmIter.Lines.Add('Banyak customer : '+inttostr(Length(arCust)));
    Form3.mmIter.Lines.Add('Kapasitas kendaraan : '+edKapasitas.Text);
    Form3.mmIter.Lines.Add('Banyak sarang : '+edSarang.Text);
    Form3.mmIter.Lines.Add('Probabilitas pergantian sarang : '+edPa.Text);
    Form3.mmIter.Lines.Add('Nilai Alfa : '+edA.Text);
    Form3.mmIter.Lines.Add('Nilai Beta : '+edB.Text);
    Form3.mmIter.Lines.Add('Iterasi Maximal : '+edIterMax.Text);

    cuckoo;

    GambarHasil;

    Form2.show;
  end;
end;

procedure TForm1.Simpan;
var i, j, bykTitik, bykParameter : byte;
    namafile: string;
    myfile: textfile;
    X, Y, bykKendaraan : Integer;
begin
  if savedialog1.Execute then
  begin
    bykTitik := G.size;
    bykParameter := length(arCust);
    namafile := savedialog1.FileName;
    assignfile(myfile, namafile);
    rewrite(myfile);
    writeln(myfile, '[Banyak titik]');
    writeln(myfile, bykTitik);
    writeln(myfile, '[Bobot sisi]');
    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        if j > i then
          writeln(myfile, G.mtBobot[i, j]);
    writeln(myfile, '[Banyak arCust]');
    writeln(myfile, bykParameter);
    writeln(myfile, '[Parameter permintaan]');
    for i:=0 to bykParameter-1 do
      writeln(myfile, arCust[i].Permintaan);
    writeln(myfile, '[Kapasitas Kendaraan]');
    writeln(myfile, strtoint(edKapasitas.Text));
    writeln(myfile, '[Posisi titik]');
    for i := 0 to bykTitik do
    begin
      X := arTitik[i].posisi.X;
      Y := arTitik[i].posisi.Y;
      writeln(myfile, X, ' ', Y);
    end;
    closefile(myfile);
  end;
end;

function TForm1.HitungJarak(s: array of integer): real;
var i, j: integer;
    jumlah: real;
begin
  jumlah:=0;
  for i:=0 to length(s)-2 do
    jumlah:= jumlah + g.mtbobot[s[i], s[i+1]];
  result:= jumlah;
end;

function TForm1.TotalJarak(r: matrik): real;
var a : integer;
    total : real;
begin
  total := 0;
  for a:=0 to length(r)-1 do
  begin
    total:=total+hitungjarak(r[a]);
  end;
  result := total;
end;

function TForm1.VKeputusan(s: matriks): string;
var a,b: integer;
begin
  result:='1';
  for a:=0 to length(s)-2 do
    for b:=a+1 to length(s)-1 do
      if floattostr(g.mtbobot[a,b])='0' then
        result:='0';
end;

procedure TForm1.buatrute(const sarang: array of Iterasi;
  const rute: String);
var a,b,c,t,permintaan: integer;
    himT: set of byte;
begin
  if rute='awal' then
  begin
    setlength(arSolusi, length(sarang));
    for a:=0 to length(sarang)-1 do
    begin
      himT:=[];

      setlength(arSolusi[a].rute, 1);
      setlength(arSolusi[a].rute[0], 2);
      arSolusi[a].rute[0,0]:=0;
      arSolusi[a].rute[0,1]:=sarang[a].urutan[0];
      himT:=himT+[sarang[a].urutan[0]];

      b:=1;
      while b<length(arCust) do
      begin
        t:=sarang[a].urutan[b];

        permintaan:=arCust[t-1].Permintaan;
        for c:=1 to length(arCust) do
          if c in himT then
          begin
            permintaan:=permintaan+arCust[c-1].Permintaan;
          end;

        if (permintaan<=Q) then
        begin
          setlength(arSolusi[a].rute[length(arSolusi[a].rute)-1], length(arSolusi[a].rute[length(arSolusi[a].rute)-1])+1);
          arSolusi[a].rute[length(arSolusi[a].rute)-1,length(arSolusi[a].rute[length(arSolusi[a].rute)-1])-1]:=t;
          himT:=himT+[t];
        end
        else
        begin
          setlength(arSolusi[a].rute[length(arSolusi[a].rute)-1], length(arSolusi[a].rute[length(arSolusi[a].rute)-1])+1);
          arSolusi[a].rute[length(arSolusi[a].rute)-1,length(arSolusi[a].rute[length(arSolusi[a].rute)-1])-1]:=0;
          himT:=[];
          setlength(arSolusi[a].rute, length(arSolusi[a].rute)+1);
          setlength(arSolusi[a].rute[length(arSolusi[a].rute)-1], 2);
          arSolusi[a].rute[length(arSolusi[a].rute)-1,0]:=0;
          arSolusi[a].rute[length(arSolusi[a].rute)-1,1]:=t;
          himT:=himT+[t];
        end;
        b:=b+1;
      end;
      setlength(arSolusi[a].rute[length(arSolusi[a].rute)-1], length(arSolusi[a].rute[length(arSolusi[a].rute)-1])+1);
      arSolusi[a].rute[length(arSolusi[a].rute)-1,length(arSolusi[a].rute[length(arSolusi[a].rute)-1])-1]:=0;
    end;
  end
  else if rute='sementara' then
  begin
    setlength(arSem, 0);
    setlength(arSem, length(sarang));
    for a:=0 to length(sarang)-1 do
      if not (a in himV) then
      begin
        himT:=[];

        setlength(arSem[a].rute, 1);
        setlength(arSem[a].rute[0], 2);
        arSem[a].rute[0,0]:=0;
        arSem[a].rute[0,1]:=sarang[a].urutan[0];
        himT:=himT+[sarang[a].urutan[0]];

        b:=1;
        while b<length(arCust) do
        begin
          t:=sarang[a].urutan[b];

          permintaan:=arCust[t-1].Permintaan;
          for c:=1 to length(arCust) do
            if c in himT then
              permintaan:=permintaan+arCust[c-1].Permintaan;

          if (permintaan<=Q) then
          begin
            setlength(arSem[a].rute[length(arSem[a].rute)-1], length(arSem[a].rute[length(arSem[a].rute)-1])+1);
            arSem[a].rute[length(arSem[a].rute)-1,length(arSem[a].rute[length(arSem[a].rute)-1])-1]:=t;
            himT:=himT+[t];
          end
          else
          begin
            setlength(arSem[a].rute[length(arSem[a].rute)-1], length(arSem[a].rute[length(arSem[a].rute)-1])+1);
            arSem[a].rute[length(arSem[a].rute)-1,length(arSem[a].rute[length(arSem[a].rute)-1])-1]:=0;
            himT:=[];
            setlength(arSem[a].rute, length(arSem[a].rute)+1);
            setlength(arSem[a].rute[length(arSem[a].rute)-1], 2);
            arSem[a].rute[length(arSem[a].rute)-1,0]:=0;
            arSem[a].rute[length(arSem[a].rute)-1,1]:=t;
            himT:=himT+[t];
          end;
          b:=b+1;
        end;
        setlength(arSem[a].rute[length(arSem[a].rute)-1], length(arSem[a].rute[length(arSem[a].rute)-1])+1);
        arSem[a].rute[length(arSem[a].rute)-1,length(arSem[a].rute[length(arSem[a].rute)-1])-1]:=0;
      end;
  end;
end;

procedure TForm1.cariXBest;
var a,b,t: integer;
    n: real;
begin
  n:=999999;
  for a:=0 to length(arSolusi)-1 do
    if TotalJarak(arSolusi[a].rute)<n then
    begin
      n:=TotalJarak(arSolusi[a].rute);
      t:=a;
    end;

  setlength(XBest.rute, length(arSolusi[t].rute));
  for a:=0 to length(arSolusi[t].rute)-1 do
  begin
    setlength(XBest.rute[a], length(arSolusi[t].rute[a]));
    for b:=0 to length(arSolusi[t].rute[a])-1 do
      XBest.rute[a,b]:=arSolusi[t].rute[a,b];
  end;
  XBest.sarang:=t+1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Awal;
  imgTitik.Canvas.Brush.Color := clWhite;
  imgTitik.Canvas.FillRect(Rect(0, 0, imgTitik.Width, imgTitik.Height));

  sgMatriks.Cells[0, 0] := 'Titik';
  sgMatriks.Cells[1, 0] := '0';
  sgMatriks.Cells[0, 1] := '0';

  sgCust.Cells[0, 0] := 'Customer';
  sgCust.Cells[1, 0] := 'Permintaan';
  sgCust.ColWidths[0]:=100;
  sgCust.ColWidths[1]:=120;
end;


procedure TForm1.Dashboard1Click(Sender: TObject);
begin
  Awal;
end;

procedure TForm1.Keluar1Click(Sender: TObject);
begin
  if Application.MessageBox('Anda Yakin Ingin Keluar?','Konfirmasi',MB_ICONINFORMATION+MB_YESNO)=IDYES
  then Form1.Close;
end;

procedure TForm1.imgTitikMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var P, i, b, a : Integer;
begin
  if (Button = mbLeft) then
  begin
    P := Length(arTitik);
    setLength(arTitik, P+1);
    arTitik[P].posisi := Point(X,Y);
    if p=0 then arTitik[P].warna := clGreen
    else arTitik[P].warna := clYellow;
    G.size := P+1;
    setLength(G.mtBobot, G.size, G.size);
    setLength(arCust, P);
    for i := 0 to G.size-2 do
    begin
      G.mtBobot[i, P] := 0;
      G.mtBobot[P, i] := 0;
    end;
    if G.size > 1 then
    begin
      sgMatriks.ColCount := sgMatriks.ColCount + 1;
      sgMatriks.RowCount := sgMatriks.RowCount + 1;
      sgMatriks.Col := 2;
      sgMatriks.Row := 1;
    end;
    b := sgMatriks.ColCount - 1;
    sgMatriks.Cells[0, b] := Format('%d', [b-1]);
    sgMatriks.Cells[b, 0] := Format('%d', [b-1]);
    GambarTitik(P, true);

    if P > 1 then
    begin
      sgCust.RowCount := sgCust.RowCount +1 ;
      sgCust.Row := 1;
    end;

    if P>0 then
      sgCust.Cells[0, P] := Format('%d', [P]);

    for a:=0 to length(arcust)-1 do
    begin
      arcust[a].Cust := a+1;
      arcust[a].Permintaan := 0;
    end;
  end;
end;

procedure TForm1.sgMatriksKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9', ',']) and not (Key = #13) and not(Key = #8) then
    Key := #00
  else
  if (Key = #13) then
    if sgMatriks.Col > sgMatriks.Row then
      if sgMatriks.Col < (sgMatriks.ColCount - 1) then
        sgMatriks.Col := sgMatriks.Col + 1
      else
        if sgMatriks.Row < (sgMatriks.RowCount - 2) then
        begin
          sgMatriks.Row := sgMatriks.Row + 1;
          sgMatriks.Col := sgMatriks.Row + 1;
        end
    else
    begin
      if sgMatriks.Col = sgMatriks.RowCount then
        if sgMatriks.Row < (sgMatriks.RowCount - 1) then
        begin
          sgMatriks.Row := sgMatriks.Row + 1;
          sgMatriks.Col := 1;
        end
        else
          sgMatriks.Col := sgMatriks.Col + 1;
      Key := #00;
    end;
end;

procedure TForm1.sgMatriksSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
var bobotLama, bobotBaru : real ;
begin
  bobotLama :=  G.mtBobot[ARow-1, ACol-1];
  if (Value='') and (bobotLama <> 0) then
  begin
    HapusSisi(ARow-1, ACol-1);
    sgMatriks.Cells[ARow, ACol] := value;
    G.mtBobot[ARow-1, ACol-1] := bobotBaru;
    G.mtBobot[ACol-1, ARow-1] := bobotBaru;
  end
  else
  if Value <> '' then
  begin
    bobotBaru := StrTofloat(Value);
    if (bobotLama=0) and (bobotBaru <> 0) then
    begin
      sgMatriks.Cells[ARow, ACol] := Value;
      G.mtBobot[ARow-1, ACol-1] := bobotBaru;
      G.mtBobot[ACol-1, ARow-1] := bobotBaru;
      GambarSisi(ARow-1, ACol-1);
    end
    else
    if (bobotLama <> 0) and (bobotBaru = 0) then
    begin
      HapusSisi(ARow-1, ACol-1);
      sgMatriks.Cells[ARow, ACol] := Value;
      G.mtBobot[ARow-1, ACol-1] := 0;
      G.mtBobot[ACol-1, ARow-1] := 0;
    end
    else
    if (bobotLama <> 0) and (bobotBaru <> 0) and (bobotLama <> bobotBaru) then
    begin
      HapusSisi(ARow-1, ACol-1);
      sgMatriks.Cells[ARow, ACol] := Value;
      G.mtBobot[ARow-1, ACol-1] := bobotBaru;
      G.mtBobot[ACol-1, ARow-1] := bobotBaru;
      GambarSisi(ARow-1, ACol-1);
    end
  end;
end;

procedure TForm1.sgMatriksDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (ACol = ARow) then
    if not (gdFixed in State) then
    begin
      sgMatriks.Canvas.Brush.Color := clGray;
      sgMatriks.Canvas.FillRect(Rect);
      sgMatriks.Canvas.Brush.Color := clWhite;
    end
  else
  if not (gdSelected in State) and not (gdFixed in State) then
    if sgMatriks.Cells[ACol, ARow] = '' then
      sgMatriks.Cells[ACol, ARow] := '0';
end;

procedure TForm1.sgMatriksSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  CanSelect := ACol <> ARow;
end;

procedure TForm1.sgCustKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9']) and not (Key = #13) and not(Key = #8) then
  begin
    Application.MessageBox('Masukkan Bilangan Integer!','Information', MB_OK or MB_ICONEXCLAMATION);
    Key := #00;
  end
  else
  if (Key = #13) then
  begin
    if sgCust.Row < sgCust.RowCount-1 then
      sgCust.Row := sgCust.Row + 1;
    Key := #00;
  end;
end;

procedure TForm1.sgCustSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
var key: char;
begin
  if Value <> '' then
    arcust[ARow-1].Permintaan:=strtoint(value)
end;

procedure TForm1.edKapasitasKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9']) and not (Key = #13) and not(Key = #8) then
  begin
    Key := #00;
    Application.MessageBox('Masukkan Bilangan Bulat!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end;
end;

procedure TForm1.edSarangKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9']) and not (Key = #13) and not(Key = #8) then
  begin
    Key := #00;
    Application.MessageBox('Masukkan Bilangan Bulat!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end;
end;

procedure TForm1.edPaKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9', ',']) and not (Key = #13) and not(Key = #8) then
  begin
    Key := #00;
    Application.MessageBox('Gunakan Tanda Koma!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end;
end;

procedure TForm1.edBanyakKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9']) and not (Key = #13) and not(Key = #8) then
  begin
    Key := #00;
    Application.MessageBox('Masukkan Bilangan Bulat!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end;
end;

procedure TForm1.edIterMaxKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9']) and not (Key = #13) and not(Key = #8) then
  begin
    Key := #00;
    Application.MessageBox('Masukkan Bilangan Bulat!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end;
end;

procedure TForm1.Mulai1Click(Sender: TObject);
begin
  Proses;
end;

procedure TForm1.Buka1Click(Sender: TObject);
var namafile: string;
begin
  if opendialog1.Execute then
  begin
    Hapus;
    namafile := opendialog1.FileName;
    if tformat(namafile)='xml' then dataset(namafile) else buka(namafile);
  end;
end;

procedure TForm1.Simpan1Click(Sender: TObject);
begin
  Simpan;
end;

procedure TForm1.Reset1Click(Sender: TObject);
begin
  Hapus;
end;

procedure TForm1.Button2Click(Sender: TObject);
var namafile: string;
begin
  if opendialog1.Execute then
  begin
    Hapus;
    namafile := opendialog1.FileName;
    if tformat(namafile)='xml' then dataset(namafile) else buka(namafile);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Proses;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Hapus;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if Application.MessageBox('Anda Yakin Ingin Keluar?','Konfirmasi',MB_ICONINFORMATION+MB_YESNO)=IDYES
  then Form1.Close;
end;

procedure TForm1.Cuckoo;
var a,b,c,i,t,iter,jumlah : integer;
    n,S,x,urut,sigma : real;
    UrSem,arRand : array of real;
    rute : array of string;
    himT: set of byte;
    arR : array of array of real;
begin
  setlength(arSarang, 0);
    Randomize;
    for a:=0 to bykSarang-1 do
    begin
      setlength(arSarang, length(arSarang)+1);
      for b:=0 to length(arCust)-1 do
      begin
        setlength(arSarang[a].nilai, length(arSarang[a].nilai)+1);
        setlength(arSarang[a].urutan, length(arSarang[a].urutan)+1);
        n := random;
        arSarang[a].nilai[b] := n;
      end;
    end;

    for a:=0 to bykSarang-1 do
    begin
      setlength(UrSem, length(arSarang[a].nilai));
      for b:=0 to length(arSarang[a].nilai)-1 do
        UrSem[b]:=arSarang[a].nilai[b];

      for b:=1 to length(UrSem)-1 do
      begin
        urut  := UrSem[b];
        c     := b-1;
        while (c>=0) and (UrSem[c] > urut) do
        begin
          UrSem[c+1] := UrSem[c];
          dec(c);
        end;
        UrSem[c+1] := urut;
      end;

      for b:=0 to length(UrSem)-1 do
      begin
        n := UrSem[b];
        i := 0;
        while i<length(UrSem) do
        begin
          if arSarang[a].nilai[i]=n then
          begin
            arSarang[a].urutan[i]:=b+1;
            i:=length(UrSem);
          end
          else i:=i+1;
        end;
      end;
    end;

{
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('2. Pembangkitan Awal Sarang dan Pengurutan Elemen Sarang');
    Form3.mmIter.Lines.Add('Tabel hasil pembangkitan awal sarang pada tab Pembangkitan Awal Sarang dan Pengurutan Elemen Sarang');
    Form3.sgAwal.Cells[0, 0] := 'Sarang';
    Form3.sgAwal.ColCount := length(arTitik);
    for a:=0 to length(arTitik)-1 do
      Form3.sgAwal.Cells[a+1, 0] := inttostr(a+1);
    for a:=0 to length(arSarang)-1 do
    begin
      for b:=0 to length(arSarang[a].nilai) do
      begin
        if b=0 then Form3.sgAwal.Cells[b, Form3.sgAwal.RowCount-1] := 'X 0'
        else Form3.sgAwal.Cells[b, Form3.sgAwal.RowCount-1] := formatfloat('0.###',arSarang[a].nilai[b-1]);
      end;
      Form3.sgAwal.RowCount := Form3.sgAwal.RowCount+1;
      for b:=0 to length(arSarang[a].urutan) do
      begin
        if b=0 then Form3.sgAwal.Cells[b, Form3.sgAwal.RowCount-1] := inttostr(a+1)
        else Form3.sgAwal.Cells[b, Form3.sgAwal.RowCount-1] := formatfloat('0.###',arSarang[a].urutan[b-1]);
      end;
      Form3.sgAwal.RowCount := Form3.sgAwal.RowCount+1;
    end;
//}

    buatrute(arSarang,'awal');

{
    Form2.mmOutput.Lines.Add('-----Rute Awal-----');
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('3. Menghitung Fungsi Tujuan dan Pembentukan Rute Keseluruhan Sarang');
    for a:=0 to bykSarang-1 do
    begin
      setlength(rute, length(arSolusi[a].rute));
      Form2.mmOutput.Lines.Add('Sarang '+inttostr(a+1)+' :');
      Form3.mmIter.Lines.Add('X 0-'+inttostr(a+1));
      for b:=0 to length(arSolusi[a].rute)-1 do
      begin
        for c:=0 to length(arSolusi[a].rute[b])-1 do
          if rute[b]='' then rute[b]:=rute[b]+inttostr(arSolusi[a].rute[b,c])
          else rute[b]:=rute[b]+'-'+inttostr(arSolusi[a].rute[b,c]);
        Form2.mmOutput.Lines.Add('Rute '+inttostr(b+1)+' = ['+rute[b]+'], jarak '+floattostr(HitungJarak(arSolusi[a].rute[b])));
        Form3.mmIter.Lines.Add('Rute '+inttostr(b+1)+' = ['+rute[b]+'], jarak '+floattostr(HitungJarak(arSolusi[a].rute[b])));
      end;
      setlength(rute, 0);
      Form2.mmOutput.Lines.Add('Total jarak '+floattostr(TotalJarak(arSolusi[a].rute)));
      Form2.mmOutput.Lines.Add('');
      Form3.mmIter.Lines.Add('f(X 0-'+inttostr(a+1)+')= '+floattostr(TotalJarak(arSolusi[a].rute)));
    end;
//}

    cariXBest;

{
    setlength(rute,0);
    Form2.mmOutput.Lines.Add('-----Rute Awal yang Terpilih-----');
    Form2.mmOutput.Lines.Add('Rute pada Sarang ke-'+inttostr(XBest.sarang));
    setlength(rute,length(XBest.rute));
    for a:=0 to length(XBest.rute)-1 do
    begin
      for b:=0 to length(XBest.rute[a])-1 do
        if rute[a]='' then rute[a]:=inttostr(XBest.rute[a,b])
        else rute[a]:=rute[a]+'-'+inttostr(XBest.rute[a,b]);
      Form2.mmOutput.Lines.Add('Rute '+inttostr(a+1)+' = ['+rute[a]+'], dengan jarak '+floattostr(HitungJarak(XBest.rute[a]))+' km');
    end;
    Form2.mmOutput.Lines.Add('Total jarak semua rute '+floattostr(TotalJarak(XBest.rute))+' km');
//}

  iter:=0;
  while iter<iterMax do
  begin
{
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('Iterasi ke-'+inttostr(iter+1)+' :');
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('4. Menentukan XBest Sementara');
    Form3.mmIter.Lines.Add('Sarang XBest sementara didapatkan dari hasil perhitungan fungsi tujuan terkecil,'+
    ' maka berdasarkan langkah sebelumnya, posisi sarang XBest sementara adalah '+
    'sarang X '+inttostr(iter)+'-'+inttostr(XBest.sarang)+'. Oleh karena itu, pada langkah selanjutnya posisi sarang X '+inttostr(iter)+'-'+inttostr(XBest.sarang)+' tidak diperbaharui.');
//}

    himV:=[];
    t:=XBest.sarang-1;
    himV:=himV+[t];
    setlength(arU, 0);
    setlength(arU, byksarang);
    for a:=0 to byksarang-1 do
      if not (a in himV) then
      begin
        setlength(arU[a], length(arCust));
        for b:=0 to length(arCust)-1 do
        begin
          n:=Math.RandG(0,1);
          arU[a,b]:=n;
        end;
      end;

{
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('5. Memperbaharui Posisi Sarang');
    Form3.mmIter.Lines.Add('Dalam tahap memperbaharui posisi sarang, digunakan Levy Flights Random Walk (LFRW)');
    Form3.mmIter.Lines.Add('o Menentukan nilai step length(S)');
    Form3.mmIter.Lines.Add('a. Membangkitkan nilai u yang merupakan bilangan real '+
    'yang diambil secara acak berdistribusi normal dengan rata-rata 0 dan simpangan baku '+
    '1 sebanyak customer.');
    Form3.mmIter.Lines.Add('Tabel hasil pembangkitan nilai u terdapat pada tab Nilai U');
    Form3.sgU.ColCount := length(arTitik);
    Form3.sgU.Cells[0, 0] := 'Sarang';
    for a:=0 to length(arTitik)-1 do
      Form3.sgU.Cells[a+1, 0] := inttostr(a+1);
    for a:=0 to length(arU)-1 do
    if a<t then
    begin
      for b:=0 to length(arU[a]) do
      begin
        if b=0 then Form3.sgU.Cells[b, Form3.sgU.RowCount-1] := 'X '+inttostr(iter)+'-'+inttostr(a+1)
        else Form3.sgU.Cells[b, Form3.sgU.RowCount-1] := formatfloat('0.###',arU[a,b-1]);
      end;
      Form3.sgU.RowCount := Form3.sgU.RowCount+1;
    end
    else if a>t then
    begin
      for b:=0 to length(arU[a]) do
      begin
        if b=0 then Form3.sgU.Cells[b, Form3.sgU.RowCount-1] := 'X '+inttostr(iter)+'-'+inttostr(a+1)
        else Form3.sgU.Cells[b, Form3.sgU.RowCount-1] := formatfloat('0.###',arU[a,b-1]);
      end;
      Form3.sgU.RowCount := Form3.sgU.RowCount+1;
    end;
    Form3.sgU.RowCount := Form3.sgU.RowCount+1;
//}

    setlength(arV, 0);
    setlength(arV, byksarang);
    for a:=0 to byksarang-1 do
      if not (a in himV) then
      begin
        setlength(arV[a], length(arCust));
        for b:=0 to length(arCust)-1 do
        begin
          n:=Math.RandG(0,1);
          arV[a,b]:=n;
        end;
      end;

{
    Form3.mmIter.Lines.Add('b. Membangkitkan nilai v yang merupakan bilangan real '+
    'yang diambil secara acak berdistribusi normal dengan rata-rata 0 dan simpangan baku '+
    '1 sebanyak customer.');
    Form3.mmIter.Lines.Add('Tabel hasil pembangkitan nilai v terdapat pada tab Nilai V');
    Form3.sgV.ColCount := length(arTitik);
    Form3.sgV.Cells[0, 0] := 'Sarang';
    for a:=0 to length(arTitik)-1 do
      Form3.sgV.Cells[a+1, 0] := inttostr(a+1);
    for a:=0 to length(arV)-1 do
    if a<t then
    begin
      for b:=0 to length(arV[a]) do
      begin
        if b=0 then Form3.sgV.Cells[b, Form3.sgV.RowCount-1] := 'X '+inttostr(iter)+'-'+inttostr(a+1)
        else Form3.sgV.Cells[b, Form3.sgV.RowCount-1] := formatfloat('0.###',arV[a,b-1]);
      end;
      Form3.sgV.RowCount := Form3.sgV.RowCount+1;
    end
    else if a>t then
    begin
      for b:=0 to length(arV[a]) do
      begin
        if b=0 then Form3.sgV.Cells[b, Form3.sgV.RowCount-1] := 'X '+inttostr(iter)+'-'+inttostr(a+1)
        else Form3.sgV.Cells[b, Form3.sgV.RowCount-1] := formatfloat('0.###',arV[a,b-1]);
      end;
      Form3.sgV.RowCount := Form3.sgV.RowCount+1;
    end;
    Form3.sgV.RowCount := Form3.sgV.RowCount+1;
//}

    sigma:=0.696574503;

{
    Form3.mmIter.Lines.Add('c. Menghitung Nilai Sigma.');
    Form3.mmIter.Lines.Add('Menghitung nilai sigma, menggunakan persamaan 2.13 dengan nilai beta = '+floattostr(beta));
    //Form3.mmIter.Lines.Add('menghasilkan nilai sigma=0,6965.');
//}

    setlength(arS, 0);
    setlength(arS, byksarang);
    for a:=0 to byksarang-1 do
      if not (a in himV) then
      begin
        setlength(arS[a], length(arCust));
        for b:=0 to length(arCust)-1 do
        begin
          S:=(arU[a,b] * sigma)/(power(abs(arV[a,b]),(1/beta)));
          arS[a,b]:=S;
        end;
      end;

{
    Form3.mmIter.Lines.Add('d. Menghitung Nilai S.');
    Form3.mmIter.Lines.Add('Tabel hasil perhitungan nilai S dapat dilihat pada tab Nilai S');
    Form3.sgS.ColCount := length(arTitik);
    Form3.sgS.Cells[0, 0] := 'Sarang';
    for a:=0 to length(arTitik)-1 do
      Form3.sgS.Cells[a+1, 0] := inttostr(a+1);
    for a:=0 to length(arS)-1 do
    if a<t then
    begin
      for b:=0 to length(arS[a]) do
      begin
        if b=0 then Form3.sgS.Cells[b, Form3.sgS.RowCount-1] := 'X '+inttostr(iter)+'-'+inttostr(a+1)
        else Form3.sgS.Cells[b, Form3.sgS.RowCount-1] := formatfloat('0.###',arS[a,b-1]);
      end;
      Form3.sgS.RowCount := Form3.sgS.RowCount+1;
    end
    else if a>t then
    begin
      for b:=0 to length(arS[a]) do
      begin
        if b=0 then Form3.sgS.Cells[b, Form3.sgS.RowCount-1] := 'X '+inttostr(iter)+'-'+inttostr(a+1)
        else Form3.sgS.Cells[b, Form3.sgS.RowCount-1] := formatfloat('0.###',arS[a,b-1]);
      end;
      Form3.sgS.RowCount := Form3.sgS.RowCount+1;
    end;
    Form3.sgS.RowCount := Form3.sgS.RowCount+1;
//}

    setlength(arK, 0);
    setlength(arK, byksarang);
    for a:=0 to byksarang-1 do
      if not (a in himV) then
      begin
        setlength(arK[a], length(arCust));
        for b:=0 to length(arCust)-1 do
        begin
          n:=Math.RandG(0,1);
          arK[a,b]:=n;
        end;
      end;

{
    Form3.mmIter.Lines.Add('o Memperbaharui posisi sarang');
    Form3.mmIter.Lines.Add('a. Membangkitkan nilai k yang merupakan bilangan real '+
    'yang diambil secara acak berdistribusi normal dengan rata-rata 0 dan simpangan baku '+
    '1 sebanyak customer.');
    Form3.mmIter.Lines.Add('Tabel hasil pembangkitan nilai k terdapat pada tab Nilai K');
    Form3.sgK.ColCount := length(arTitik);
    Form3.sgK.Cells[0, 0] := 'Sarang';
    for a:=0 to length(arTitik)-1 do
      Form3.sgK.Cells[a+1, 0] := inttostr(a+1);
    for a:=0 to length(arK)-1 do
    if a<t then
    begin
      for b:=0 to length(arK[a]) do
      begin
        if b=0 then Form3.sgK.Cells[b, Form3.sgK.RowCount-1] := 'X '+inttostr(iter)+'-'+inttostr(a+1)
        else Form3.sgK.Cells[b, Form3.sgK.RowCount-1] := formatfloat('0.###',arK[a,b-1]);
      end;
      Form3.sgK.RowCount := Form3.sgK.RowCount+1;
    end
    else if a>t then
    begin
      for b:=0 to length(arK[a]) do
      begin
        if b=0 then Form3.sgK.Cells[b, Form3.sgK.RowCount-1] := 'X '+inttostr(iter)+'-'+inttostr(a+1)
        else Form3.sgK.Cells[b, Form3.sgK.RowCount-1] := formatfloat('0.###',arK[a,b-1]);
      end;
      Form3.sgK.RowCount := Form3.sgK.RowCount+1;
    end;
    Form3.sgK.RowCount := Form3.sgK.RowCount+1;
//}

    setlength(arLevy, 0);
    setlength(arLevy, byksarang);
    for a:=0 to byksarang-1 do
      if not (a in himV) then
      begin
        setlength(arLevy[a].nilai, length(arCust));
        setlength(arLevy[a].urutan, length(arCust));
        for b:=0 to length(arCust)-1 do
        begin
          x:=arSarang[a].nilai[b]+(alfa * arS[a,b] * (arSarang[XBest.sarang-1].nilai[b] - arSarang[a].nilai[b]) * arK[a,b]);
          arLevy[a].nilai[b]:=x;
        end;
      end;

    for a:=0 to byksarang-1 do
      if not (a in himV) then
      begin
        setlength(UrSem, 0);
        setlength(UrSem, length(arLevy[a].nilai));
        for b:=0 to length(arLevy[a].nilai)-1 do
          UrSem[b]:=arLevy[a].nilai[b];

        for b:=1 to length(UrSem)-1 do
        begin
          urut  := UrSem[b];
          c     := b-1;
          while (c>=0) and (UrSem[c] > urut) do
          begin
            UrSem[c+1] := UrSem[c];
            dec(c);
          end;
          UrSem[c+1] := urut;
        end;

        for b:=0 to length(UrSem)-1 do
        begin
          n := UrSem[b];
          i := 0;
          while i<length(UrSem) do
            if arLevy[a].nilai[i]=n then
            begin
              arLevy[a].urutan[i]:=b+1;
              i:=length(UrSem);
            end
            else i:=i+1;
        end;
      end;

{
    Form3.mmIter.Lines.Add('b. Menghitung nilai Levy Flights.');
    Form3.mmIter.Lines.Add('Tabel hasil perhitungan nilai Levy Flights terdapat pada tab Nilai Levy Flights');
    Form3.sgLevy.Cells[0, 0] := 'Sarang';
    Form3.sgLevy.ColCount := length(arTitik);
    for a:=0 to length(arTitik)-1 do
      Form3.sgLevy.Cells[a+1, 0] := inttostr(a+1);
    for a:=0 to length(arLevy)-1 do
    if a<t then
    begin
      for b:=0 to length(arLevy[a].nilai) do
      begin
        if b=0 then Form3.sgLevy.Cells[b, Form3.sgLevy.RowCount-1]:='X '+inttostr(iter)
        else form3.sgLevy.Cells[b, Form3.sgLevy.RowCount-1]:=formatfloat('0.###',arLevy[a].nilai[b-1]);
      end;
      Form3.sgLevy.RowCount := Form3.sgLevy.RowCount + 1;
      for b:=0 to length(arLevy[a].urutan) do
      begin
        if b=0 then Form3.sgLevy.Cells[b, Form3.sgLevy.RowCount-1]:=inttostr(a+1)
        else form3.sgLevy.Cells[b, Form3.sgLevy.RowCount-1]:=formatfloat('0.###',arLevy[a].urutan[b-1]);
      end;
      Form3.sgLevy.RowCount := Form3.sgLevy.RowCount + 1;
    end
    else if a>t then
    begin
      for b:=0 to length(arLevy[a].nilai) do
      begin
        if b=0 then Form3.sgLevy.Cells[b, Form3.sgLevy.RowCount-1]:='X '+inttostr(iter)
        else form3.sgLevy.Cells[b, Form3.sgLevy.RowCount-1]:=formatfloat('0.###',arLevy[a].nilai[b-1]);
      end;
      Form3.sgLevy.RowCount := Form3.sgLevy.RowCount + 1;
      for b:=0 to length(arLevy[a].urutan) do
      begin
        if b=0 then Form3.sgLevy.Cells[b, Form3.sgLevy.RowCount-1]:=inttostr(a+1)
        else form3.sgLevy.Cells[b, Form3.sgLevy.RowCount-1]:=formatfloat('0.###',arLevy[a].urutan[b-1]);
      end;
      Form3.sgLevy.RowCount := Form3.sgLevy.RowCount + 1;
    end;
    Form3.sgLevy.RowCount := Form3.sgLevy.RowCount + 1;
//}

    buatrute(arLevy,'sementara');

{
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('6. Menghitung Fungsi Tujuan Hasil Pembaharuan Sarang Dengan LFRW');
    setlength(rute, 0);
    for a:=0 to bykSarang-1 do
    if a<>t then
    begin
      setlength(rute, length(arSem[a].rute));
      Form3.mmIter.Lines.Add('X 0-'+inttostr(a+1));
      for b:=0 to length(arSem[a].rute)-1 do
      begin
        for c:=0 to length(arSem[a].rute[b])-1 do
          if rute[b]='' then rute[b]:=rute[b]+inttostr(arSem[a].rute[b,c])
          else rute[b]:=rute[b]+'-'+inttostr(arSem[a].rute[b,c]);
        Form3.mmIter.Lines.Add('Rute '+inttostr(b+1)+' = ['+rute[b]+'], jarak '+floattostr(HitungJarak(arSem[a].rute[b])));
      end;
      setlength(rute, 0);
      Form3.mmIter.Lines.Add('f(X 0-'+inttostr(a+1)+')= '+floattostr(TotalJarak(arSem[a].rute)));
    end;
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('7. Membandingkan nilai fungsi tujuan sarang awal dan sarang hasil LFRW.');
//}

      himT:=[];
      himT:=himT+[XBest.sarang-1];
      setlength(rute, 1);
      rute[0]:='';
      for a:=0 to byksarang-1 do
        if not (a in himV) then
        begin
          repeat
            t:=random(byksarang);
          until not (t in himT);
          himT:=himT+[t];

          Form3.mmIter.Lines.Add('f(X '+inttostr(iter)+'-'+inttostr(a+1)+')='+floattostr(TotalJarak(arSolusi[a].rute))+
          ', f(X '+inttostr(iter+1)+'-'+inttostr(t+1)+')='+floattostr(TotalJarak(arSem[t].rute)));

          if TotalJarak(arSem[t].rute)<=TotalJarak(arSolusi[a].rute) then
          begin
            setlength(arSolusi[a].rute,length(arSem[t].rute));
            for b:=0 to length(arSem[t].rute)-1 do
            begin
              setlength(arSolusi[a].rute[b], length(arSem[t].rute[b]));
              for c:=0 to length(arSem[t].rute[b])-1 do
                arSolusi[a].rute[b,c]:=arSem[t].rute[b,c];
            end;
            for b:=0 to length(arLevy[t].nilai)-1 do
            begin
              arSarang[a].nilai[b] := arLevy[t].nilai[b];
              arSarang[a].urutan[b] := arLevy[t].urutan[b];
            end;
            rute[0]:=rute[0]+'X '+inttostr(iter+1)+'-'+inttostr(t+1)+', ';
          end;
        end;

{
  Form3.mmIter.Lines.Add('Ganti nilai fungsi tujuan awal dengan nilai fungsi '+rute[0]+'hasil LFRW.');
  Form3.mmIter.Lines.Add('Tabel hasil fungsi tujuan baru pada tab Pergantian Nilai Fungsi Tujuan');
  Form3.mmIter.Lines.Add('');

    Form3.sgGanti.Cells[0, 0] := 'Sarang';
    Form3.sgGanti.ColCount := length(arTitik);
    for a:=0 to length(arTitik)-1 do
      Form3.sgGanti.Cells[a+1, 0] := inttostr(a+1);
    for a:=0 to length(arSarang)-1 do
    begin
      for b:=0 to length(arSarang[a].nilai) do
      begin
        if b=0 then Form3.sgGanti.Cells[b, Form3.sgGanti.RowCount-1] := 'X '+inttostr(iter)
        else Form3.sgGanti.Cells[b, Form3.sgGanti.RowCount-1] := formatfloat('0.###',arSarang[a].nilai[b-1]);
      end;
      Form3.sgGanti.RowCount := Form3.sgGanti.RowCount+1;
      for b:=0 to length(arSarang[a].urutan) do
      begin
        if b=0 then Form3.sgGanti.Cells[b, Form3.sgGanti.RowCount-1] := inttostr(a+1)
        else Form3.sgGanti.Cells[b, Form3.sgGanti.RowCount-1] := formatfloat('0.###',arSarang[a].urutan[b-1]);
      end;
      Form3.sgGanti.RowCount := Form3.sgGanti.RowCount+1;
    end;
    Form3.sgGanti.RowCount := Form3.sgGanti.RowCount+1;
//}

{
    Form3.mmIter.Lines.Add('- Hasil Perbaharui Posisi Sarang dengan Levy Flights Random Walk -');
    Form3.mmIter.Lines.Add('  Hasil Rute:');
    setlength(rute, 0);
    for a:=0 to byksarang-1 do
    begin
      Form3.mmIter.Lines.Add('  Sarang '+inttostr(a+1));
      setlength(rute, length(arSolusi[a].rute));
      for b:=0 to length(arSolusi[a].rute)-1 do
      begin
        for c:=0 to length(arSolusi[a].rute[b])-1 do
          if rute[b]='' then rute[b]:=rute[b]+inttostr(arSolusi[a].rute[b,c])
          else rute[b]:=rute[b]+'-'+inttostr(arSolusi[a].rute[b,c]);
        Form3.mmIter.Lines.Add('  Rute '+inttostr(b+1)+' = ['+rute[b]+'], jarak '+floattostr(HitungJarak(arSolusi[a].rute[b])));
      end;
      setlength(rute, 0);
      Form3.mmIter.Lines.Add('  Total jarak '+floattostr(TotalJarak(arSolusi[a].rute)));
    end;
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('8. Pergantian Sarang Terburuk');
    Form3.mmIter.Lines.Add('a. Membangkitkan nilai rand1');
    Form3.mmIter.Lines.Add('Tabel hasil pembangkitan nilai bilangan real acak pada interval (0,1) pada tab Nilai Rand, R, dan Index Sarang');
//}

    setlength(arRand, byksarang);
    for a:=0 to byksarang-1 do
    begin
      n:=random;
      arRand[a]:=n;
    end;
    himV:=[];
    for a:=0 to byksarang-1 do
      if arRand[a]<Pa then
        himV:=himV+[a];

{
    Form3.sgRand.ColCount := 3;
    Form3.sgRand.Cells[0, 0] := 'Sarang';
    Form3.sgRand.Cells[1, 0] := 'Rand1';
    Form3.sgRand.Cells[2, 0] := 'Pa';
    for a:=0 to length(arRand)-1 do
    begin
      Form3.sgRand.Cells[0, Form3.sgRand.RowCount-1] := 'X '+inttostr(iter+1)+'-'+inttostr(a+1);
      Form3.sgRand.Cells[1, Form3.sgRand.RowCount-1] := formatfloat('0.###',arRand[a]);
      Form3.sgRand.Cells[2, Form3.sgRand.RowCount-1] := floattostr(Pa);
      Form3.sgRand.RowCount := Form3.sgRand.RowCount+1;
    end;
    Form3.sgRand.RowCount := Form3.sgRand.RowCount+1;
//}

    jumlah:=0;
    setlength(arR, byksarang);
    for a:=0 to byksarang-1 do
      if not (a in himV) then
      begin
        setlength(arR[a], length(arCust));
        for b:=0 to length(arCust)-1 do
        begin
          n:=random;
          arR[a,b]:=n;
        end;
        jumlah:=jumlah+1;
      end;

{
    Form3.mmIter.Lines.Add('b. Membangkitkan nilai R');
    Form3.mmIter.Lines.Add('Tabel hasil pembangkitan nilai R pada tab Nilai Rand, R, dan Index Sarang');
    Form3.sgR.Cells[0, 0] := 'Sarang';
    Form3.sgR.ColCount := length(arTitik);
    for a:=0 to length(arTitik)-1 do
      Form3.sgR.Cells[a+1, 0] := inttostr(a+1);
    a:=0;
    while a<length(arR) do
    begin
      if not (a in himV) then
      begin
        for b:=0 to length(arR[a]) do
        begin
          if b=0 then Form3.sgR.Cells[b, Form3.sgR.RowCount-1] := 'X '+inttostr(iter+1)+'-'+inttostr(a+1)
          else Form3.sgR.Cells[b, Form3.sgR.RowCount-1] := formatfloat('0.###',arR[a,b-1]);
        end;
        Form3.sgR.RowCount := Form3.sgR.RowCount+1;
      end;
      a:=a+1;
    end;
    Form3.sgR.RowCount := Form3.sgR.RowCount+1;

//}

    setlength(arPermut, byksarang);
    for a:=0 to byksarang-1 do
      if not (a in himV) then
      begin
        b:=random(bykSarang);
        arPermut[a].satu:=b;
        c:=random(bykSarang);
        arPermut[a].dua:=c;
      end;
{
    Form3.mmIter.Lines.Add('c. Membangkitkan Index Sarang Permut1 dan Permut2');
    Form3.mmIter.Lines.Add('Tabel hasil pembangkitan index sarang permut1 dan permut2 pada tab Nilai Rand, R, dan Index Sarang');
    Form3.sgIndex.RowCount := Form3.sgIndex.RowCount+2;
    Form3.sgIndex.Cells[0, Form3.sgIndex.RowCount-3] := 'Sarang';
    Form3.sgIndex.Cells[0, Form3.sgIndex.RowCount-2] := 'permut1';
    Form3.sgIndex.Cells[0, Form3.sgIndex.RowCount-1] := 'permut2';
    a:=0;
    t:=1;
    while a<length(arPermut) do
    begin
      if not (a in himV) then
      begin
        if t>Form3.sgIndex.ColCount-1 then
          Form3.sgIndex.ColCount := Form3.sgIndex.ColCount+1;
        Form3.sgIndex.Cells[t, Form3.sgIndex.RowCount-3] := 'X '+inttostr(iter+1)+'-'+inttostr(a+1);
        Form3.sgIndex.Cells[t, Form3.sgIndex.RowCount-2] := formatfloat('0.###',arPermut[a].satu+1);
        Form3.sgIndex.Cells[t, Form3.sgIndex.RowCount-1] := formatfloat('0.###',arPermut[a].dua+1);
        t:=t+1;
      end;
      a:=a+1;
    end;
    Form3.sgIndex.RowCount := Form3.sgIndex.RowCount+2;
//}

    setlength(arBRW, 0);
    setlength(arBRW, bykSarang);
    for a:=0 to bykSarang-1 do
      if not (a in himV) then
      begin
        setlength(arBRW[a].nilai, length(arCust));
        setlength(arBRW[a].urutan, length(arCust));
        for b:=0 to length(arCust)-1 do
        begin
          x:=arSarang[a].nilai[b]+(arR[a,b] * (arSarang[arPermut[a].satu].nilai[b]-arSarang[arPermut[a].dua].nilai[b]));
          arBRW[a].nilai[b]:=x;
        end;
      end;
    for a:=0 to bykSarang-1 do
      if not (a in himV) then
      begin
        setlength(UrSem, 0);
        setlength(UrSem, length(arBRW[a].nilai));
        for b:=0 to length(arBRW[a].nilai)-1 do
          UrSem[b]:=arBRW[a].nilai[b];

        for b:=1 to length(UrSem)-1 do
        begin
          urut  := UrSem[b];
          c     := b-1;
          while (c>=0) and (UrSem[c] > urut) do
          begin
            UrSem[c+1] := UrSem[c];
            dec(c);
          end;
          UrSem[c+1] := urut;
        end;

        for b:=0 to length(UrSem)-1 do
        begin
          n := UrSem[b];
          i := 0;
          while i<length(UrSem) do
            if arBRW[a].nilai[i]=n then
            begin
              arBRW[a].urutan[i]:=b+1;
              i:=length(UrSem);
            end
            else i:=i+1;
        end;
      end;

{
    Form3.mmIter.Lines.Add('d. Menghitung Nilai BRW dengan menggunakan persamaan 2.14');
    Form3.mmIter.Lines.Add('Tabel hasil pembangkitan nilai BRW pada tab Nilai BRW');
    Form3.sgBRW.Cells[0, 0] := 'Sarang';
    Form3.sgBRW.ColCount := length(arTitik);
    for a:=0 to length(arTitik)-1 do
      Form3.sgBRW.Cells[a+1, 0] := inttostr(a+1);
    a:=0;
    while a<length(arBRW) do
    begin
      if not (a in himV) then
      begin
        for b:=0 to length(arBRW[a].nilai) do
        begin
          if b=0 then Form3.sgBRW.Cells[b, Form3.sgBRW.RowCount-1] := 'X '+inttostr(iter+1)
          else Form3.sgBRW.Cells[b, Form3.sgBRW.RowCount-1] := formatfloat('0.###',arBRW[a].nilai[b-1]);
        end;
        Form3.sgBRW.RowCount := Form3.sgBRW.RowCount+1;
        for b:=0 to length(arBRW[a].urutan) do
        begin
          if b=0 then Form3.sgBRW.Cells[b, Form3.sgBRW.RowCount-1] := inttostr(a+1)
          else Form3.sgBRW.Cells[b, Form3.sgBRW.RowCount-1] := formatfloat('0.###',arBRW[a].urutan[b-1]);
        end;
        Form3.sgBRW.RowCount := Form3.sgBRW.RowCount+1;
      end;
      a:=a+1;
    end;
    Form3.sgBRW.RowCount := Form3.sgBRW.RowCount+1;
//}

    buatrute(arBRW,'sementara');

{
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('Berikut hasil pergantian sarang terburuk dengan BRW');
    setlength(rute, 0);
    for a:=0 to bykSarang-1 do
    if not (a in himV) then
    begin
      setlength(rute, length(arSem[a].rute));
      Form3.mmIter.Lines.Add('X '+inttostr(iter+1)+'-'+inttostr(a+1));
      for b:=0 to length(arSem[a].rute)-1 do
      begin
        for c:=0 to length(arSem[a].rute[b])-1 do
          if rute[b]='' then rute[b]:=rute[b]+inttostr(arSem[a].rute[b,c])
          else rute[b]:=rute[b]+'-'+inttostr(arSem[a].rute[b,c]);
        Form3.mmIter.Lines.Add('Rute '+inttostr(b+1)+' = ['+rute[b]+'], jarak '+floattostr(HitungJarak(arSem[a].rute[b])));
      end;
      setlength(rute, 0);
      Form3.mmIter.Lines.Add('f(X '+inttostr(iter+1)+'-'+inttostr(a+1)+')= '+floattostr(TotalJarak(arSem[a].rute)));
    end;
    Form3.mmIter.Lines.Add('');
    Form3.mmIter.Lines.Add('9. Membandingkan nilai fungsi tujuan sarang awal dan sarang hasil BRW.');
//}

    setlength(rute, 1);
    rute[0]:='';
    himT:=[];
    himT:=himT+himV;
    for a:=0 to bykSarang-1 do
      if not (a in himV) then
      begin
        repeat
          t:=random(byksarang);
        until not (t in himT);
        himT:=himT+[t];
        
        Form3.mmIter.Lines.Add('f(X '+inttostr(iter+1)+'-'+inttostr(a+1)+')='+floattostr(TotalJarak(arSolusi[a].rute))+
        ', f(X '+inttostr(iter+1)+'-'+inttostr(t+1)+')='+floattostr(TotalJarak(arSem[t].rute)));
        if TotalJarak(arSem[t].rute)<=TotalJarak(arSolusi[a].rute) then
        begin
          setlength(arSolusi[a].rute,length(arSem[t].rute));
          for b:=0 to length(arSem[t].rute)-1 do
          begin
            setlength(arSolusi[a].rute[b], length(arSem[t].rute[b]));
            for c:=0 to length(arSem[t].rute[b])-1 do
              arSolusi[a].rute[b,c]:=arSem[t].rute[b,c];
          end;
          for b:=0 to length(arBRW[t].nilai)-1 do
          begin
            arSarang[a].nilai[b] := arBRW[t].nilai[b];
            arSarang[a].urutan[b] := arBRW[t].urutan[b];
          end;
          rute[0]:=rute[0]+'X '+inttostr(iter+1)+'-'+inttostr(t+1)+', ';
        end;
      end;

{
    Form3.mmIter.Lines.Add('Update nilai fungsi tujuan awal dengan nilai fungsi '+rute[0]+'hasil BRW.');
    Form3.mmIter.Lines.Add('Tabel hasil fungsi tujuan baru pada tab Pergantian Sarang Terburuk');
    Form3.mmIter.Lines.Add('');

    Form3.sgUpdate.Cells[0, 0] := 'Sarang';
    Form3.sgUpdate.ColCount := length(arTitik);
    for a:=0 to length(arTitik)-1 do
      Form3.sgUpdate.Cells[a+1, 0] := inttostr(a+1);
    for a:=0 to length(arSarang)-1 do
    begin
      for b:=0 to length(arSarang[a].nilai) do
      begin
        if b=0 then Form3.sgUpdate.Cells[b, Form3.sgUpdate.RowCount-1] := 'X '+inttostr(iter+1)
        else Form3.sgUpdate.Cells[b, Form3.sgUpdate.RowCount-1] := formatfloat('0.###',arSarang[a].nilai[b-1]);
      end;
      Form3.sgUpdate.RowCount := Form3.sgUpdate.RowCount+1;
      for b:=0 to length(arSarang[a].urutan) do
      begin
        if b=0 then Form3.sgUpdate.Cells[b, Form3.sgUpdate.RowCount-1] := inttostr(a+1)
        else Form3.sgUpdate.Cells[b, Form3.sgUpdate.RowCount-1] := inttostr(arSarang[a].urutan[b-1]);
      end;
      Form3.sgUpdate.RowCount := Form3.sgUpdate.RowCount+1;
    end;
    Form3.sgUpdate.RowCount := Form3.sgUpdate.RowCount+1;
//}

{
    Form3.mmIter.Lines.Add('- Pergantian Sarang Terburuk dengan Biased Random Walk -');
    Form3.mmIter.Lines.Add('  Hasil Rute:');
    setlength(rute, 0);
    for a:=0 to bykSarang-1 do
    begin
      Form3.mmIter.Lines.Add('  Sarang '+inttostr(a+1));
      setlength(rute, length(arSolusi[a].rute));
      for b:=0 to length(arSolusi[a].rute)-1 do
      begin
        for c:=0 to length(arSolusi[a].rute[b])-1 do
          if rute[b]='' then rute[b]:=rute[b]+inttostr(arSolusi[a].rute[b,c])
          else rute[b]:=rute[b]+'-'+inttostr(arSolusi[a].rute[b,c]);
        Form3.mmIter.Lines.Add('  Rute '+inttostr(b+1)+' = ['+rute[b]+'], jarak '+floattostr(HitungJarak(arSolusi[a].rute[b])));
      end;
      setlength(rute, 0);
      Form3.mmIter.Lines.Add('  Total jarak '+floattostr(TotalJarak(arSolusi[a].rute)));
    end;
    Form3.mmIter.Lines.Add('');//}

    cariXBest;

    iter:=iter+1;
  end;
  Form3.sgAwal.RowCount := Form3.sgAwal.RowCount-1;
  Form3.sgU.RowCount := Form3.sgU.RowCount-2;
  Form3.sgV.RowCount := Form3.sgV.RowCount-2;
  Form3.sgS.RowCount := Form3.sgS.RowCount-2;
  Form3.sgK.RowCount := Form3.sgK.RowCount-2;
  Form3.sgLevy.RowCount := Form3.sgLevy.RowCount-2;
  Form3.sgGanti.RowCount := Form3.sgGanti.RowCount-2;
  Form3.sgRand.RowCount := Form3.sgRand.RowCount-2;
  Form3.sgR.RowCount := Form3.sgR.RowCount-2;
  Form3.sgIndex.RowCount := Form3.sgIndex.RowCount-2;
  Form3.sgBRW.RowCount := Form3.sgBRW.RowCount-2;
  Form3.sgUpdate.RowCount := Form3.sgUpdate.RowCount-2;

    setlength(rute,0);
    //Form2.mmOutput.Lines.Add('');
    //Form2.mmOutput.Lines.Add('-----Solusi Rute Terbaik-----');
    setlength(rute,length(XBest.rute));
    for a:=0 to length(XBest.rute)-1 do
    begin
      for b:=0 to length(XBest.rute[a])-1 do
        if rute[a]='' then rute[a]:=rute[a]+inttostr(XBest.rute[a,b])
        else rute[a]:=rute[a]+'-'+inttostr(XBest.rute[a,b]);
        Form2.mmOutput.Lines.Add('Rute '+inttostr(a+1)+'  = '+rute[a]);
        //Form2.mmOutput.Lines.Add('Panjang rute: '+floattostr(HitungJarak(XBest.rute[a]))+'km');
        //Form2.mmOutput.Lines.Add('');
    end;
    Form2.mmOutput.Lines.Add('Total jarak semua rute '+floattostr(TotalJarak(XBest.rute))+'km');
end;

procedure TForm1.Dataset(const files: string);
var Instance: IXMLInstanceType;
    i, j, byktitik, bykparameter : byte;
    bobot : real;
    permintaan, kapasitas, x, y, Xmin, Xmax, Ymin, Ymax, width, height, Tx, Ty : integer;
    pos : array of array of integer;
begin
  {if opendialog1.Execute then
  begin
    Hapus;}
    Instance := Loadinstance(files);
    Form2.mmoutput.Clear;

    byktitik := instance.Network.Nodes.Count; //baca banyak titik
    G.size := bykTitik;
    setLength(G.mtBobot, G.size, G.size);
    setlength(arTitik, bykTitik);
    sgMatriks.ColCount := bykTitik+1;
    SgMatriks.RowCount := bykTitik+1;
    for i := 1 to bykTitik do
    begin
      sgMatriks.Cells[0, i] := Format('%d', [i-1]);
      sgMatriks.Cells[i, 0] := Format('%d', [i-1]);
    end;
    sgCust.ColWidths[0]:=100;
    sgCust.ColWidths[1]:=120;

    //baca permintaan
    bykparameter:=instance.Requests.Count;
    setlength(arCust, bykParameter);
    sgCust.RowCount:=bykParameter+1;
    sgCust.Cells[0, 0] := 'Customer';
    sgCust.Cells[1, 0] := 'Permintaan';
    for i:=0 to length(arCust)-1 do
    begin
      arCust[i].Cust := i+1;
      sgCust.Cells[0, i+1] := Format('%d', [i+1]);
    end;
    for i:=0 to length(arCust)-1 do
    begin
      permintaan:=instance.Requests.Request[i].Quantity; //baca permintaan
      arCust[i].Permintaan:=permintaan;
      sgCust.Cells[1,i+1]:=inttostr(permintaan);
    end;

    edKapasitas.Text:=inttostr(instance.Fleet.Vehicle_profile.Capacity); //baca kapasitas

      x:=instance.Network.Nodes[0].Cx; //baca cx
      y:=instance.Network.Nodes[0].Cy; //baca cy

      setLength(arTitik, bykTitik); //set array posisi
      setLength(pos, bykTitik, 2);

      Xmin := X;
      Xmax := X;
      Ymin := Y;
      Ymax := Y;
      pos[0,0] := X;
      pos[0,1] := Y;
      arTitik[0].warna:=clGreen;

    for i:=1 to instance.Network.Nodes.Count-1 do
    begin
      x:=instance.Network.Nodes[i].Cx; //baca cx
      y:=instance.Network.Nodes[i].Cy; //baca cy

      if X < Xmin then Xmin := X;
      if X > Xmax then Xmax := X;
      if Y < Ymin then Ymin := Y;
      if Y > Ymax then Ymax := Y;
      pos[i,0] := X;
      pos[i,1] := Y;
      arTitik[i].warna:=clyellow;
    end;

    width := Form2.imghasil.Width-40;
    height := Form2.imghasil.Height-50;

    for i := 0 to bykTitik-1 do
    begin
      tX := pos[i,0];
      tY := pos[i,1];
      if Xmin < 0 then
      begin
        if tX < 0 then tX := tX-Xmin
          else tX := tX + abs(Xmin);
      end else
        tX := tX - Xmin;

      if Ymin < 0 then
      begin
        if tY < 0 then tY := tY-Ymin
          else tY := tY + abs(Ymin);
      end else
        tY := tY - Ymin;

      arTitik[i].posisi.X := Round(tX/(Xmax-Xmin)*Width)+20;
      arTitik[i].posisi.Y := Round(tY/(Ymax-Ymin)*Height)+20;
    end;

    setLength(G.mtBobot, bykTitik, bykTitik); //set matriks bobot
    for i := 0 to bykTitik-1 do
    begin
      for j := 0 to bykTitik-1 do
      begin
        if j > i then
        begin
          bobot := sqrt((sqr(pos[i,0]-pos[j,0])) + (sqr(pos[i,1]-pos[j,1])));
          bobot := round(bobot*10)/100;
          G.mtBobot[i, j] := bobot; //masukkan kelemen [i,j]
          G.mtBobot[j, i] := bobot; //masukkan keelemen [j,i]
          sgMatriks.Cells[j+1, i+1] := FloatToStr (bobot);
          sgMatriks.Cells[i+1, j+1] := FloatToStr (bobot);
        end;
      end;
    end;

    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        if j > i then
          if G.mtBobot[i, j] <> 0 then  //bila ada sisinya
            GambarSisi(i, j); //gambar sisi
  //end;
end;

function TForm1.tformat(value: string): string;
var i:integer;
begin
  result:='';
  for i:=1 to length(value) do
  begin
    if value[i]<>'.' then
      result:=result+value[i]
    else
      result:='';
  end;
end;

procedure TForm1.hapusiter;
var i,j: integer;
begin
  Form3.mmIter.Lines.Clear;
  setlength(arLevy,0);
  setlength(arBRW,0);
  setlength(arSem,0);
  setlength(arPermut,0);
  setlength(arU,0,0);
  setlength(arV,0,0);
  setlength(arS,0,0);
  setlength(arK,0,0);
  for i:=0 to Form3.sgAwal.ColCount-1 do
    for j:=0 to Form3.sgAwal.RowCount-1 do
      Form3.sgAwal.Cells[i,j]:='';
  Form3.sgAwal.ColCount := 2;
  Form3.sgAwal.RowCount := 2;
  for i:=0 to Form3.sgU.ColCount-1 do
    for j:=0 to Form3.sgU.RowCount-1 do
      Form3.sgU.Cells[i,j]:='';
  Form3.sgU.ColCount := 2;
  Form3.sgU.RowCount := 2;
  for i:=0 to Form3.sgV.ColCount-1 do
    for j:=0 to Form3.sgV.RowCount-1 do
      Form3.sgV.Cells[i,j]:='';
  Form3.sgV.ColCount := 2;
  Form3.sgV.RowCount := 2;
  for i:=0 to Form3.sgS.ColCount-1 do
    for j:=0 to Form3.sgS.RowCount-1 do
      Form3.sgS.Cells[i,j]:='';
  Form3.sgS.ColCount := 2;
  Form3.sgS.RowCount := 2;
  for i:=0 to Form3.sgK.ColCount-1 do
    for j:=0 to Form3.sgK.RowCount-1 do
      Form3.sgK.Cells[i,j]:='';
  Form3.sgK.ColCount := 2;
  Form3.sgK.RowCount := 2;
  for i:=0 to Form3.sgLevy.ColCount-1 do
    for j:=0 to Form3.sgLevy.RowCount-1 do
      Form3.sgLevy.Cells[i,j]:='';
  Form3.sgLevy.ColCount := 2;
  Form3.sgLevy.RowCount := 2;
  for i:=0 to Form3.sgGanti.ColCount-1 do
    for j:=0 to Form3.sgGanti.RowCount-1 do
      Form3.sgGanti.Cells[i,j]:='';
  Form3.sgGanti.ColCount := 2;
  Form3.sgGanti.RowCount := 2;
  for i:=0 to Form3.sgRand.ColCount-1 do
    for j:=0 to Form3.sgRand.RowCount-1 do
      Form3.sgRand.Cells[i,j]:='';
  Form3.sgRand.ColCount := 2;
  Form3.sgRand.RowCount := 2;
  for i:=0 to Form3.sgR.ColCount-1 do
    for j:=0 to Form3.sgR.RowCount-1 do
      Form3.sgR.Cells[i,j]:='';
  Form3.sgR.ColCount := 2;
  Form3.sgR.RowCount := 2;
  for i:=0 to Form3.sgIndex.ColCount-1 do
    for j:=0 to Form3.sgIndex.RowCount-1 do
      Form3.sgIndex.Cells[i,j]:='';
  Form3.sgIndex.ColCount := 2;
  Form3.sgIndex.RowCount := 1;
  for i:=0 to Form3.sgBRW.ColCount-1 do
    for j:=0 to Form3.sgBRW.RowCount-1 do
      Form3.sgBRW.Cells[i,j]:='';
  Form3.sgBRW.ColCount := 2;
  Form3.sgBRW.RowCount := 2;
  for i:=0 to Form3.sgUpdate.ColCount-1 do
    for j:=0 to Form3.sgUpdate.RowCount-1 do
      Form3.sgUpdate.Cells[i,j]:='';
  Form3.sgUpdate.ColCount := 2;
  Form3.sgUpdate.RowCount := 2;
end;

procedure TForm1.edAKeyPress(Sender: TObject; var Key: Char);
begin
if not(Key in ['0'..'9', ',']) and not (Key = #13) and not(Key = #8) then
  begin
    Key := #00;
    Application.MessageBox('Gunakan Tanda Koma!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end;
end;

procedure TForm1.edBKeyPress(Sender: TObject; var Key: Char);
begin
if not(Key in ['0'..'9', ',']) and not (Key = #13) and not(Key = #8) then
  begin
    Key := #00;
    Application.MessageBox('Gunakan Tanda Koma!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end;
end;

end.
