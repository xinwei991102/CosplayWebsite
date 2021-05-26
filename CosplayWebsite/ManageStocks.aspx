<%@ Page Title="Manage Stocks" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageStocks.aspx.cs" Inherits="CosplayWebsite.ManageStocks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container text-center">
        <h1>
            <asp:Label ID="LabelProductName" runat="server" Text="Label"></asp:Label></h1>
        <br />

        <asp:GridView CssClass="mx-auto" Style="width: 600px;" ID="GridViewProductOptions" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID,ProductOption1" DataSourceID="LinqDataSourceProdOptions" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="ProductOption1" HeaderText="Product Option Label" ReadOnly="True" SortExpression="ProductOption1" />
                <asp:TemplateField HeaderText="Stock Available">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBoxStockNo" runat="server" TextMode="Number" min="0" step="1" Text='<%# Bind("StockNo") %>'></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorStockNo" runat="server" ControlToValidate="TextBoxStockNo" ErrorMessage="This field is required!"
                            ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidatorStockNo" runat="server" ControlToValidate="TextBoxStockNo" ForeColor="Red" Display="Dynamic"
                            ErrorMessage="Must be an integer between 0 and 999999!" MinimumValue="0" MaximumValue="999999" Type="Integer"></asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="LabelStockNo" runat="server" Text='<%# Bind("StockNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:BoundField DataField="StockNo" HeaderText="Stock Available" SortExpression="StockNo" />--%>
                <asp:CommandField ShowEditButton="True" />
            </Columns>
            <EditRowStyle BackColor="#9ec4ff" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>

        <br />
        <asp:FormView CssClass="mx-auto" ID="FormViewInsertProductOption" runat="server" DataKeyNames="ProductID,ProductOption1" DataSourceID="LinqDataSourceProdOptions" OnDataBound="FormViewInsertProductOption_DataBound" OnItemCreated="FormViewInsertProductOption_ItemCreated" OnItemInserted="FormViewInsertProductOption_ItemInserted">
            <InsertItemTemplate>
                <asp:TextBox ID="ProductIDTextBox" runat="server" Text='<%# Bind("ProductID") %>' Style="display: none;" />
                Product Option Label:
                <asp:TextBox ID="ProductOption1TextBox" runat="server" Text='<%# Bind("ProductOption1") %>' CssClass="form-control" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorProdOpt" runat="server" ControlToValidate="ProductOption1TextBox" ErrorMessage="This field is required!"
                    ForeColor="Red" Display="Dynamic"/>
                <br />
                Stock Available:
                <asp:TextBox ID="StockNoTextBox" TextMode="Number" min="0" step="1" runat="server" Text='<%# Bind("StockNo") %>' CssClass="form-control" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorStockNo" runat="server" ControlToValidate="StockNoTextBox" ErrorMessage="This field is required!"
                    ForeColor="Red" Display="Dynamic"/>
                <asp:RangeValidator ID="RangeValidatorStockNo" runat="server" ControlToValidate="StockNoTextBox" ForeColor="Red" Display="Dynamic"
                    ErrorMessage="Must be an integer between 0 and 999999!" MinimumValue="0" MaximumValue="999999" Type="Integer"/>
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" CssClass="btn btn-primary" />
                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-primary" />
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New Product Option" CssClass="btn btn-primary" />
                <a class="btn btn-secondary" href="Cosplayer.aspx">Cancel</a>
            </ItemTemplate>
            <EmptyDataTemplate>
                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New Product Option" CssClass="btn btn-primary" />
                <a class="btn btn-secondary" href="Cosplayer.aspx">Cancel</a>
            </EmptyDataTemplate>
        </asp:FormView>

    </div>
    <asp:LinqDataSource ID="LinqDataSourceProdOptions" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="ProductOptions" Where="ProductID == @ProductID" EnableInsert="True" EnableUpdate="True">
        <WhereParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="ProductID" QueryStringField="id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
