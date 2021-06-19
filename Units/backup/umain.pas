unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnOk: TButton;
    cbTipoDejeto: TComboBox;
    cbTipoNutr: TComboBox;
    edtQrn: TEdit;
    lbQrn: TLabel;
    lbSaida1: TLabel;
    lbSaida2: TLabel;
    lbSaida3: TLabel;
    lbSaida4: TLabel;
    lbTipDej: TLabel;
    lbTipoNutr: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure cbTipoDejetoChange(Sender: TObject);
    procedure cbTipoNutrChange(Sender: TObject);
    procedure materiaSeca();
    procedure consentracaoNutriente();
  private
         var tipoNutr, dejeto : integer;
         var saida2, qrn, ms, c, ie, n, p, k, mn, mp, mk : real;
         var qrns, saida2s : string;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.cbTipoNutrChange(Sender: TObject);
begin
  tipoNutr := cbTipoNutr.ItemIndex;
end;

procedure TForm1.cbTipoDejetoChange(Sender: TObject);
begin
  dejeto := cbTipoDejeto.ItemIndex;
end;

procedure TForm1.btnOkClick(Sender: TObject);
begin
     if (cbTipoNutr.ItemIndex <> -1) and (cbTipoDejeto.ItemIndex <> -1)
     and (edtQrn.Text <> '') then
     begin
          materiaSeca();
          consentracaoNutriente();
          qrns := edtQrn.text;
          qrn := StrToFloat(qrns);
          if (dejeto <> 8) and (dejeto <> 9) then
          begin
               saida2 := qrn/((ms/100)*c*(ie/100));
               lbSaida3.caption := 'ton/ha';
          end
          else
          begin
               saida2 := qrn/(c*(ie/100));
               lbSaida3.caption := 'm³/ha';
          end;
          saida2 := Round(saida2);
          saida2s := FloatToStr(saida2);
          lbSaida2.Caption := saida2s;
     end
     else
     begin
          ShowMessage('Complete os dados!');
     end;
end;

procedure TForm1.materiaSeca();
begin
     case (dejeto) of
   0, 1, 2, 3:
     begin
          ms := 75;
     end;
   4:
     begin
          ms := 72;
     end;
   5:
     begin
          ms := 40;
     end;
   6:
     begin
          ms := 25;
     end;
   7:
     begin
          ms := 20;
     end;
   8:
     begin
          ms := 50;
     end;
   9:
     begin
          ms := 5;
     end;
   10, 11:
     begin
          ms := 70;
     end;
   12:
     begin
          ms := 3;
     end;
   13:
     begin
          ms := 4;
     end;
   end;
end;

procedure TForm1.consentracaoNutriente();
begin
  case (dejeto) of
   0:
     begin
          n := 3.2;
          p := 3.5;
          k := 2.5;
     end;
   1:
     begin
          n := 3.5;
          p := 3.8;
          k := 3.0;
     end;
   2:
     begin
          n := 3.8;
          p := 4.0;
          k := 3.5;
     end;
   3:
     begin
          n := 5.0;
          p := 4.0;
          k := 4.0;
     end;
   4:
     begin
          n := 1.6;
          p := 4.9;
          k := 1.9;
     end;
   5:
     begin
          n := 1.5;
          p := 2.6;
          k := 1.8;
     end;
   6:
     begin
          n := 2.1;
          p := 2.8;
          k := 2.9;
     end;
   7:
     begin
          n := 1.5;
          p := 1.4;
          k := 1.5;
     end;
   8:
     begin
          n := 2.8;
          p := 2.4;
          k := 1.5;
     end;
   9:
     begin
          n := 1.4;
          p := 0.8;
          k := 1.4;
     end;
   end;

   case (tipoNutr) of
          0:
           c := n;
          1:
           c := p;
          2:
           c := k;
   end;

   case (dejeto) of
   0, 1, 2, 9:
     begin
          mn := 50;
          mp := 80;
          mk := 100;
     end;
   3, 4:
     begin
          mn := 50;
          mp := 70;
          mk := 100;
     end;
   5:
     begin
          mn := 20;
          mp := 70;
          mk := 100;
     end;
   6:
     begin
          mn := 60;
          mp := 80;
          mk := 100;
     end;
   7:
     begin
          mn := 30;
          mp := 80;
          mk := 100;
     end;
   8:
     begin
          mn := 80;
          mp := 90;
          mk := 100;
     end;
   end;

   case (tipoNutr) of
   0:
     begin
          ie := mn;
     end;
   1:
     begin
          ie := mp;
     end;
   2:
     begin
          ie := mk;
     end;
   end;
end;

end.

