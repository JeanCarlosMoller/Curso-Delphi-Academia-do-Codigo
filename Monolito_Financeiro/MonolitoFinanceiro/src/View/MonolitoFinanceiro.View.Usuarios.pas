unit MonolitoFinanceiro.View.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MonolitoFinanceiro.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.WinXCtrls, Vcl.Menus;

type
  TfrmUsuarios = class(TfrmCadastroPadrao)
    edtNome: TEdit;
    edtLogin: TEdit;
    ToggleStatus: TToggleSwitch;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    PopupMenu: TPopupMenu;
    mnuRedefinirSenha: TMenuItem;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure mnuRedefinirSenhaClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  protected
    procedure Pesquisar; override;
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

uses
  MonolitoFinanceiro.Model.Usuarios,
  MonolitoFinanceiro.Utilitarios,
  System.SysUtils,
  BCrypt, Datasnap.DBClient;

{$R *.dfm}

procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin
  inherited;

  edtNome.Text := dmUsuarios.cdsUsuariosnome.AsString;
  edtLogin.Text := dmUsuarios.cdsUsuarioslogin.AsString;

  ToggleStatus.State := tssOn;
  if dmUsuarios.cdsUsuariosstatus.AsString = 'B' then
    ToggleStatus.State := tssOff;
end;

procedure TfrmUsuarios.btnSalvarClick(Sender: TObject);
var
  LStatus: String;
begin
  if Trim(edtNome.Text) = '' then
  begin
    edtNome.SetFocus;
    Application.MessageBox('O campo nome não pode ser vazio.', 'Atenção',
      MB_OK + MB_ICONWARNING);
    Label2.Caption := 'Nome *';
    Label2.font.Color := clRed;
    abort;
  end;

  if Trim(edtLogin.Text) = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('O campo login não pode ser vazio.', 'Atenção',
      MB_OK + MB_ICONWARNING);
    Label3.Caption := 'Login *';
    Label3.font.Color := clRed;
    abort;
  end;

  if dmUsuarios.TemLoginCadastrado(Trim(edtLogin.Text),
    dmUsuarios.cdsUsuarios.FieldByName('ID').AsString) then
  begin
    edtLogin.SetFocus;
    Application.MessageBox
      (PWideChar(Format('O login %s já se encontra cadastrado.',
      [edtLogin.Text])), 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  LStatus := 'A';

  if ToggleStatus.State = tssOff then
    LStatus := 'B';

  if dmUsuarios.cdsUsuarios.State in [dsInsert] then
  begin
    dmUsuarios.cdsUsuariosid.AsString := TUtilitarios.GetID;
    dmUsuarios.cdsUsuariosdata_cadastro.AsDateTime := now;
    dmUsuarios.cdsusuariossenha_temporaria.AsString := 'S';
    dmUsuarios.cdsUsuariossenha.AsString :=
      TBCrypt.GenerateHash(dmUsuarios.TEMP_PASSWORD);
  end;
  dmUsuarios.cdsUsuariosnome.AsString := Trim(edtNome.Text);
  dmUsuarios.cdsUsuarioslogin.AsString := Trim(edtLogin.Text);
  dmUsuarios.cdsUsuariosstatus.AsString := LStatus;

  inherited;
end;

procedure TfrmUsuarios.mnuRedefinirSenhaClick(Sender: TObject);
begin
  inherited;
  if not DataSource1.DataSet.IsEmpty then
    dmUsuarios.LimparSenha(DataSource1.DataSet.FieldByName('ID').AsString);
  Application.MessageBox
    (PWideChar(Format('Foi definida a senha padrão para o usuário "%s".',
    [DataSource1.DataSet.FieldByName('NOME').AsString])), 'Sucesso',
    MB_OK + MB_ICONEXCLAMATION);
end;

procedure TfrmUsuarios.Pesquisar;
var
  FiltroPesquisa: String;
begin
  FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisar.Text, DBGrid1);
  dmUsuarios.cdsUsuarios.Close;
  dmUsuarios.cdsUsuarios.CommandText := 'Select * from Usuarios' +
    FiltroPesquisa;
  dmUsuarios.cdsUsuarios.Open;
  inherited;
end;

end.
