﻿<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true"
    CodeBehind="DataFlow.aspx.cs" Inherits="ISTATRegistry.dataFlow" %>

<%@ Register Src="UserControls/FileDownload3.ascx" TagName="FileDownload3" TagPrefix="uc3" %>
<%@ Register src="UserControls/ArtefactDelete.ascx" tagname="ArtefactDelete" tagprefix="uc1" %>
<%@ Register src="UserControls/SearchBar.ascx" tagname="SearchBar" tagprefix="uc2" %>
<%@ Register Namespace= "ISTATRegistry.Classes" TagPrefix="iup" Assembly="IstatRegistry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h3 class="PageTitle"><%= Resources.Messages.lbl_data_flow %></h3>
    
    <hr style="width: 100%" />
    
    <iup:IstatUpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <uc2:SearchBar ID="SearchBar1" runat="server" />  
            <asp:Label ID="lblNumberOfTotalElements" runat="server" Text=""></asp:Label>  
            <asp:GridView 
                ID="gridView" 
                runat="server" 
                CssClass="Grid" 
                AllowPaging="True"
                PagerSettings-Mode="NumericFirstLast"    
                PagerSettings-FirstPageText="<%# Resources.Messages.btn_goto_first %>"
                PagerSettings-LastPageText="<%# Resources.Messages.btn_goto_last %>"
                AllowSorting="True"
                OnSorted="OnSorted"
                OnSorting="OnSorting"
                AutoGenerateColumns="False"
                DataSourceID="ObjectDataSource1"                 
                OnPageIndexChanging="OnPageIndexChanging" 
                OnRowCreated="OnRowCreated"
                PagerSettings-Position="TopAndBottom" 
                onrowdatabound="gridView_RowDataBound">            
                <Columns>
                    <asp:TemplateField HeaderText="ID" SortExpression="ID">
                        <ItemTemplate>
                            <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="190px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Agency" SortExpression="Agency">
                        <ItemTemplate>
                            <asp:Label ID="lblAgency" runat="server" Text='<%# Bind("Agency") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="70px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Version" SortExpression="Version">
                        <ItemTemplate>
                            <asp:Label ID="lblVersion" runat="server" Text='<%# Bind("Version") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="50px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                        <ItemTemplate>
                            <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="310px" />
                    </asp:TemplateField>   
                    <asp:TemplateField HeaderText="IsFinal" SortExpression="IsFinal">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkIsFinal" runat="server" Enabled="false" Checked='<%# Bind("IsFinal") %>' />
                        </ItemTemplate>
                        <HeaderStyle Width="50px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="LocalID" HeaderText="LocalID" SortExpression="LocalID" Visible="False" />                    
                    <asp:CommandField EditText="Edit" HeaderText="View/Edit" ShowEditButton="True" Visible="False" />                   
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <ItemTemplate>
                            <uc1:ArtefactDelete 
                            ID="ArtDelete" 
                            runat="server" 
                            ucID='<%# Eval("ID") %>'
                            ucAgency='<%# Eval("Agency") %>' 
                            ucVersion='<%# Eval("Version") %>' 
                            ucArtefactType='DataFlow' />
                        </ItemTemplate>
                        <HeaderStyle Width="50px" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <ItemTemplate>
                            <asp:HyperLink ID="hplDetails" 
                                runat="server" 
                                ImageUrl="~/images/Details2.png" 
                                NavigateUrl="s"
                                ToolTip="View details">
                            </asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle Width="50px" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <uc3:FileDownload3 
                            ID="FileDownload3" 
                            runat="server" 
                            ucID='<%# Eval("ID") %>' 
                            ucAgency='<%# Eval("Agency") %>' 
                            ucVersion='<%# Eval("Version") %>' 
                            ucArtefactType='Dataflow' />
                        </ItemTemplate>
                        <HeaderStyle Width="50px" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="hs" />
                <RowStyle CssClass="rs" />
                <AlternatingRowStyle CssClass="ars" />
                <PagerStyle CssClass="pgr"></PagerStyle>
            </asp:GridView>
            <asp:Label ID="lblNumberOfRows" runat="server" Text="<%# Resources.Messages.lbl_number_of_rows + ':'%>"></asp:Label>
             <asp:TextBox ID="txtNumberOfRows" runat="server" style="text-align:center" onkeydown = "return (event.keyCode!=13);"
                ontextchanged="txtNumberOfRows_TextChanged" 
                Width="40px"></asp:TextBox>&nbsp;<asp:Button ID="btnChangePaging" runat="server" 
                Text="<%# Resources.Messages.lbl_change_number_of_rows%>" onclick="btnChangePaging_Click" />
            <br /><br />
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetDataFlowList" TypeName="ISTAT.EntityMapper.EntityMapper">
                <SelectParameters>
                    <asp:Parameter Name="sdmxObjects" Type="Object" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:Button ID="btnAddDataFlow" runat="server" onclick="btnAddDataFlow_Click" Text="<%# Resources.Messages.btn_new_dataflow%>" Visible="false" />
        </ContentTemplate>
    </iup:IstatUpdatePanel>
</asp:Content>
