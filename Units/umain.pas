unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TDejetos }

  TDejetos = class(TForm)
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
    procedure edtQrnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtQrnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure materiaSeca();
    procedure consentracaoNutriente();
    procedure calculo();
    procedure verificaVirgula();
  private
         var tipoNutr, dejeto, v1, v2, leng: integer;
         var saida2, qrn, ms, c, ie, n, p, k, mn, mp, mk : real;
         var qrns, saida2s, stpt, stre, st1, st2, st3, st4, st5, st6, stv : string;
  public

  end;

var
  Dejetos: TDejetos;

implementation

{$R *.lfm}

{ TDejetos }

procedure TDejetos.cbTipoNutrChange(Sender: TObject);
begin
  tipoNutr := cbTipoNutr.ItemIndex;
end;

procedure TDejetos.cbTipoDejetoChange(Sender: TObject);
begin
  dejeto := cbTipoDejeto.ItemIndex;
end;

procedure TDejetos.btnOkClick(Sender: TObject);
begin
     verificaVirgula();
     calculo();
end;

procedure TDejetos.edtQrnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if (Key = 13) then
     begin
          verificaVirgula();
          calculo();
     end;

end;

procedure TDejetos.edtQrnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      stpt := edtQrn.Text;
      v1 := length(stpt);
      v2 := v1 - 1;
      if (v2 <> 0) then
      begin
        Delete(stpt, 1, v2);
      end;
      if (stpt = '.') then
      begin
        stpt := ',';
      end;
      stre := edtQrn.Text;
      v1 := length(stre);
      Delete(stre, v1, 1);
      st1 := stre + stpt;
      st2 := stre + stpt;
      st3 := stre + stpt;
      st4 := stre + stpt;
      st5 := stre + stpt;
      st6 := stre + stpt;
      stv := stre + stpt;
      Delete(st1, 2, 5);
      Delete(st2, 3, 4);
      Delete(st2, 1, 1);
      Delete(st3, 4, 3);
      Delete(st3, 1, 2);
      Delete(st4, 5, 2);
      Delete(st4, 1, 3);
      Delete(st5, 6, 1);
      Delete(st5, 1, 4);
      Delete(st6, 1, 5);

      if
       // teclado principal
       (key = 48) or (key = 49) or (key = 50) or (key = 51)
       or (key = 52) or (key = 53) or (key = 54) or (key = 55)
       or (key = 56) or (key = 57) or (key = 188) or (key = 190)
       or (key = 13) or (key = 8)
       // teclas numericas a direita do teclado
       or (key = 96) or (key = 97) or (key = 98) or (key = 99)
       or (key = 100) or (key = 101) or (key = 102) or (key = 103)
       or (key = 104) or (key = 105) or (key = 110) then
       begin
        if (st1 = ',') and (st2 <> ',') and (st3 <> ',') and (st4 <> ',') and
          (st5 <> ',') and (st6 <> ',') then
        begin
          ShowMessage('Não iniciar com separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;

        if (st1 <> ',') and (st2 = ',') and (st3 = ',') and (st4 <> ',') and
          (st5 <> ',') and (st6 <> ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;
        if (st1 <> ',') and (st2 = ',') and (st3 <> ',') and (st4 = ',') and
          (st5 <> ',') and (st6 <> ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;
        if (st1 <> ',') and (st2 = ',') and (st3 <> ',') and (st4 <> ',') and
          (st5 = ',') and (st6 <> ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;
        if (st1 <> ',') and (st2 = ',') and (st3 <> ',') and (st4 <> ',') and
          (st5 <> ',') and (st6 = ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;

        if (st1 <> ',') and (st2 <> ',') and (st3 = ',') and (st4 = ',') and
          (st5 <> ',') and (st6 <> ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;
        if (st1 <> ',') and (st2 <> ',') and (st3 = ',') and (st4 <> ',') and
          (st5 = ',') and (st6 <> ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;
        if (st1 <> ',') and (st2 <> ',') and (st3 = ',') and (st4 <> ',') and
          (st5 <> ',') and (st6 = ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;

        if (st1 <> ',') and (st2 <> ',') and (st3 <> ',') and (st4 = ',') and
          (st5 = ',') and (st6 <> ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;

        if (st1 <> ',') and (st2 <> ',') and (st3 <> ',') and (st4 = ',') and
          (st5 <> ',') and (st6 = ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;

        if (st1 <> ',') and (st2 <> ',') and (st3 <> ',') and (st4 <> ',') and
          (st5 = ',') and (st6 = ',') then
        begin
          ShowMessage('Digite apenas um separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;

        if (st1 <> ',') and (st2 <> ',') and (st3 <> ',') and (st4 <> ',') and
          (st5 <> ',') and (st6 = ',') then
        begin
          ShowMessage('Não terminar com separador decimal');
          Delete(stv, v1, 1);
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
          exit;
        end;
        if (v1 <> 0) then
        begin
          edtQrn.Text := '';
          edtQrn.Text := (stv);
          edtQrn.SelStart := v1;
        end
        else
        begin
          edtQrn.Text := '';
        end;
     end
     else
     begin
        ShowMessage('Digite apenas números!');
        Delete(stv, v1, 1);
        edtQrn.Text := '';
        edtQrn.Text := (stv);
        edtQrn.SelStart := v1;
        exit;
     end;
end;

procedure TDejetos.materiaSeca();
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

procedure TDejetos.consentracaoNutriente();
begin
  case (dejeto) of
   0:
     begin
          n := 32;
          p := 35;
          k := 25;
     end;
   1:
     begin
          n := 35;
          p := 38;
          k := 30;
     end;
   2:
     begin
          n := 38;
          p := 40;
          k := 35;
     end;
   3:
     begin
          n := 50;
          p := 40;
          k := 40;
     end;
   4:
     begin
          n := 16;
          p := 49;
          k := 19;
     end;
   5:
     begin
          n := 15;
          p := 26;
          k := 18;
     end;
   6:
     begin
          n := 21;
          p := 28;
          k := 29;
     end;
   7:
     begin
          n := 15;
          p := 14;
          k := 15;
     end;
   8:
     begin
          n := 28;
          p := 24;
          k := 15;
     end;
   9:
     begin
          n := 14;
          p := 8;
          k := 14;
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

procedure TDejetos.calculo;
begin
    if (cbTipoNutr.ItemIndex <> -1) and (cbTipoDejeto.ItemIndex <> -1)
     and (edtQrn.Text <> '') then
     begin
          materiaSeca();
          consentracaoNutriente();
          qrns := edtQrn.Text;
          qrn := StrToFloat(qrns);
          if (dejeto <> 8) and (dejeto <> 9) then
          begin
               saida2 := qrn/((ms/100)*c*(ie/100));
               lbSaida3.caption := 'ton';
          end
          else
          begin
               saida2 := qrn/(c*(ie/100));
               lbSaida3.caption := 'm³';
          end;
          saida2s := FormatFloat('0.0', saida2);
          lbSaida2.Caption := saida2s;
     end
     else
     begin
          ShowMessage('Complete os dados!');
     end;
end;

procedure TDejetos.verificaVirgula;
begin
  if (v1 = 2) and (st2 = ',') then
    begin
      ShowMessage('Não terminar com separador decimal');
      Delete(stv, v1, 1);
      edtQrn.Text := '';
      edtQrn.Text := (stv);
      edtQrn.SelStart := v1;
      st2 := '';
      exit;
    end
    else
    if (v1 = 3) and (st3 = ',') then
    begin
      ShowMessage('Não terminar com separador decimal');
      Delete(stv, v1, 1);
      edtQrn.Text := '';
      edtQrn.Text := (stv);
      edtQrn.SelStart := v1;
      st3 := '';
      exit;
    end
    else
    if (v1 = 4) and (st4 = ',') then
    begin
      ShowMessage('Não terminar com separador decimal');
      Delete(stv, v1, 1);
      edtQrn.Text := '';
      edtQrn.Text := (stv);
      edtQrn.SelStart := v1;
      st4 := '';
      exit;
    end
    else
    if (v1 = 5) and (st5 = ',') then
    begin
      ShowMessage('Não terminar com separador decimal');
      Delete(stv, v1, 1);
      edtQrn.Text := '';
      edtQrn.Text := (stv);
      edtQrn.SelStart := v1;
      st5 := '';
      exit;
    end;
end;

end.

