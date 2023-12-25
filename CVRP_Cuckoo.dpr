program CVRP_Cuckoo;

uses
  Forms,
  Awal in 'Awal.pas' {Form1},
  Hasil in 'Hasil.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  dataset in 'dataset.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Algoritma Cuckoo Search pada CVRP';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
