<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="CosplayWebsite.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container text-black py-3 text-center">
        <h1 class="display-4">Cart</h1>
    </div>

    <h1 class="text-center">
        <asp:Label ID="LabelEmpty" runat="server" Text="Your cart is empty!" Visible="false"></asp:Label>
    </h1>

    <div class="pb-5">
        <asp:Panel ID="PanelFooter" runat="server">
            <div class="container  shadow-sm">
                <div class="row">
                    <div class="col-lg-12 p-3 bg-white rounded mb-5">
                        <!-- Shopping cart table -->
                        <div class="table-responsive">
                            <table class="table mb-0" oninput="total.value=quantity.value*price.value">
                                <thead>
                                    <tr>
                                        <th scope="col" colspan="2" class="border-0 bg-light" style="width: 45%">
                                            <div class="p-2 px-3 text-uppercase">Product</div>
                                        </th>
                                        <th scope="col" class="border-0 bg-light">
                                            <div class="py-2 text-uppercase">Price</div>
                                        </th>
                                        <th scope="col" class="border-0 bg-light">
                                            <div class="py-2 text-uppercase">Quantity</div>
                                        </th>
                                        <th scope="col" class="border-0 bg-light">
                                            <div class="py-2 text-uppercase">Subtotal</div>
                                        </th>
                                        <th scope="col" class="border-0 bg-light text-center">
                                            <div class="py-2 text-uppercase">Remove</div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <asp:Repeater ID="RepeaterCart" runat="server" DataSourceID="LinqDataSourceCart" OnItemDataBound="RepeaterCart_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td class="border-0 align-middle">
                                                    <div>
                                                        <img src='<%# Eval("ProductOption1.Product.ProductImages[0].Image.ImagePath") %>' alt="" width="70" class="rounded shadow-sm">
                                                    </div>
                                                </td>
                                                <td class="border-0 align-middle" style="max-width: 550px; width: 550px;">
                                                    <div class="ml-3 align-middle">
                                                        <a href="ViewProduct.aspx?id=<%# Eval("ProductID") %>" class="text-dark">
                                                            <h5 class="mb-0" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                                <asp:Label ID="LabelProdName" runat="server" Text='<%# Eval("ProductOption1.Product.ProductName") %>'></asp:Label>
                                                            </h5>
                                                        </a>
                                                        <span class="text-muted font-weight-normal font-italic d-block">Option: <%#Eval("ProductOption") %></span>
                                                    </div>
                                                </td>
                                                <td class="border-0 align-middle" id="price">
                                                    <strong>RM <%# (float.Parse(Eval("ProductOption1.Product.ProductPrice").ToString())).ToString("#,##0.00") %></strong>
                                                </td>
                                                <td class="border-0 align-middle">
                                                    <asp:TextBox type="number" 
                                                        prodID='<%# Eval("ProductID") %>' prodOpt='<%# Eval("ProductOption") %>' 
                                                        class="form-control"  AutoPostBack="true" OnTextChanged="quantity_TextChanged"
                                                        step="1" max='<%# Eval( "ProductOption1.StockNo") %>' min="1" Text='<%#Eval("Quantity") %>' 
                                                        ID="TextBoxQty" runat="server" CausesValidation="true"></asp:TextBox>
                                                    <asp:RangeValidator ID="RangeValidatorQty" runat="server" ErrorMessage="Not enough stock"
                                                        ControlToValidate="TextBoxQty" MaximumValue='<%# Eval( "ProductOption1.StockNo") %>' MinimumValue="0" ForeColor="Red" Type="Integer"
                                                        Display="Dynamic"></asp:RangeValidator>
                                                    <asp:CompareValidator ID="CompareValidatorQty" runat="server" ValueToCompare="0" ControlToValidate="TextBoxQty"  Display="Dynamic" ForeColor="Red"
                                                        ErrorMessage="Must enter positive integers." Operator="NotEqual" Type="Integer"></asp:CompareValidator>
                                                </td>

                                                <td class="border-0 align-middle">
                                                    <strong>RM <%#( float.Parse(Eval("ProductOption1.Product.ProductPrice").ToString()) * float.Parse(Eval("Quantity").ToString()) ).ToString("#,##0.00")%></strong>
                                                </td>

                                                <td class="border-0 align-middle text-center">
                                                    <asp:LinkButton ID="LinkButton_delete" runat="server" prodID='<%# Eval("ProductID") %>' prodOption='<%# Eval("ProductOption") %>' OnClick="Delete_Click" CssClass="text-dark d-inline-block align-middle" CausesValidation="false">
                                            <i class="fa fa-trash"></i>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>

                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                        <!-- End -->

                    </div>
                </div>

                <div class="row">
                    <div class="col text-right pb-3 align-middle">
                        Total: <strong>RM
                            <asp:Label ID="LabelTotalPrice" runat="server"></asp:Label>
                        </strong>
                    </div>
                    <div class="col-3 pb-3 align-middle">
                        <asp:LinkButton ID="LinkButtonCheckOut" CssClass="btn btn-primary btn-block" runat="server" PostBackUrl="~/OrderSummary.aspx">Proceed to checkout</asp:LinkButton>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
    <asp:LinqDataSource ID="LinqDataSourceCart" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="CartProducts" Where="CustomerID == @CustomerID" EnableUpdate="True">
        <WhereParameters>
            <asp:SessionParameter Name="CustomerID" SessionField="SignInID" Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
