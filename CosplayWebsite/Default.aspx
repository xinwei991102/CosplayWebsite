<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CosplayWebsite._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container pb-5">
        <div class="row">
            <div class="col-lg">
                <h2 class="display-4">
                    <asp:Label ID="LabelTitle" runat="server" Text="All Costumes"></asp:Label></h2>
            </div>
            <div class="col-lg-2">
                <asp:Label ID="lblFilterBy" runat="server" Text="Filter By: "></asp:Label>
                <asp:DropDownList OnDataBound="ddlFilterBy_DataBound" ID="ddlFilterBy" runat="server" CssClass="form-control" AutoPostBack="True" DataSourceID="LinqDataSourceFilterBy" DataTextField="ProductTypeDesc" DataValueField="ProductTypeID" OnSelectedIndexChanged="ddlFilterBy_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="col-lg-2">
                <asp:Label ID="lblSortBy" runat="server" Text="Sort By:"></asp:Label>
                <asp:DropDownList ID="ddlSortBy" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">
                    <asp:ListItem Value="ProductPrice">Price</asp:ListItem>
                    <asp:ListItem Value="ProductName">Name</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="row pt-3">
            <!-- Display All Product -->
            <asp:Repeater ID="rptAllProduct" runat="server" DataSourceID="LinqDataSourceProduct" OnItemDataBound="rptAllProduct_ItemDataBound">
                <ItemTemplate>

                    <div class="card m-2 shadow-sm align-top" style="width: 12rem; display: inline-block;">
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("ProductID") %>' />
                        <asp:Panel ID="Panel2" runat="server" ToolTip='<%#Eval("ProductName") %>'>
                            <a href="ViewProduct.aspx?id=<%#Eval("ProductID") %>">
                                <asp:Image ID="ImageProductImage" runat="server" CssClass="card-img-top" src='<%#Eval("ProductImages[0].Image.ImagePath")%>' Style="max-height: 190px; max-width: 190px; width:initial;" />
                            </a>
                            <div class="card-body">
                                <a href="ViewProduct.aspx?id=<%#Eval("ProductID") %>">
                                    <h6 style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        <asp:Label CssClass="card-title" ID="LabelProdName" runat="server" Text='<%#Eval("ProductName")%>'></asp:Label>
                                    </h6>
                                </a>
                                RM
                                <asp:Label ID="LabelPrice" runat="server" Text='<%# float.Parse(Eval("ProductPrice").ToString()).ToString("#,##0.00")%>'></asp:Label>
                                <br />
                                <div class="text-muted">
                                    <asp:Label ID="LabelStock" runat="server" Text='0'></asp:Label>
                                    in stock
                                </div>
                                <a href="ViewCosplayerGallery.aspx?id=<%#Eval("CosplayerID")%>">
                                    <asp:Label ID="Label1" runat="server" ToolTip="View Cosplayer Gallery"><%# Eval("Cosplayer.CosplayerName") %></asp:Label>
                                </a>
                            </div>
                        </asp:Panel>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:LinqDataSource ID="LinqDataSourceFilterBy" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="ProductTypes"></asp:LinqDataSource>

        <asp:LinqDataSource ID="LinqDataSourceProduct" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="Products" OnSelecting="LinqDataSourceProduct_Selecting"></asp:LinqDataSource>
    </div>

</asp:Content>
