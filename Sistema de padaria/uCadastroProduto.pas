unit uCadastroProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Menus, Grids, DBGrids, Mask, DBCtrls;

type
  Tprod = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    Label2: TLabel;
    btnCancelar: TButton;
    btnDeletar: TButton;
    btnInserir: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    edtNome: TDBEdit;
    edtPreco: TDBEdit;
    btnEditar: TButton;
    ADOQuery1id_prod: TAutoIncField;
    ADOQuery1preco_prod: TBCDField;
    ADOQuery1nome_prod: TStringField;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    sure: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  prod: Tprod;

implementation

{$R *.dfm}

procedure Tprod.btnCancelarClick(Sender: TObject);
begin
  ADOQuery1.Cancel;
end;

procedure Tprod.btnDeletarClick(Sender: TObject);
begin
  if (sure) then
    begin
      ADOQuery1.Delete;
      sure := False;
      ADOQuery1.Close;
      ADOQuery1.SQL.Text := 'select * from padaria.tb_produto order by id_prod';
      ADOQuery1.Open;
    end;
  ShowMessage('Clique novamente para remover o produto '+ADOQuery1nome_prod.AsString);
  sure := True;
end;

procedure Tprod.FormShow(Sender: TObject);
begin
 // ADOQuery1.Open;
end;

procedure Tprod.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ADOQuery1.Close;
end;

procedure Tprod.btnInserirClick(Sender: TObject);
begin
  ADOQuery1.Append;
  ADOQuery1.Close;
  ADOQuery1.SQL.Text := 'select * from padaria.tb_produto order by id_prod';
  ADOQuery1.Open;
end;

procedure Tprod.btnEditarClick(Sender: TObject);
begin
  ADOQuery1.Edit;
  ADOQuery1.Close;
  ADOQuery1.SQL.Text := 'select * from padaria.tb_produto order by id_prod';
  ADOQuery1.Open;
end;

procedure Tprod.DBGrid1CellClick(Column: TColumn);
begin
  sure := false;
end;

end.
