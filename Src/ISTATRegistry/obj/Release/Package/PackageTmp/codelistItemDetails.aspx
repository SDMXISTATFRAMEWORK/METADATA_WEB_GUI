﻿<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" CodeBehind="codelistItemDetails.aspx.cs" Inherits="ISTATRegistry.codelistItemDetails"
    AutoEventWireup="True"
    EnableSessionState="True" %>

<%@ Register Src="UserControls/FileDownload3.ascx" TagName="FileDownload3" TagPrefix="uc1" %>
<%@ Register Src="UserControls/AddText.ascx" TagName="AddText" TagPrefix="uc2" %>
<%@ Register Src="UserControls/UserPopUp.ascx" TagName="UserPopUp" TagPrefix="uc3" %>
<%@ Register Src="UserControls/ControlAnnotations.ascx" TagName="ControlAnnotations" TagPrefix="uc4" %>

<%@ Register Src="UserControls/DuplicateArtefact.ascx" TagName="DuplicateArtefact" TagPrefix="uc5" %>
<%@ Register Src="~/UserControls/Categorisations.ascx" TagName="Categorisations"  TagPrefix="uc6" %>
<%@ Register Src="UserControls/CSVImporter.ascx" TagName="CSVImporter" TagPrefix="uc7" %>

<%@ Register Src="UserControls/CreateSubCodelistForm.ascx" TagName="SubCodelistForm" TagPrefix="uc8" %>
<%@ Register Src="UserControls/CreateSubCodelistConfirm.ascx" TagName="CreateSubCodelist" TagPrefix="uc9" %>

<%@ Register Namespace="ISTATRegistry.Classes" TagPrefix="iup" Assembly="IstatRegistry" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('#tab-container').easytabs();

            $(".datepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy'
            });
            $(".datepicker").datepicker("option", "showAnim", "drop");
            $(".datepicker").datepicker($.datepicker.regional['<%=Session["Language"]%>']);
            jQuery(function ($) {
                var form = $('form'), oldSubmit = form[0].onsubmit;
                form[0].onsubmit = null;

                if(!<%=AspConfirmationExit%>)
                    window.onbeforeunload = null;

                $('form').submit(function () {
                    // reset the onbeforeunload
                    window.onbeforeunload = null;

                    // run what actually was on
                    if (oldSubmit)
                        oldSubmit.call(this);
                });
            });

            $(window).bind('beforeunload', function (e) {
                var confirmationMessage = "<%=Resources.Messages.lbl_question_exit_page %>";  // a space
                (e || window.event).returnValue = confirmationMessage;
                $.unblockUI();
                return confirmationMessage;
            });

            $("#<%= gvCodelistsItem.ClientID %> .pgr a").click(function (e) {
                window.onbeforeunload = null;
            });

        });

        function exitf()
        {
            window.onbeforeunload = null;
            alert("ok");
            location.href="www.google.com";
        }

    </script>
    <style type="text/css">
        .etabs {
            margin: 0;
            padding: 0;
        }

        .tab {
            display: inline-block;
            zoom: 1;
            *display: inline;
            background: #eee;
            border: solid 1px #999;
            border-bottom: none;
            -moz-border-radius: 4px 4px 0 0;
            -webkit-border-radius: 4px 4px 0 0;
        }

            .tab a {
                font-size: 14px;
                line-height: 2em;
                display: block;
                padding: 0 10px;
                outline: none;
                color: #000000;
                text-decoration: none;
            }

                .tab a:hover {
                    color: #ff0000;
                    text-decoration: none;
                }

            .tab.active {
                background: #fff;
                padding-top: 6px;
                position: relative;
                top: 1px;
                border-color: #666;
                color: #000000;
                text-decoration: none;
            }

            .tab a.active {
                font-weight: bold;
                color: #000000;
                text-decoration: none;
            }

        .tab-container .panel-container {
            background: #fff;
            border: solid #666 1px;
            padding: 10px;
            -moz-border-radius: 0 4px 4px 4px;
            -webkit-border-radius: 0 4px 4px 4px;
        }

        table.tblForm tr td {
            padding-bottom: 8px;
            margin-top: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="lblCodeListDetail" runat="server" CssClass="PageTitle"><%= Resources.Messages.lbl_codelist%>&#32;<%= Resources.Messages.lbl_item_dettail %></asp:Label>

    <div id="divBack">
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/codelists.aspx?m=y" ImageUrl="~/images/back.png"><%= Resources.Messages.lbl_back %></asp:HyperLink>
    </div>

    <hr style="width: 100%" />

    <!-- Form di CRUD codelist ------- Fabrizio Alonzi -->
    <div id="tab-container" class='tab-container'>
        <ul class='etabs'>
            <li class='tab'><a href="#general"><%= Resources.Messages.lbl_general %></a></li>
            <li class='tab'><a href="#codes"><%= Resources.Messages.lbl_codes %></a></li>
            <li class='tab ircats'><a href="#categorisation" class="ircats"><%= Resources.Messages.lbl_categorisation %></a></li>
            <li class='tab subCL'><a href="#derivedCL"><%= Resources.Messages.lbl_derived_codelist %></a></li>
        </ul>
        <div class='panel-container'>
            <div id="general">
                <iup:IstatUpdatePanel ID="IstatUpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table class="tableForm">
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_id" runat="server" Text="<%# '*' + Resources.Messages.lbl_id+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_id" runat="server" Enabled="false"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_agency" runat="server" Text="<%# '*' + Resources.Messages.lbl_agency+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="cmb_agencies" runat="server" Enabled="False">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtAgenciesReadOnly" runat="server" Enabled="false" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_version" runat="server" Text="<%# '*' + Resources.Messages.lbl_version+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_version" runat="server" Enabled="false"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_isFinal" runat="server" Text="<%# Resources.Messages.lbl_is_final+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chk_isFinal" runat="server" Enabled="false" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_uri" runat="server" Text="<%# Resources.Messages.lbl_uri+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_uri" runat="server" Enabled="false"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_urn" runat="server" Text="<%# Resources.Messages.lbl_urn+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_urn" runat="server" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_valid_from" runat="server" Text="<%# Resources.Messages.lbl_valid_from+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_valid_from" runat="server" Enabled="false" CssClass="datepicker"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_valid_to" runat="server" Text="<%# Resources.Messages.lbl_valid_to+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_valid_to" runat="server" Enabled="false" CssClass="datepicker"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_name" runat="server" Text="<%# '*' + Resources.Messages.lbl_name+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:Panel ID="pnlViewName" runat="server" Visible="false">
                                        <asp:TextBox ID="txt_name_locale" runat="server" Enabled="false" TextMode="MultiLine" Rows="5" ValidationGroup="dsd"></asp:TextBox>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlEditName" runat="server" Visible="false">
                                        <uc2:AddText ID="AddTextName" runat="server" />
                                    </asp:Panel>
                                    <asp:TextBox ID="txt_all_names" runat="server" Visible="false" Enabled="false" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_description" runat="server" Text="<%# Resources.Messages.lbl_description+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td>
                                    <asp:Panel ID="pnlViewDescription" runat="server" Visible="false">
                                        <asp:TextBox ID="txt_description_locale" runat="server" Enabled="false" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlEditDescription" runat="server" Visible="false">
                                        <uc2:AddText ID="AddTextDescription" runat="server" />
                                    </asp:Panel>
                                    <asp:TextBox ID="txt_all_description" runat="server" Visible="false" Enabled="false" />
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="lbl_annotation" runat="server" Text="<%# Resources.Messages.lbl_annotation+ ':' %>" CssClass="tdProperty"></asp:Label>
                                </td>
                                <td colspan="3">
                                    <asp:Panel ID="pnlAnnotation" runat="server" Visible="true">
                                        <uc4:ControlAnnotations ID="AnnotationGeneralControl" EditMode="true" Visible="true" runat="server" />
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </iup:IstatUpdatePanel>
            </div>

            <div id="codes">
<%--                <iup:IstatUpdatePanel ID="IstatUpdatePanel2" runat="server">
                    <ContentTemplate>--%>

                        <asp:Label ID="lblNoItemsPresent" runat="server" Text="<%# Resources.Messages.lbl_no_items_in_grid %>"></asp:Label>
                        <br />
                        <asp:Label ID="lblNumberOfTotalElements" runat="server" Text=""></asp:Label>
                        <asp:GridView
                            ID="gvCodelistsItem"
                            runat="server"
                            Width="730px"
                            AllowSorting="False"
                            AllowPaging="True"
                            PagerSettings-Mode="NumericFirstLast"
                            PagerSettings-FirstPageText="<%# Resources.Messages.btn_goto_first %>"
                            PagerSettings-LastPageText="<%# Resources.Messages.btn_goto_last %>"
                            OnSorting="gvCodelistsItem_Sorting"
                            OnSorted="gvCodelistsItem_Sorted"
                            CssClass="Grid"
                            OnPageIndexChanging="gvCodelistsItem_PageIndexChanging"
                            OnRowCommand="gvCode_RowCommand"
                            AutoGenerateColumns="False"
                            OnRowUpdating="gvCodelistsItem_RowUpdating"
                            OnRowDeleting="gvCodelistsItem_RowDeleting"
                            OnRowDataBound="gvCodelistsItem_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="No.">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ID" SortExpression="ID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server" Text='<%# Bind("Code") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="400px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Parent Code" SortExpression="ParentCode">
                                    <ItemTemplate>
                                        <asp:Label ID="lblParentCode" runat="server" Text='<%# Bind("ParentCode") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="160px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton
                                            ID="img_update"
                                            runat="server"
                                            CausesValidation="False"
                                            CommandName="UPDATE"
                                            CommandArgument="<%# Container.DataItemIndex %>"
                                            ImageUrl="~/images/Details2.png"
                                            ToolTip="UPDATE" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton
                                            ID="img_delete"
                                            runat="server"
                                            CausesValidation="False"
                                            CommandName="DELETE"
                                            CommandArgument="<%# Container.DataItemIndex %>"
                                            ImageUrl="~/images/Delete2.png"
                                            ToolTip="DELETE" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNumberOfAnnotation" runat="server" Text="Label"></asp:Label>
                                        <asp:ImageButton
                                            ID="img_annotation"
                                            runat="server"
                                            CausesValidation="False"
                                            CommandName="ANNOTATION"
                                            CommandArgument="<%# Container.DataItemIndex %>"
                                            ImageUrl="~/images/Annotation.png"
                                            ToolTip="ANNOTATION" />
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
                        <asp:TextBox ID="txtNumberOfRows" runat="server" Style="text-align: center"
                            OnTextChanged="txtNumberOfRows_TextChanged" onkeydown="return (event.keyCode!=13);"
                            Width="40px"></asp:TextBox>
                        &nbsp;<asp:Button ID="btnChangePaging" runat="server"
                            Text="<%# Resources.Messages.lbl_change_number_of_rows%>" OnClick="btnChangePaging_Click" />

                        <div style="float: left">
                            <asp:Button ID="btnAddNewCode" Text="<%# Resources.Messages.lbl_add_code %>" OnClientClick="javascript: openP('df-Dimension',600); return false;" runat="server" OnClick="btnAddNewCode_Click" />
                        </div>
                             
                        <div style="float: right; padding-bottom: 10px; margin-bottom: 10px">
                            <uc7:CSVImporter ID="CSVImporter1" runat="server" />
                            <br />
                        </div>
                
                        <div id="df-Dimension" class="popup_block">
                            <asp:Label ID="lbl_title_popup_code" runat="server" Text="<%# Resources.Messages.lbl_add_code %>" CssClass="PageTitle"></asp:Label>
                            <hr style="width: 100%;" />

                            <table class="tableForm">
                                <tr>
                                    <td width="20%">
                                        <asp:Label ID="lbl_id_new" runat="server" Text="<%# '*' + Resources.Messages.lbl_id+':' %>" CssClass="tdProperty"></asp:Label>
                                    </td>
                                    <td width="80%">
                                        <asp:TextBox ID="txt_id_new" runat="server" Enabled="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_name_new" runat="server" Text="<%# '*' + Resources.Messages.lbl_name+':' %>" CssClass="tdProperty"></asp:Label>
                                    </td>
                                    <td>
                                        <uc2:AddText ID="AddTextName_new" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_description_new" runat="server" Text="<%# Resources.Messages.lbl_description+':' %>" CssClass="tdProperty"></asp:Label>
                                    </td>
                                    <td>
                                        <uc2:AddText ID="AddTextDescription_new" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_parentid_new" runat="server" Text="<%# Resources.Messages.lbl_parent_code+':' %>" CssClass="tdProperty"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_parentid_new" runat="server" Enabled="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_order_new" runat="server" Text="<%# Resources.Messages.lbl_order+':' %>" CssClass="tdProperty"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_order_new" runat="server" Enabled="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <center>
                                            <asp:Label ID="lblErrorOnNewInsert" runat="server" Text="" ForeColor="Red"></asp:Label><br />
                                            <br />
                                            <asp:Button OnClick="btnAddNewCode_Click" ID="btnNewCode" runat="server" Text="<%# Resources.Messages.btn_add_code %>" />
                                            <asp:Button ID="btnNewCodeOnFinalStructure" runat="server" Visible="false" Text="<%# Resources.Messages.btn_add_code %>" OnClick="btnNewCodeOnFinalStructure_Click" />
                                            <asp:Button ID="btnClearFields" runat="server" Text="<%# Resources.Messages.btn_cancel_operation %>" OnClick="btnClearFields_Click" />
                                        </center>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br />
                                        <asp:Label ID="lblYouAreWorkingOnAFinal" runat="server" Text="<%# Resources.Messages.lbl_working_on_a_final %>" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>

<%--                    </ContentTemplate>

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="CSVImporter1"/>
                    </Triggers>

                </iup:IstatUpdatePanel>--%>

            </div>

            <div id="categorisation" class="ircats">
                <uc6:Categorisations runat="server" ID="Categorisations" />
            </div>

            <div id="derivedCL" class="subCL">
                <uc8:SubCodelistForm runat="server" ID="SubCodelistForm1" />
                <uc9:CreateSubCodelist ID="CreateSubCodelist1" runat="server" Visible="false" />
            </div>
        </div>
    </div>

    <asp:Button ID="btnSaveMemoryCodeList" runat="server" Text="<%# Resources.Messages.btn_save %>" OnClick="btnSaveMemoryCodeList_Click" />
    <div style="float: right">
        <uc1:FileDownload3 ID="FileDownload31" runat="server" />
    </div>

    <div id="df-Dimension-update" class="popup_block">

        <asp:Label ID="lbl_title_update" runat="server" Text="<%# Resources.Messages.lbl_update_code %>" CssClass="PageTitle"></asp:Label>

        <hr style="width: 100%;" />

        <table class="tableForm">
            <tr>
                <td width="20%">
                    <asp:Label ID="lbl_id_update" runat="server" Text="<%# '*' + Resources.Messages.lbl_id+':' %>" CssClass="tdProperty"></asp:Label>
                </td>
                <td width="80%">
                    <asp:TextBox ID="txt_id_update" runat="server" Enabled="false"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl_name_update" runat="server" Text="<%# '*' + Resources.Messages.lbl_name+':' %>" CssClass="tdProperty"></asp:Label>
                </td>
                <td>
                    <uc2:AddText ID="AddTextName_update" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl_description_update" runat="server" Text="<%# Resources.Messages.lbl_description+':' %>" CssClass="tdProperty"></asp:Label>
                </td>
                <td>
                    <uc2:AddText ID="AddTextDescription_update" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl_parentid_update" runat="server" Text="<%# Resources.Messages.lbl_parent_code +':' %>" CssClass="tdProperty"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txt_parentid_update" runat="server" Enabled="true"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl_order_update" runat="server" Text="<%# Resources.Messages.lbl_order +':' %>" CssClass="tdProperty"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txt_order_update" runat="server" Enabled="true"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <center>
                        <asp:Label ID="lblErrorOnUpdate" runat="server" Text="" ForeColor="Red"></asp:Label><br />
                        <br />
                        <asp:Button OnClick="btnUpdateCode_Click" ID="btnUpdateCode" runat="server" Text="<%# Resources.Messages.btn_update_code%>" />
                        <asp:Button ID="btnClearFieldForUpdate" runat="server"
                            Text="<%# Resources.Messages.btn_cancel_operation %>"
                            OnClick="btnClearFieldsForUpdate_Click" />
                        <uc3:UserPopUp ID="UserPopUp2" runat="server" />
                    </center>
                </td>
            </tr>
        </table>
    </div>
    <div id="code_annotation" class="popup_block">
        <asp:Label ID="lblAnnotationAttribute" runat="server" Text="Annotation Manager" CssClass="PageTitle"></asp:Label>
        <hr style="width: 95%;" />
        <table class="tableForm">
            <tr>
                <td>
                    <uc4:ControlAnnotations ID="ctr_annotation_update" runat="server" PopUpContainer="code_annotation" />
                </td>
            </tr>
        </table>
        <asp:Button ID="btnSaveAnnotationCode" runat="server" Text="<%# Resources.Messages.btn_save %>" OnClick="btnSaveAnnotationCode_Click" />
    </div>

    <uc3:UserPopUp ID="UserPopUp1" runat="server" />

    <uc5:DuplicateArtefact ID="DuplicateArtefact1" runat="server" Visible="false" />

</asp:Content>
