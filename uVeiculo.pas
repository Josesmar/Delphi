unit uVeiculo;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics,  Controls, Forms,
     StdCtrls, Buttons, CheckLst, ExtCtrls, VarUtils, TypInfo,Generics.Collections;

Type

  TTipoEnum  = (Carro, Moto, Caminhão);    
  TVeiculo   = class (TObject)

  private
    Fmodelo : string;
    Ftipo   : TTipoEnum;
    Fcambio : String;
    Fcores  : String;

    function getCambio: string;
    function getCores : string;
    function getModelo: string;
    function getTipo  : TTipoEnum;
    function getDados : String;

    procedure setCambio(const Value: String);
    procedure setModelo(const Value: String);
    procedure setTipo(const Value: TTipoEnum);
    procedure setCores(const Value: String);

  protected

  public
    property modelo: String read getModelo write setModelo;
    property tipo: TTipoEnum read getTipo write setTipo;
    property cambio: String read getCambio write setCambio;
    property cores: String read getCores write setCores; 
    property tipoDados: string read getDados;
    
    constructor creat(Atipo: TTipoEnum; Amodelo: String; Acambio: String; Acores: String);
    destructor destroy; override; 
    
    function acelerar(): String;
    function frear(): String;
    procedure estacionar (memo: TMemo); overload;
    
    function dadosMemo: string;  
        
    class function listaVeiculos(lista: TObjectList<TVeiculo>): String;

  end;

implementation

uses frmPrincipal;

{ TVeiculo }

function TVeiculo.acelerar: String;
begin
  Result := 'Acelerando veículo...';
end;

constructor TVeiculo.creat(Atipo: TTipoEnum; Amodelo: String; Acambio, Acores: String);
begin
  Fmodelo := Amodelo;
  Ftipo   := Atipo;
  Fcambio := Acambio;
  Fcores  := Acores; 
  if Fmodelo = '' then
  begin
    raise Exception.Create('Mode não pode ser vazio');
  end;
  if Fcambio = '' then
  begin
     raise Exception.Create('Cambio não pode ser vazio');
  end;
end;  

destructor TVeiculo.destroy;
begin

  inherited;
end;

procedure TVeiculo.estacionar(memo: TMemo);
var
  estacionar: String;
begin
  estacionar := 'Estacionando veículo...';
  memo.Lines.Add(estacionar);  
end;

function TVeiculo.frear: String;
begin
  Result := 'Freando veículo...';
end;

function TVeiculo.getCambio: string;
begin
  Result := FCambio;
end;

function TVeiculo.getCores: string;
begin
  Result := FCores;
end;

function TVeiculo.getDados: String;
begin
  Result := GetEnumName(TypeInfo(TTipoEnum), integer(tipo));
end;

function TVeiculo.getModelo: string;
begin
  Result := FModelo;
end;

function TVeiculo.getTipo: TTipoEnum;
begin
  Result := FTipo;
end;

class function TVeiculo.listaVeiculos(lista: TObjectList<TVeiculo>): String;
var
  i: integer;
  texto: string;
begin
  for i := 0 to Lista.Count - 1 do
    begin
      texto :=  texto + 'Modelo: ' +lista.Items[i].getModelo + #13#10 +
                      'Tipo:   ' +lista.Items[i].getDados  + #13#10 +
                      'Câmbio: ' +lista.Items[i].getCambio + #13#10 +
                      'Cores:  ' +lista.Items[i].getCores  + #13#10 + 
                      '        ' +                           #13#10;
    end;
      result := texto;  
end;

procedure TVeiculo.setCambio(const Value: String);
begin
  FCambio := Value;
end;

procedure TVeiculo.setCores(const Value: String);
begin
  FCores := Value;
end;

procedure TVeiculo.setModelo(const Value: String);
begin
  FModelo:= Value;
end;

procedure TVeiculo.setTipo(const Value: TTipoEnum);
begin
  FTipo := Value;
end;

function TVeiculo.dadosMemo: string;
begin
  result := 'Modelo: '  + Fmodelo  + #13#10 +
            'Tipo:   '  + getDados + #13#10 +   
            'Câmbio: '  + Fcambio  + #13#10 +
            'Cores:  '  + Fcores;          
end;
end.
