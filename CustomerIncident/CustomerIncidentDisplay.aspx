<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerIncidentDisplay.aspx.cs" Inherits="CustomerIncident.CustomerIncidentDisplay" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Incident Display</title>
    <style type="text/css"> 
        .header {background-color: gainsboro;} 
        .content {border: solid;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Customer Incident Display</h1>
            Mark Bukovich<p></p>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [CustomerID], [Name] FROM [Customers] ORDER BY [Name]"></asp:SqlDataSource>
        </div>
        Customer Name:
        <asp:DropDownList ID="ddlCustomers" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CustomerID">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Products.Name AS Expr1, Incidents.Title, Technicians.Name, Incidents.Description, Incidents.DateOpened, Incidents.DateClosed FROM Incidents INNER JOIN Technicians ON Incidents.TechID = Technicians.TechID INNER JOIN Products ON Incidents.ProductCode = Products.ProductCode WHERE (Incidents.CustomerID = @CustomerID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCustomers" DefaultValue="0" Name="CustomerID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <p></p>
        <ajaxToolkit:Accordion ID="acc1" runat="server" DataSourceID="SqlDataSource2" HeaderCssClass="header" HeaderSelectedCssClass="header" ContentCssClass="content" Width="350">
            <HeaderTemplate>
                <b>Incident Title: <%#DataBinder.Eval(Container.DataItem, "Title") %></b>
            </HeaderTemplate>
            <ContentTemplate>
                <p>Expr1: <%#DataBinder.Eval(Container.DataItem, "Expr1") %></p>
                <p>Technician Name: <%#DataBinder.Eval(Container.DataItem, "Name") %></p>
                <p>Description: <%#DataBinder.Eval(Container.DataItem, "Description") %></p>
                <p>Date Opened: <%#DataBinder.Eval(Container.DataItem, "DateOpened") %></p>
                <p>Date Closed: <%#DataBinder.Eval(Container.DataItem, "DateClosed") %></p>
            </ContentTemplate>
        </ajaxToolkit:Accordion>
        <br />
        <br />
    </form>
</body>
</html>
