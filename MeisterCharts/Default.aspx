<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MeisterCharts.Default" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../../Common/Scripts/pako.min.js"></script>
</head>
    <html xmlns='http://www.w3.org/1999/xhtml'> 
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />   
        <table>
            <tr>
                <td>Erträge</td>
                <td><telerik:RadNumericTextBox ID="TbErtrag" Value="73292.37" runat="server"><NumberFormat DecimalSeparator="," GroupSeparator="." /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>Bestandsveränderung</td>
                <td><telerik:RadNumericTextBox ID="TbBestandsveränderung" Value="61102.5" runat="server"><NumberFormat DecimalSeparator="," GroupSeparator="."  /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>Aufwand</td>
                <td><telerik:RadNumericTextBox ID="TbAufwand" Value="12013.23" runat="server"><NumberFormat DecimalSeparator="," GroupSeparator="."  /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>Pachtzinsen</td>
                <td><telerik:RadNumericTextBox ID="TbPacht"  Value="6996.96" runat="server"><NumberFormat DecimalSeparator=","  GroupSeparator="." /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>AfA Maschinen</td>
                <td><telerik:RadNumericTextBox ID="TbAfAMaschinen" Value="28146.11" runat="server"><NumberFormat DecimalSeparator="," GroupSeparator="."  /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>AfA Gebäude</td>
                <td><telerik:RadNumericTextBox ID="TbAfAGebäude" Value="6280" runat="server"><NumberFormat DecimalSeparator=","  GroupSeparator="." /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>Sozialeinkünfte</td>
                <td><telerik:RadNumericTextBox ID="TbSozial" Value="0" runat="server"><NumberFormat DecimalSeparator="," GroupSeparator="."  /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>Außerlandwirtschaftliches Einkommen</td>
                <td><telerik:RadNumericTextBox ID="TbALEinkommen" Value="0" runat="server"><NumberFormat DecimalSeparator=","  GroupSeparator="." /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>Lebenserhaltungskosten</td>
                <td><telerik:RadNumericTextBox ID="TbLebenskosten" Value="30267.85" runat="server"><NumberFormat DecimalSeparator=","  GroupSeparator="." /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>SVB Beitrag</td>
                <td><telerik:RadNumericTextBox ID="TbSVB" Value="10008.10" runat="server"><NumberFormat DecimalSeparator="," GroupSeparator="."  /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>Einkommenssteuer</td>
                <td><telerik:RadNumericTextBox ID="TbSteuer" Value="12000" runat="server"><NumberFormat DecimalSeparator="," GroupSeparator="."  /></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>Schuldzinsen</td>
                <td><telerik:RadNumericTextBox ID="TbZinsen" Value="5000" runat="server"><NumberFormat DecimalSeparator="," GroupSeparator="."  /></telerik:RadNumericTextBox></td>
            </tr>
        </table>
    <telerik:RadButton runat="server" Text="Einlesen" ID="radButtonGo" OnClick="radButtonGo_Click"></telerik:RadButton>
          <telerik:RadButton runat="server" OnClientClicked="exportChart" Text="Export PDF (geduld nach dem klicken, dauert manchmal etwas"
               AutoPostBack="false"></telerik:RadButton>
        <br />
        <telerik:RadLabel runat="server" Text="Dieser Link enthält die eingegeben Daten und kann so erneut aufgerufen werden!"></telerik:RadLabel>
        <telerik:RadTextBox ID="TbQueryString" runat="server" Width="600"></telerik:RadTextBox>
        <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1">
        </telerik:RadClientExportManager>
    <div id=".RadHtmlChart">
        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Width="1000px" Height="700px">
            <PlotArea>
                <Series>                   
                    <telerik:ColumnSeries  DataFieldY="ValuePositiv1" Stacked="true" ColorField="ColorP1" Spacing="0" Gap="0">
                        <LabelsAppearance DataField="NameP1" DataFormatString="{0:C2}" Position="Center" Color="White">    
                            <TextStyle  FontFamily="Arial Unicode MS" />                        
                            <ClientTemplate>                                
                                #if(value >0) {##=dataItem.NameP1##if(value > 1000){#\n#}#
                                #=value#€#}#
                            </ClientTemplate>
                            </LabelsAppearance>
                    </telerik:ColumnSeries>
                    <telerik:ColumnSeries  DataFieldY="ValueNegativ1" Stacked="true" ColorField="ColorN1" Spacing="0" Gap="0">
                        <LabelsAppearance DataField="NameN1" Position="Center" DataFormatString="{0:C2}"  Color="White">
                            <TextStyle  FontFamily="Arial Unicode MS" /> 
                            <ClientTemplate>
                               #if(value >0) {##=dataItem.NameN1# #if(value > 1000){#\n#}#
                                #=value#€#}#
                            </ClientTemplate></LabelsAppearance>
                    </telerik:ColumnSeries>
                    <telerik:ColumnSeries  DataFieldY="ValueNegativ2" Stacked="true" ColorField="ColorN2" Spacing="0" Gap="0">
                        <LabelsAppearance DataField="NameN2" Position="Center" DataFormatString="{0:C2}"  Color="White">
                            <TextStyle  FontFamily="Arial Unicode MS" /> 
                            <ClientTemplate>
                               #if(value >0) {##=dataItem.NameN2##if(value > 1000){#\n#}#
                                #=value#€#}#
                            </ClientTemplate></LabelsAppearance>
                    </telerik:ColumnSeries>
                    <telerik:ColumnSeries  DataFieldY="ValueNegativ3" Stacked="true" ColorField="ColorN3" Spacing="0" Gap="0">
                        <LabelsAppearance DataField="NameN3" Position="Center" DataFormatString="{0:C2}"  Color="White">
                            <TextStyle  FontFamily="Arial Unicode MS" /> 
                            <ClientTemplate>
                                #if(value >0) {##=dataItem.NameN3##if(value > 1000){#\n#}#
                                #=value#€#}#
                            </ClientTemplate></LabelsAppearance>
                    </telerik:ColumnSeries>
                    <telerik:ColumnSeries  DataFieldY="ValuePositiv2" Stacked="true" ColorField="ColorP2" Spacing="0" Gap="0">
                        <LabelsAppearance DataField="NameP2" Position="Center"  DataFormatString="{0:C2}" Color="White">
                            <TextStyle  FontFamily="Arial Unicode MS" /> 
                            <ClientTemplate>
                                #if(value >0) {##=dataItem.NameP2##if(value > 1000){#\n#}#
                                #=value#€#}#
                            </ClientTemplate></LabelsAppearance>
                    </telerik:ColumnSeries>
                    <telerik:ColumnSeries  DataFieldY="ValuePositiv3" Stacked="true"   ColorField="ColorP3" Spacing="0" Gap="0">
                        <LabelsAppearance DataField="NameP3" Position="Center" DataFormatString="{0:C2}" Color="White">
                            <TextStyle  FontFamily="Arial Unicode MS" /> 
                            <ClientTemplate>
                                #if(value >0) {##=dataItem.NameP3##if(value > 1000){#\n#}#
                                #=value#€#}#
                            </ClientTemplate></LabelsAppearance>
                    </telerik:ColumnSeries>
                </Series>
                <XAxis>
                    <Items>
                        <telerik:AxisItem LabelText="Ertrag/Leistung" />
                        <telerik:AxisItem LabelText="Variable Kosten u.\nGesamtdeckungs-\nbeitrag" />
                        <telerik:AxisItem LabelText="Fixkosten und\nEinkünfte aus Land-\nund Forstwirtschaft" />
                        <telerik:AxisItem LabelText="Gesamteinkommen" />
                        <telerik:AxisItem LabelText="Verbrauch und\nUnter/Überdeckung\ndes Verbrauchs\n(= Eigenkapitalbildung" />
                        <telerik:AxisItem LabelText="mittelfristige Kapital-\ndienstgenze bei\nSchuldenfreiheit" />
                    </Items>
                </XAxis>
                <YAxis  Type="Numeric" Name="€">   
                     <LabelsAppearance DataFormatString="{0}€"></LabelsAppearance>            
                </YAxis>
            </PlotArea>
            <Legend>
                <Appearance Visible="false"></Appearance>
            </Legend>
            <ChartTitle Text="Betriebliche Kennzahlen">
<Appearance Visible="True">
</Appearance>
            </ChartTitle>

<Zoom Enabled="False"></Zoom>
        </telerik:RadHtmlChart>
        <p>&copy; <%=DateTime.Now.Year%> Alexander Kroiss<p>
    </div>
                           <script>
                               var $ = $telerik.$;
                               function exportChart() {
                                   $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".RadHtmlChart"));
                        }

    </script>        
    </form>
</body>

</html>
