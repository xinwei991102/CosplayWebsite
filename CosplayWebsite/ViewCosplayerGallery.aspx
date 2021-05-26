<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewCosplayerGallery.aspx.cs" Inherits="CosplayWebsite.ViewCosplayerGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <!--Cosplayer Profile -->
                <div class="card bg-light shadow-sm" style="width: 14rem">
                    <asp:Image ID="ImageCosplayerProfilePicture" runat="server" CssClass="card-img-top img-thumbnail" src="" />
                    <div class="card-body">
                        <h5 class="card-title">@<asp:Label ID="LabelCosplayerID" runat="server"></asp:Label></h5>
                        <h6>
                            <asp:Label ID="LabelCosplayerName" runat="server"></asp:Label>
                        </h6>
                        <p class="card-text">
                            <asp:Label ID="LabelCosplayerDesc" runat="server" Text="Cosplayer description"></asp:Label>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md">
                <h1>Gallery</h1>
                <div class="row">
                    <!-- Display Cosplayer On Sale Product -->
                    <asp:Repeater ID="rptCosplayerOnSale" runat="server" DataSourceID="LinqDataSourceCosplayerProduct" OnItemDataBound="rptCosplayerOnSale_ItemDataBound">
                        <ItemTemplate>
                            <div class="card m-2 shadow-sm align-top" style="width: 12rem; display: inline-block;">
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("ProductID") %>' />
                                <asp:Panel ID="Panel2" runat="server" ToolTip='<%#Eval("ProductName") %>'>
                                    <a href="ViewProduct.aspx?id=<%#Eval("ProductID") %>">
                                        <asp:Image ID="ImageProductImage" runat="server" CssClass="card-img-top" src='<%#Eval("ProductImages[0].Image.ImagePath")%>' Style="max-height: 190px; max-width: 190px; width:initial;"  />
                                    </a>
                                    <div class="card-body">
                                        <a href="ViewProduct.aspx?id=<%#Eval("ProductID") %>">
                                            <h6 style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                <asp:Label CssClass="card-title" ID="LabelProdName" runat="server" Text='<%#Eval("ProductName")%>'></asp:Label>
                                            </h6>
                                        </a>
                                        RM <asp:Label ID="LabelPrice" runat="server" Text='<%#Eval("ProductPrice")%>'></asp:Label>
                                        <br />
                                        <div class="text-muted">
                                            <asp:Label ID="LabelStock" runat="server" Text='0'></asp:Label> in stock
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
            </div>
        </div>

        <asp:LinqDataSource ID="LinqDataSourceCosplayerProduct" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="Products" Where="CosplayerID == @CosplayerID">
            <WhereParameters>
                <asp:QueryStringParameter Name="CosplayerID" QueryStringField="id" Type="String" />
            </WhereParameters>

        </asp:LinqDataSource>
    </div>
</asp:Content>
