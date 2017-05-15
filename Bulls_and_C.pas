unit Bulls_and_C;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    E_Saisie: TEdit;
    E_Cows: TEdit;
    L_Saisie: TLabel;
    E_Bulls: TEdit;
    L_Cows: TLabel;
    L_Bulls: TLabel;
    B_verif: TButton;
    B_reset: TButton;
    B_quitter: TButton;
    L_Essais: TLabel;
    E_Essai: TEdit;
    E_Résultats: TEdit;
    M_liste: TMemo;
    E_rechercher: TEdit;
    L_lmot: TLabel;
    E_Lmot: TEdit;
    L_lmot2: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure B_verifClick(Sender: TObject);
    procedure B_resetClick(Sender: TObject);
    procedure B_quitterClick(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}







procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
begin
    M_liste.Lines.LoadFromFile('../../B_C_mot.txt');
    repeat
      begin
          randomize;
          i:=random(M_liste.Lines.Count);
          E_rechercher.Text:=M_liste.Lines[i];
      end;
    until E_rechercher.Text<>'';

    E_Bulls.Text:='0';
    E_Cows.Text:='0';
    E_Essai.Text:=inttostr(length(E_rechercher.Text));
    E_Lmot.Text:=inttostr(length(E_rechercher.Text));
end;

function test_longueur(E_saisie:TEdit;E_rechercher:TEdit):integer;
begin
   if length(E_saisie.text)=length(E_rechercher.text) then
      test_longueur:=0
   else
    if length(E_saisie.text)<length(E_rechercher.text) then
      test_longueur:=1
    else
      if length(E_saisie.text)>length(E_rechercher.text) then
      test_longueur:=2;
end;


procedure test_B(E_saisie:TEdit;E_rechercher:TEdit;E_bulls:TEdit);
var
  i,cpt_B:integer;
begin
  cpt_B:=strtoint(E_Bulls.Text);
  for i := 1 to length(E_saisie.Text) do
  begin
    if E_saisie.Text[i]=E_rechercher.Text[i] then
    begin
      cpt_B:=cpt_B+1;
    end;
  end;
  E_Bulls.Text:=inttostr(cpt_B);
end;

procedure test_C(E_saisie:TEdit;E_rechercher:TEdit;E_Cows:TEdit);
var
  i,cpt_c:integer;
  j: Integer;
begin
  cpt_c:=strtoint(E_Cows.Text);
  for i := 1 to length(E_saisie.Text) do
  begin
    for j := 1 to length(E_saisie.Text) do
    if i<>j then
    begin
      if E_saisie.Text[i]=E_rechercher.Text[j] then
      begin
        cpt_c:=cpt_c+1;
      end;
    end;
  end;
  E_Cows.Text:=inttostr(cpt_c);
end;

function test_saisie(E_saisie:TEdit):integer;
var
  i,j,cpt:integer;
  l_test:string;
begin
  test_saisie:=0;
  for I := 1 to length(E_saisie.Text) do
  begin
      cpt:=0;
      if(E_saisie.Text[i]>chr(96))and(E_saisie.Text[i]<chr(123)) then
      begin
        L_test:= E_saisie.Text[i];
        for j := 1 to length(E_saisie.Text) do
         begin
            if l_test=E_saisie.Text[j] then
            begin
              cpt:=cpt+1;
            end;
          end;

       if cpt=1 then
        test_saisie:=1;
      end;

  end;


end;

procedure TForm1.B_quitterClick(Sender: TObject);
var
  myYes,myNo:TmsgDlgBtn ;
  myButs:TMsgDlgButtons;

begin
  myYes:=mbYes;
  myNo:=mbNo;
  myButs:= [myYes, myNo];
  if messageDLG('Voulez-vous Quitter ?',mtConfirmation,myButs,0)= mrYes then
    begin
       close;
    end;
end;

procedure TForm1.B_resetClick(Sender: TObject);
var
  i:integer;
begin
  repeat
      begin
          randomize;
          i:=random(M_liste.Lines.Count);
          E_rechercher.Text:=M_liste.Lines[i];
      end;
    until E_rechercher.Text<>'';

    E_Saisie.Text:='';
    E_Bulls.Text:='0';
    E_Cows.Text:='0';
    E_Essai.Text:=inttostr(length(E_rechercher.Text));
    E_Lmot.Text:=inttostr(length(E_rechercher.Text));
    B_verif.Enabled:=true;
    E_Résultats.Visible:=false;
end;

procedure TForm1.B_verifClick(Sender: TObject);
begin
  if test_longueur(E_saisie,E_rechercher)=0 then
  begin
    if test_saisie(E_saisie)=0 then
    begin
      E_résultats.Text:=' Mauvaise saisie ';
      E_Résultats.Visible:=true;
    end
    else
    begin
      E_Bulls.Text:='0';
      E_Cows.Text:='0';
      E_Résultats.Visible:=false;
      test_B(E_saisie,E_rechercher,E_bulls);
      test_C(E_saisie,E_rechercher,E_cows);
      E_essai.Text:=inttostr(strtoint(E_essai.Text)-1);
      if E_essai.Text='0' then
      begin
        B_verif.Enabled:=false;
        E_Résultats.Text:='PERDU';
        E_Résultats.Visible:=true;
      end;

      if E_Bulls.Text=E_Lmot.Text then
      begin
        B_verif.Enabled:=false;
        E_Résultats.Text:='GAGNER';
        E_Résultats.Visible:=true;
      end;
    end;
  end;
  if test_longueur(E_saisie,E_rechercher)=1 then
  begin
    E_Résultats.text:='Le mot est trop court';
    E_Résultats.Visible:=true;
  end;
  if test_longueur(E_saisie,E_rechercher)=2 then
  begin
    E_Résultats.text:='Le mot est trop long';
    E_Résultats.Visible:=true;
  end;
end;


end.
