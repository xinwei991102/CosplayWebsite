<%@ Page Title="View Product" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewProduct.aspx.cs" Inherits="CosplayWebsite.ViewProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

     <asp:HiddenField runat="server" ID="productType"/>

    <!-- Product Gallery -->
    <div class="container">
        <div class="row">
            <div class="col-lg-5" >
                <div id="carousel" class="carousel slide" data-ride="carousel">

                    <!-- Indicator -->
                    <ol class="carousel-indicators " style="width: 400px; margin-left: 0; margin-right: 0;">
                        <asp:Repeater ID="rptCarouselIndicator" runat="server" DataSourceID="LinqDataSource2">
                            <ItemTemplate>
                                <li data-target="#carousel" data-slide-to='<%# Container.ItemIndex %>' class='<%# Container.ItemIndex == 0 ? "active":"" %>'></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ol>
                    <!-- Left column -->

                    <!-- Product Slideshow -->
                    <div class="carousel-inner" style="width: 400px; height: 400px;">
                        <asp:Repeater ID="rptProductSlideshow" runat="server" DataSourceID="LinqDataSource2">
                            <ItemTemplate>
                                <div class="carousel-item <%#(Container.ItemIndex == 0 ? "active" : "") %>" style="width: 400px; height: 400px">
                                    <asp:Image ID="productPictures" CssClass="mx-auto d-block" runat="server" Style="max-width: 400px;max-height:400px; height: 400px" src='<%#Eval("Image.ImagePath")%>' />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <!-- Button Left & Right -->
                        <a class="carousel-control-prev" href="#carousel" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carousel" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Product Details -->
            <!-- Right column -->
            <div class="col">
                <div>
                    <h2>
                        <asp:Label ID="ppname" runat="server"></asp:Label>
                    </h2>

                    <h2 class="text-danger">
                        <asp:Label ID="pprice" runat="server"></asp:Label>
                    </h2>

                    <div>
                        <a id="CosplayerLink" runat="server"></a>
                        <br />
                        From: <strong><asp:Label ID="LabelSourceMaterial" runat="server" Text=" "></asp:Label></strong>
                    </div>

                    <p>
                        <asp:Label ID="ppdesc" runat="server"></asp:Label>
                    </p>

                    <asp:Label ID="lblOptions" runat="server" Text="Options"></asp:Label>
                    <asp:DropDownList ID="ddlOption" runat="server" CssClass="form-control" DataSourceID="LinqDataSourceProdOpt" DataTextField="ProductOption1" DataValueField="ProductOption1" OnSelectedIndexChanged="ddlOption_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    <asp:Label ID="lblStock" runat="server" Text="" CssClass="text-muted"></asp:Label><br />
                    <asp:Label ID="lblQty" runat="server" Text="Quantity"></asp:Label>
                    <asp:TextBox ID="qty" runat="server" TextMode="Number" step="1" Text="0" CssClass="form-control" min="0" oninput="validity.valid||(value='');"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidatorQty" style="display:block;" runat="server" ErrorMessage="Not enough stock"
                        ControlToValidate="qty" MaximumValue="999" MinimumValue="0" ForeColor="Red" Type="Integer"
                        Display="Dynamic"></asp:RangeValidator>
                    <br />
                    <asp:Button ID="btnAddToCart" runat="server" Text="Add To Cart" CssClass="btn btn-danger my-3" OnClick="btnAddToCart_Click" />
                    <asp:Button ID="btnAddToWishlist" runat="server" Text="Add To Wishlist" CssClass="btn btn-danger my-3 ml-3" OnClick="btnAddToWishlist_Click" />
                </div>
            </div>
            <div class="w-100"></div>
        </div>
        <br />

         <!-- Suggested Products Gallery -->
        <div class="row">
            <h3>You may also like: </h3>
        </div>

        <div class="row">
            <asp:Repeater ID="RepeaterSimilarProd" runat="server" DataSourceID="LinqDataSource1" OnItemDataBound="RepeaterSimilarProd_ItemDataBound">
                <ItemTemplate>

                     <div class="card m-2 shadow-sm align-top" style="width: 12rem; display: inline-block;">
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("ProductID") %>' />
                        <asp:Panel ID="Panel2" runat="server" ToolTip='<%#Eval("ProductName") %>'>
                            <a href="ViewProduct.aspx?id=<%#Eval("ProductID") %>">
                                <asp:Image ID="ImageProductImage" runat="server" CssClass="card-img-top" src='<%#Eval("ProductImages[0].Image.ImagePath")%>' Style="max-height: 190px; max-width: 190px; width: initial;" />
                            </a>
                            <div class="card-body">
                                <a href="ViewProduct.aspx?id=<%#Eval("ProductID") %>">
                                    <h6 style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        <asp:Label CssClass="card-title" ID="LabelProdName" runat="server" Text='<%#Eval("ProductName")%>'></asp:Label>
                                    </h6>
                                </a>
                                RM
                                <asp:Label ID="LabelPrice" runat="server" Text='<%#float.Parse(Eval("ProductPrice").ToString()).ToString("#,##0.00")%>'></asp:Label>
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

        <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="ProductImages" Where="ProductID == @ProductID">
            <WhereParameters>
                <asp:QueryStringParameter Name="ProductID" QueryStringField="id" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>


        <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="Products" Where="ProductType == @ProductType">
            <WhereParameters>
                <asp:SessionParameter Name="ProductType" SessionField="ProductType" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="LinqDataSourceProduct" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="Products" Where="ProductID == @ProductID">
            <WhereParameters>
                <asp:QueryStringParameter DefaultValue="" Name="ProductID" QueryStringField="id" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="LinqDataSourceProdOpt" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="ProductOptions" Where="ProductID == @ProductID">
            <WhereParameters>
                <asp:QueryStringParameter Name="ProductID" QueryStringField="id" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>
    </div>
</asp:Content>

