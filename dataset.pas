
{**********************************************************************************}
{                                                                                  }
{                                 XML Data Binding                                 }
{                                                                                  }
{         Generated on: 28/11/2022 17:51:02                                        }
{       Generated from: C:\Users\MSII\Downloads\uchoa-et-al-2014\X-n1001-k43.xml   }
{   Settings stored in: C:\Users\MSII\Downloads\uchoa-et-al-2014\X-n1001-k43.xdb   }
{                                                                                  }
{**********************************************************************************}

unit dataset;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLInstanceType = interface;
  IXMLInfoType = interface;
  IXMLNetworkType = interface;
  IXMLNodesType = interface;
  IXMLNodeType = interface;
  IXMLFleetType = interface;
  IXMLVehicle_profileType = interface;
  IXMLRequestsType = interface;
  IXMLRequestType = interface;

{ IXMLInstanceType }

  IXMLInstanceType = interface(IXMLNode)
    ['{97D9ABA9-5E8B-4F1E-B986-A21836A6302D}']
    { Property Accessors }
    function Get_Info: IXMLInfoType;
    function Get_Network: IXMLNetworkType;
    function Get_Fleet: IXMLFleetType;
    function Get_Requests: IXMLRequestsType;
    { Methods & Properties }
    property Info: IXMLInfoType read Get_Info;
    property Network: IXMLNetworkType read Get_Network;
    property Fleet: IXMLFleetType read Get_Fleet;
    property Requests: IXMLRequestsType read Get_Requests;
  end;

{ IXMLInfoType }

  IXMLInfoType = interface(IXMLNode)
    ['{E9783FD8-7125-4BED-8894-A264D0CB1B65}']
    { Property Accessors }
    function Get_Dataset: Extended;
    function Get_Name: Extended;
    procedure Set_Dataset(Value: Extended);
    procedure Set_Name(Value: Extended);
    { Methods & Properties }
    property Dataset: Extended read Get_Dataset write Set_Dataset;
    property Name: Extended read Get_Name write Set_Name;
  end;

{ IXMLNetworkType }

  IXMLNetworkType = interface(IXMLNode)
    ['{FCCE0B23-7956-4FEC-8F49-8954A7246F46}']
    { Property Accessors }
    function Get_Nodes: IXMLNodesType;
    function Get_Euclidean: Extended;
    function Get_Decimals: Integer;
    procedure Set_Euclidean(Value: Extended);
    procedure Set_Decimals(Value: Integer);
    { Methods & Properties }
    property Nodes: IXMLNodesType read Get_Nodes;
    property Euclidean: Extended read Get_Euclidean write Set_Euclidean;
    property Decimals: Integer read Get_Decimals write Set_Decimals;
  end;

{ IXMLNodesType }

  IXMLNodesType = interface(IXMLNodeCollection)
    ['{EDF6FFB9-C11A-4F18-A4A8-82A4D1C0164F}']
    { Property Accessors }
    function Get_Node(Index: Integer): IXMLNodeType;
    { Methods & Properties }
    function Add: IXMLNodeType;
    function Insert(const Index: Integer): IXMLNodeType;
    property Node[Index: Integer]: IXMLNodeType read Get_Node; default;
  end;

{ IXMLNodeType }

  IXMLNodeType = interface(IXMLNode)
    ['{00009A23-5A5D-487E-8870-3DCFDA4B6830}']
    { Property Accessors }
    function Get_Id: Integer;
    function Get_Type_: Integer;
    function Get_Cx: Integer;
    function Get_Cy: Integer;
    procedure Set_Id(Value: Integer);
    procedure Set_Type_(Value: Integer);
    procedure Set_Cx(Value: Integer);
    procedure Set_Cy(Value: Integer);
    { Methods & Properties }
    property Id: Integer read Get_Id write Set_Id;
    property Type_: Integer read Get_Type_ write Set_Type_;
    property Cx: Integer read Get_Cx write Set_Cx;
    property Cy: Integer read Get_Cy write Set_Cy;
  end;

{ IXMLFleetType }

  IXMLFleetType = interface(IXMLNode)
    ['{5A3D0D3D-AF30-4EDE-B89B-0D61285BA84D}']
    { Property Accessors }
    function Get_Vehicle_profile: IXMLVehicle_profileType;
    { Methods & Properties }
    property Vehicle_profile: IXMLVehicle_profileType read Get_Vehicle_profile;
  end;

{ IXMLVehicle_profileType }

  IXMLVehicle_profileType = interface(IXMLNode)
    ['{0EA1E5F4-4B69-472D-9900-973AA9AAA253}']
    { Property Accessors }
    function Get_Type_: Integer;
    function Get_Departure_node: Integer;
    function Get_Arrival_node: Integer;
    function Get_Capacity: Integer;
    procedure Set_Type_(Value: Integer);
    procedure Set_Departure_node(Value: Integer);
    procedure Set_Arrival_node(Value: Integer);
    procedure Set_Capacity(Value: Integer);
    { Methods & Properties }
    property Type_: Integer read Get_Type_ write Set_Type_;
    property Departure_node: Integer read Get_Departure_node write Set_Departure_node;
    property Arrival_node: Integer read Get_Arrival_node write Set_Arrival_node;
    property Capacity: Integer read Get_Capacity write Set_Capacity;
  end;

{ IXMLRequestsType }

  IXMLRequestsType = interface(IXMLNodeCollection)
    ['{02F45E5C-4ED4-4128-89EF-0970B01F3616}']
    { Property Accessors }
    function Get_Request(Index: Integer): IXMLRequestType;
    { Methods & Properties }
    function Add: IXMLRequestType;
    function Insert(const Index: Integer): IXMLRequestType;
    property Request[Index: Integer]: IXMLRequestType read Get_Request; default;
  end;

{ IXMLRequestType }

  IXMLRequestType = interface(IXMLNode)
    ['{3E3A8134-BC2D-4AB2-B161-536C9DC919A9}']
    { Property Accessors }
    function Get_Id: Integer;
    function Get_Node: Integer;
    function Get_Quantity: Integer;
    procedure Set_Id(Value: Integer);
    procedure Set_Node(Value: Integer);
    procedure Set_Quantity(Value: Integer);
    { Methods & Properties }
    property Id: Integer read Get_Id write Set_Id;
    property Node: Integer read Get_Node write Set_Node;
    property Quantity: Integer read Get_Quantity write Set_Quantity;
  end;

{ Forward Decls }

  TXMLInstanceType = class;
  TXMLInfoType = class;
  TXMLNetworkType = class;
  TXMLNodesType = class;
  TXMLNodeType = class;
  TXMLFleetType = class;
  TXMLVehicle_profileType = class;
  TXMLRequestsType = class;
  TXMLRequestType = class;

{ TXMLInstanceType }

  TXMLInstanceType = class(TXMLNode, IXMLInstanceType)
  protected
    { IXMLInstanceType }
    function Get_Info: IXMLInfoType;
    function Get_Network: IXMLNetworkType;
    function Get_Fleet: IXMLFleetType;
    function Get_Requests: IXMLRequestsType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInfoType }

  TXMLInfoType = class(TXMLNode, IXMLInfoType)
  protected
    { IXMLInfoType }
    function Get_Dataset: Extended;
    function Get_Name: Extended;
    procedure Set_Dataset(Value: Extended);
    procedure Set_Name(Value: Extended);
  end;

{ TXMLNetworkType }

  TXMLNetworkType = class(TXMLNode, IXMLNetworkType)
  protected
    { IXMLNetworkType }
    function Get_Nodes: IXMLNodesType;
    function Get_Euclidean: Extended;
    function Get_Decimals: Integer;
    procedure Set_Euclidean(Value: Extended);
    procedure Set_Decimals(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNodesType }

  TXMLNodesType = class(TXMLNodeCollection, IXMLNodesType)
  protected
    { IXMLNodesType }
    function Get_Node(Index: Integer): IXMLNodeType;
    function Add: IXMLNodeType;
    function Insert(const Index: Integer): IXMLNodeType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNodeType }

  TXMLNodeType = class(TXMLNode, IXMLNodeType)
  protected
    { IXMLNodeType }
    function Get_Id: Integer;
    function Get_Type_: Integer;
    function Get_Cx: Integer;
    function Get_Cy: Integer;
    procedure Set_Id(Value: Integer);
    procedure Set_Type_(Value: Integer);
    procedure Set_Cx(Value: Integer);
    procedure Set_Cy(Value: Integer);
  end;

{ TXMLFleetType }

  TXMLFleetType = class(TXMLNode, IXMLFleetType)
  protected
    { IXMLFleetType }
    function Get_Vehicle_profile: IXMLVehicle_profileType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLVehicle_profileType }

  TXMLVehicle_profileType = class(TXMLNode, IXMLVehicle_profileType)
  protected
    { IXMLVehicle_profileType }
    function Get_Type_: Integer;
    function Get_Departure_node: Integer;
    function Get_Arrival_node: Integer;
    function Get_Capacity: Integer;
    procedure Set_Type_(Value: Integer);
    procedure Set_Departure_node(Value: Integer);
    procedure Set_Arrival_node(Value: Integer);
    procedure Set_Capacity(Value: Integer);
  end;

{ TXMLRequestsType }

  TXMLRequestsType = class(TXMLNodeCollection, IXMLRequestsType)
  protected
    { IXMLRequestsType }
    function Get_Request(Index: Integer): IXMLRequestType;
    function Add: IXMLRequestType;
    function Insert(const Index: Integer): IXMLRequestType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRequestType }

  TXMLRequestType = class(TXMLNode, IXMLRequestType)
  protected
    { IXMLRequestType }
    function Get_Id: Integer;
    function Get_Node: Integer;
    function Get_Quantity: Integer;
    procedure Set_Id(Value: Integer);
    procedure Set_Node(Value: Integer);
    procedure Set_Quantity(Value: Integer);
  end;

{ Global Functions }

function Getinstance(Doc: IXMLDocument): IXMLInstanceType;
function Loadinstance(const FileName: WideString): IXMLInstanceType;
function Newinstance: IXMLInstanceType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getinstance(Doc: IXMLDocument): IXMLInstanceType;
begin
  Result := Doc.GetDocBinding('instance', TXMLInstanceType, TargetNamespace) as IXMLInstanceType;
end;

function Loadinstance(const FileName: WideString): IXMLInstanceType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('instance', TXMLInstanceType, TargetNamespace) as IXMLInstanceType;
end;

function Newinstance: IXMLInstanceType;
begin
  Result := NewXMLDocument.GetDocBinding('instance', TXMLInstanceType, TargetNamespace) as IXMLInstanceType;
end;

{ TXMLInstanceType }

procedure TXMLInstanceType.AfterConstruction;
begin
  RegisterChildNode('info', TXMLInfoType);
  RegisterChildNode('network', TXMLNetworkType);
  RegisterChildNode('fleet', TXMLFleetType);
  RegisterChildNode('requests', TXMLRequestsType);
  inherited;
end;

function TXMLInstanceType.Get_Info: IXMLInfoType;
begin
  Result := ChildNodes['info'] as IXMLInfoType;
end;

function TXMLInstanceType.Get_Network: IXMLNetworkType;
begin
  Result := ChildNodes['network'] as IXMLNetworkType;
end;

function TXMLInstanceType.Get_Fleet: IXMLFleetType;
begin
  Result := ChildNodes['fleet'] as IXMLFleetType;
end;

function TXMLInstanceType.Get_Requests: IXMLRequestsType;
begin
  Result := ChildNodes['requests'] as IXMLRequestsType;
end;

{ TXMLInfoType }

function TXMLInfoType.Get_Dataset: Extended;
begin
  Result := ChildNodes['dataset'].NodeValue;
end;

procedure TXMLInfoType.Set_Dataset(Value: Extended);
begin
  ChildNodes['dataset'].NodeValue := Value;
end;

function TXMLInfoType.Get_Name: Extended;
begin
  Result := ChildNodes['name'].NodeValue;
end;

procedure TXMLInfoType.Set_Name(Value: Extended);
begin
  ChildNodes['name'].NodeValue := Value;
end;

{ TXMLNetworkType }

procedure TXMLNetworkType.AfterConstruction;
begin
  RegisterChildNode('nodes', TXMLNodesType);
  inherited;
end;

function TXMLNetworkType.Get_Nodes: IXMLNodesType;
begin
  Result := ChildNodes['nodes'] as IXMLNodesType;
end;

function TXMLNetworkType.Get_Euclidean: Extended;
begin
  Result := ChildNodes['euclidean'].NodeValue;
end;

procedure TXMLNetworkType.Set_Euclidean(Value: Extended);
begin
  ChildNodes['euclidean'].NodeValue := Value;
end;

function TXMLNetworkType.Get_Decimals: Integer;
begin
  Result := ChildNodes['decimals'].NodeValue;
end;

procedure TXMLNetworkType.Set_Decimals(Value: Integer);
begin
  ChildNodes['decimals'].NodeValue := Value;
end;

{ TXMLNodesType }

procedure TXMLNodesType.AfterConstruction;
begin
  RegisterChildNode('node', TXMLNodeType);
  ItemTag := 'node';
  ItemInterface := IXMLNodeType;
  inherited;
end;

function TXMLNodesType.Get_Node(Index: Integer): IXMLNodeType;
begin
  Result := List[Index] as IXMLNodeType;
end;

function TXMLNodesType.Add: IXMLNodeType;
begin
  Result := AddItem(-1) as IXMLNodeType;
end;

function TXMLNodesType.Insert(const Index: Integer): IXMLNodeType;
begin
  Result := AddItem(Index) as IXMLNodeType;
end;

{ TXMLNodeType }

function TXMLNodeType.Get_Id: Integer;
begin
  Result := AttributeNodes['id'].NodeValue;
end;

procedure TXMLNodeType.Set_Id(Value: Integer);
begin
  SetAttribute('id', Value);
end;

function TXMLNodeType.Get_Type_: Integer;
begin
  Result := AttributeNodes['type'].NodeValue;
end;

procedure TXMLNodeType.Set_Type_(Value: Integer);
begin
  SetAttribute('type', Value);
end;

function TXMLNodeType.Get_Cx: Integer;
begin
  Result := ChildNodes['cx'].NodeValue;
end;

procedure TXMLNodeType.Set_Cx(Value: Integer);
begin
  ChildNodes['cx'].NodeValue := Value;
end;

function TXMLNodeType.Get_Cy: Integer;
begin
  Result := ChildNodes['cy'].NodeValue;
end;

procedure TXMLNodeType.Set_Cy(Value: Integer);
begin
  ChildNodes['cy'].NodeValue := Value;
end;

{ TXMLFleetType }

procedure TXMLFleetType.AfterConstruction;
begin
  RegisterChildNode('vehicle_profile', TXMLVehicle_profileType);
  inherited;
end;

function TXMLFleetType.Get_Vehicle_profile: IXMLVehicle_profileType;
begin
  Result := ChildNodes['vehicle_profile'] as IXMLVehicle_profileType;
end;

{ TXMLVehicle_profileType }

function TXMLVehicle_profileType.Get_Type_: Integer;
begin
  Result := AttributeNodes['type'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Type_(Value: Integer);
begin
  SetAttribute('type', Value);
end;

function TXMLVehicle_profileType.Get_Departure_node: Integer;
begin
  Result := ChildNodes['departure_node'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Departure_node(Value: Integer);
begin
  ChildNodes['departure_node'].NodeValue := Value;
end;

function TXMLVehicle_profileType.Get_Arrival_node: Integer;
begin
  Result := ChildNodes['arrival_node'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Arrival_node(Value: Integer);
begin
  ChildNodes['arrival_node'].NodeValue := Value;
end;

function TXMLVehicle_profileType.Get_Capacity: Integer;
begin
  Result := ChildNodes['capacity'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Capacity(Value: Integer);
begin
  ChildNodes['capacity'].NodeValue := Value;
end;

{ TXMLRequestsType }

procedure TXMLRequestsType.AfterConstruction;
begin
  RegisterChildNode('request', TXMLRequestType);
  ItemTag := 'request';
  ItemInterface := IXMLRequestType;
  inherited;
end;

function TXMLRequestsType.Get_Request(Index: Integer): IXMLRequestType;
begin
  Result := List[Index] as IXMLRequestType;
end;

function TXMLRequestsType.Add: IXMLRequestType;
begin
  Result := AddItem(-1) as IXMLRequestType;
end;

function TXMLRequestsType.Insert(const Index: Integer): IXMLRequestType;
begin
  Result := AddItem(Index) as IXMLRequestType;
end;

{ TXMLRequestType }

function TXMLRequestType.Get_Id: Integer;
begin
  Result := AttributeNodes['id'].NodeValue;
end;

procedure TXMLRequestType.Set_Id(Value: Integer);
begin
  SetAttribute('id', Value);
end;

function TXMLRequestType.Get_Node: Integer;
begin
  Result := AttributeNodes['node'].NodeValue;
end;

procedure TXMLRequestType.Set_Node(Value: Integer);
begin
  SetAttribute('node', Value);
end;

function TXMLRequestType.Get_Quantity: Integer;
begin
  Result := ChildNodes['quantity'].NodeValue;
end;

procedure TXMLRequestType.Set_Quantity(Value: Integer);
begin
  ChildNodes['quantity'].NodeValue := Value;
end;

end.