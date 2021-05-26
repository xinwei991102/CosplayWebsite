<%@ Page Title="Purchase History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseHistory.aspx.cs" Inherits="CosplayWebsite.PurchaseHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container text-black py-3 text-center">
        <h1 class="display-4">Purchase History</h1>
    </div>

    <div class="pb-5">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="LinqDataSource1">
            <HeaderTemplate>
            </HeaderTemplate>

            <ItemTemplate>
                <div class="card mx-auto my-3 shadow" style="width: 60rem;">
                    <div class="card-header">
                        <div class="row">
                            <div class="col">
                                Seller ID:
                                <a href="ViewCosplayerGallery.aspx?id=<%#Eval("CosplayerID")%>">
                                    <asp:Label ID="lblCosplayerID" runat="server" Text='<%#Eval("CosplayerID") %>'></asp:Label>
                                </a>
                            </div>
                            <div class="col-3">
                                <asp:Label ID="lblPurchaseStatus" runat="server" Text='<%#Eval("OrderStatus1.OrderStatusDescription") %>'></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-2">
                                <asp:Image ID="Image1" runat="server" src='<%#Eval("OrderProducts[0].ProductOption1.Product.ProductImages[0].Image.ImagePath") %>' Style="height: 100px; width: 100px" />
                            </div>
                            <div class="col">
                                <strong>
                                    <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("OrderProducts[0].ProductOption1.Product.ProductName") %>'></asp:Label>
                                </strong>
                                <br />
                                Product Option:
                                <asp:Label ID="lblOption" runat="server" Text='<%#Eval("OrderProducts[0].ProductOption") %>' CssClass="card-text"></asp:Label>
                            </div>
                            <div class="col-2 text-right">
                                Quantity:
                                <br />
                                Total Price: 
                                <br />
                                Order Date: 
                                <br />
                                Tracking Number: 
                            </div>
                            <div class="col-2">
                                <strong>
                                    <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("OrderProducts[0].Quantity") %>' CssClass="card-text"></asp:Label>
                                    <br />
                                    RM
                                    <asp:Label ID="lblPrice" runat="server" Text='<%# float.Parse(Eval("TotalPrice").ToString()).ToString("#,##0.00") %>' CssClass="card-text"></asp:Label>
                                    <br />
                                    <asp:Label ID="lblDate" runat="server" Text='<%# ((DateTime)Eval("OrderDate")).ToShortDateString() %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lblTrackingNo" runat="server" Text='<%# Eval("TrackingNo") %>'></asp:Label>
                                </strong>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                            </div>
                            <div class="col-3 mt-2 text-center">
                                <a href="ViewOrder.aspx?id=<%#Eval("OrderID") %>" class="btn btn-primary">View Order
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>

        </asp:Repeater>
    </div>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="Orders" Where="CustomerID == @CustomerID" OrderBy="OrderID desc, OrderStatus">
        <WhereParameters>
            <asp:SessionParameter Name="CustomerID" SessionField="SignInID" Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
