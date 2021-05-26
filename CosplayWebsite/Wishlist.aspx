<%@ Page Title="Wish List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="CosplayWebsite.Wishlist1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container text-black py-3 text-center">
        <h1 class="display-4">Wish List</h1>

    </div>

    <div class="pb-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 p-3 bg-white rounded shadow-sm mb-5">

                    <!-- Wish list table -->
                    <div class="table-responsive">
                        <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EnableDelete="True" EntityTypeName="" TableName="Wishlists" Where="CustomerID == @CustomerID">
                            <WhereParameters>
                                <asp:SessionParameter Name="CustomerID" SessionField="SignInID" Type="String" />
                            </WhereParameters>
                        </asp:LinqDataSource>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="LinqDataSource1">
                            <HeaderTemplate>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="border-0 bg-light">
                                                <div class="p-2 px-3 text-uppercase">Product</div>
                                            </th>
                                            <th scope="col" class="border-0 bg-light">
                                                <div class="py-2 text-uppercase">Price</div>
                                            </th>
                                            <th scope="col" class="border-0 bg-light">
                                                <div class="py-2 text-uppercase">Remove</div>
                                            </th>
                                        </tr>
                                    </thead>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenFieldProductID" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "ProductID") %>'/>
                                <tbody>
                                    <tr>
                                        <th scope="row" class="border-0">
                                            <div class="p-2">
                                                <asp:Image ID="imgProduct" runat="server" src='<%# DataBinder.Eval(Container.DataItem, "Product.ProductImages[0].Image.ImagePath") %>' Style="height: 100px; width: 100px" />
                                                <div class="ml-3 d-inline-block align-middle">
                                                    <h5 class="mb-0">
                                                        <a href="ViewProduct.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Product.ProductID") %>" class="text-dark">
                                                            <asp:Label ID="lblProduct" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Product.ProductName") %>'></asp:Label>
                                                        </a>
                                                    </h5>
                                                </div>
                                            </div>
                                        </th>
                                        <td class="border-0 align-middle"><strong>
                                            RM <asp:Label ID="lblPrice" runat="server" Text='<%#float.Parse(DataBinder.Eval(Container.DataItem, "Product.ProductPrice").ToString()).ToString("#,##0.00") %>'></asp:Label>
                                        </strong></td>
                                        <td class="border-0 align-middle">
                                            <asp:LinkButton ID="LinkButton1" runat="server" prodID='<%# DataBinder.Eval(Container.DataItem, "ProductID") %>' Onclick="LinkButton1_Click" CssClass="text-dark d-inline-block align-middle">
                                                <i class="fa fa-trash"></i>
                                            </asp:LinkButton>

                                        </td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>

                            <FooterTemplate>
                                </table>
                            </FooterTemplate>

                        </asp:Repeater>
                    </div>
                    <!-- End -->
                </div>
            </div>
        </div>
    </div>
</asp:Content>
