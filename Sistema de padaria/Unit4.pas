unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, StdCtrls, Mask, DBCtrls, ExtCtrls, ADODB,
  Menus;

type
  Tcad = class(TForm)
    GroupBox1: TGroupBox;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOQuery1id_usu: TAutoIncField;
    ADOQuery1login_usu: TStringField;
    ADOQuery1senha_usu: TStringField;
    admin: TRadioGroup;
    Button1: TButton;
    ADOQuery1nome_usu: TStringField;
    Label1: TLabel;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBGrid1: TDBGrid;
    Button2: TButton;
    ADOQuery1tel_usu: TLargeintField;
    ADOQuery1tipo_usu: TStringField;
    DBEdit1: TDBEdit;
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Consulta1: TMenuItem;
    GroupBox2: TGroupBox;
    pid: TRadioButton;
    pnome: TRadioButton;
    plogin: TRadioButton;
    cid: TEdit;
    cnome: TEdit;
    clogin: TEdit;
    psq: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Consulta1Click(Sender: TObject);
    procedure Cadastro1Click(Sender: TObject);
    procedure pidClick(Sender: TObject);
    procedure pnomeClick(Sender: TObject);
    procedure ploginClick(Sender: TObject);
    procedure psqClick(Sender: TObject);
  private
    sure: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cad: Tcad;

implementation

{$R *.dfm}

procedure Tcad.Button1Click(Sender: TObject);
begin
  if (admin.ItemIndex = -1) then
    begin
      ShowMessage('Por favor selecione o tipo de usu�rio');
    end
  else
    begin
      if (admin.ItemIndex = 0) then
        begin
          ADOQuery1tipo_usu.AsString := 'ADMN';
          ADOQuery1.Insert;
        end
      else
        begin
          ADOQuery1tipo_usu.AsString := 'VEND';
          ADOQuery1.Insert;
        end;
    end;
end;

procedure Tcad.Button2Click(Sender: TObject);
begin
  if (sure) then
    begin
      ADOQuery1.Delete;
      sure := False;
    end;
  ShowMessage('Clique novamente para remover o usu�rio '+ADOQuery1nome_usu.AsString);
  sure := True;
end;

procedure Tcad.DBGrid1CellClick(Column: TColumn);
begin
  sure := False;
end;

procedure Tcad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cad := NIL;
end;

procedure Tcad.Consulta1Click(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Text := 'SELECT * FROM padaria.tb_usuario ORDER BY id_usu';
  ADOQuery1.Open;
  GroupBox1.Hide;
  GroupBox2.Show;
  admin.Hide;
end;

procedure Tcad.Cadastro1Click(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Text := 'SELECT * FROM padaria.tb_usuario ORDER BY id_usu';
  ADOQuery1.Open;
  GroupBox1.Show;
  GroupBox2.Hide;
  admin.Show;
end;

procedure Tcad.pidClick(Sender: TObject);
begin
  cnome.Text := '';
  cnome.Enabled := false;
  clogin.Text := '';
  clogin.Enabled := false;
  cid.Enabled := true;
  psq.Enabled := true;
end;

procedure Tcad.pnomeClick(Sender: TObject);
begin
  cid.Text := '';
  cid.Enabled := false;
  clogin.Text := '';
  clogin.Enabled := false;
  cnome.Enabled := true;
  psq.Enabled := true;
end;

procedure Tcad.ploginClick(Sender: TObject);
begin
  cid.Text := '';
  cid.Enabled := false;
  cnome.Text := '';
  cnome.Enabled := false;
  clogin.Enabled := true;
  psq.Enabled := true;
end;

procedure Tcad.psqClick(Sender: TObject);
begin
  if (pid.Checked) then
    begin
      with ADOQuery1 do
        begin
          Close;
          SQL.Text := 'SELECT * FROM padaria.tb_usuario WHERE id_usu = '+QuotedStr(cid.Text)+' ORDER BY id_usu';
          Open;
        end;
    end
  else if (pnome.Checked) then
    begin
      with ADOQuery1 do
        begin
          Close;
          SQL.Text := 'SELECT * FROM padaria.tb_usuario WHERE lower(nome_usu) = '+QuotedStr(LowerCase(cnome.Text))+' ORDER BY id_usu';
          Open;
        end;
    end
  else
    begin
      with ADOQuery1 do
        begin
          Close;
          SQL.Text := 'SELECT * FROM padaria.tb_usuario WHERE lower(login_usu) = '+QuotedStr(LowerCase(clogin.Text))+' ORDER BY id_usu';
          Open;
        end;
    end;
end;

end.
