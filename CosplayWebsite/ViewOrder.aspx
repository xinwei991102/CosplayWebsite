<%@ Page Title="View Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewOrder.aspx.cs" Inherits="CosplayWebsite.ViewOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container text-black py-3 text-center">
        <h1 class="display-4">View Order</h1>
    </div>

    <asp:Panel ID="PanelCosplayerOnly" runat="server" Visible="false">
        <!--Edit Order Modal -->
        <div class="modal fade" id="editOrderModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editOrderModalTitle">Edit Order</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center">
                        <div class="form-group row m-2 text-left">
                            <label for="TextBoxTrackingNo" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Tracking Number:</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="TextBoxTrackingNo" placeholder="Max 20 characters" MaxLength="20" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <br />
                            <br />
                            <label for="DropDownListOrderStatus" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Order Status:</label>
                            <div class="col-sm-8">
                                <asp:DropDownList OnDataBound="DropDownListOrderStatus_DataBound" CssClass="form-control" ID="DropDownListOrderStatus" runat="server" DataSourceID="LinqDataSource2" DataTextField="OrderStatusDescription" DataValueField="OrderStatusID"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="ButtonSave" runat="server" CssClass="btn btn-primary m-2" Text="Save Changes" OnClick="ButtonSave_Click" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </asp:Panel>


    <div class="pb-5">
        <div class="row mx-auto my-3" style="width: 60rem;">
            <div class="col">
                Seller ID:
                <asp:Label ID="LabelCosplayerID" runat="server" Text=" "></asp:Label>
            </div>
            <div class="col text-center">
                Order Date:
                <asp:Label ID="LabelDate" runat="server" Text=" "></asp:Label>
            </div>
            <div class="col text-center">
                Tracking Number:
                <asp:Label ID="LabelTrackingNo" runat="server" Text=" "></asp:Label>
            </div>
            <div class="col text-right">
                Order Status:
                <asp:Label ID="LabelOrderStatus" runat="server" Text=" "></asp:Label>
            </div>
        </div>
        <div class="card mx-auto shadow" style="width: 60rem;">
            <div class="card-header">
                <div class="row">
                    <div class="col">
                        <strong>PRODUCT</strong>
                    </div>
                    <div class="col-2  text-center">
                        <strong>QUANTITY</strong>
                    </div>
                    <div class="col-2">
                        <strong>PRICE</strong>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="LinqDataSource1">
                    <ItemTemplate>
                        <div class="row py-3">
                            <div class="col-2">
                                <asp:Image ID="Image1" runat="server" src='<%# Eval("ProductOption1.Product.ProductImages[0].Image.ImagePath") %>' Style="height: 100px; width: 100px" />
                            </div>
                            <div class="col">
                                <strong>
                                    <a href="ViewProduct.aspx?id=<%# Eval("ProductID") %>" class="text-dark">
                                        <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("ProductOption1.Product.ProductName") %>'></asp:Label>
                                    </a>
                                </strong>
                                <br />
                                Product Option:
                                <asp:Label ID="lblOption" runat="server" Text='<%#Eval( "ProductOption") %>' CssClass="card-text"></asp:Label>
                            </div>
                            <div class="col-2 text-center">
                                <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Quantity") %>' CssClass="card-text"></asp:Label>
                            </div>
                            <div class="col-2">
                                <strong>RM
                                <asp:Label ID="lblPrice" runat="server" Text='<%#(float.Parse(Eval("ProductOption1.Product.ProductPrice").ToString())).ToString("#,##0.00") %>' CssClass="card-text"></asp:Label>
                                </strong>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="row">
                    <div class="col text-right">
                        <asp:Panel ID="PanelEditOrderBtn" runat="server" Visible="false">
                            <button type="button" class="btn btn-primary my-1" data-toggle="modal" data-target="#editOrderModal" style="width: 160px;">
                                <span class="fas fa-user-edit mr-2"></span>Edit Order
                            </button>
                        </asp:Panel>
                    </div>
                    <div class="col">
                        <asp:Button ID="ButtonBack" runat="server" Text="Go Back" class="btn btn-primary my-1" style="width: 160px;" OnClick="ButtonBack_Click"/>
                    </div>
                    <div class="col-3 pt-2">
                        Total Price:
                        <strong>RM
                        <asp:Label ID="LabelTotalPrice" runat="server" Text=" "></asp:Label>
                        </strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="OrderProducts" Where="OrderID == @OrderID">
        <WhereParameters>
            <asp:QueryStringParameter Name="OrderID" QueryStringField="id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="OrderStatus"></asp:LinqDataSource>
</asp:Content>
