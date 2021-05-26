<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageOrders.aspx.cs" Inherits="CosplayWebsite.ManageOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container text-black py-3 text-center">
        <h1 class="display-4">Manage Orders</h1>
    </div>

    <div class="pb-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 p-3 bg-white rounded shadow-sm mb-5">
                    <!-- Orders table -->
                    <div class="table-responsive">
                        <table class="table mb-0">
                            <thead>
                                <tr>
                                    <th scope="col" class="border-0 bg-light text-center">
                                        <div class="p-2 px-3 text-uppercase">Order ID</div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light text-center">
                                        <div class="py-2 text-uppercase">Order Date</div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase">Customer</div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase">Total Price</div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase">Address</div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase">Order Status</div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase">Edit</div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="RepeaterOrders" runat="server" DataSourceID="LinqDataSourceOrders">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="align-middle text-center">
                                                <asp:Label ID="LabelOrderID" runat="server" Text='<%# Eval("OrderID") %>'></asp:Label>
                                            </td>
                                            <td class="align-middle text-center">
                                                <asp:Label ID="Label1" runat="server" Text='<%# DateTime.Parse(Eval("OrderDate").ToString()).ToShortDateString() %>'></asp:Label>
                                            </td>
                                            <td class="align-middle">
                                                <asp:Label ID="LabelCustomerID" runat="server" Text='<%# Eval("CustomerID") %>'></asp:Label>
                                            </td>
                                            <td class="align-middle">
                                                RM <asp:Label ID="LabelTotalPrice" runat="server" Text='<%# float.Parse(Eval("TotalPrice").ToString()).ToString("#,##0.00") %>'></asp:Label>
                                            </td>
                                            <td  class="align-middle">
                                                <asp:Label ID="LabelAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                            </td>
                                            <td  class="align-middle">
                                                <asp:Label ID="LabelOrderStatus" runat="server" Text='<%# Eval("OrderStatus1.OrderStatusDescription") %>'></asp:Label>
                                            </td>
                                            <td class="align-middle">
                                                <a href="ViewOrder.aspx?id=<%# Eval("OrderID") %>">
                                                    <i class="fa fa-pencil-alt"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

        </div>
    </div>
    <asp:LinqDataSource ID="LinqDataSourceOrders" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="Orders" Where="CosplayerID == @CosplayerID">
        <WhereParameters>
            <asp:SessionParameter Name="CosplayerID" SessionField="SignInID" Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
