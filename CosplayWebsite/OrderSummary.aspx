<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderSummary.aspx.cs" Inherits="CosplayWebsite.OrderSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row pb-5 bg-white rounded mx-auto" style="max-width: 80rem;">
        <div class="col-lg-6 mx-auto shadow-sm">
            <div class="bg-light rounded-pill px-4 py-3 mt-3 text-uppercase font-weight-bold">Order summary </div>
            <div class="p-4">
                <ul class="list-unstyled mb-4" >
                    <asp:Repeater ID="RepeaterCartItems" runat="server" DataSourceID="LinqDataSourceCart">
                        <ItemTemplate>
                            <li class="d-flex justify-content-between py-3">
                                <img src='<%# Eval("ProductOption1.Product.ProductImages[0].Image.ImagePath") %>' alt="" width="70" class="rounded shadow-sm">
                                <div class="ml-3" style="width: 350px;">
                                    <h5 class="mb-0" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ProductOption1.Product.ProductName") %>'></asp:Label>
                                    </h5>
                                    <span class="text-muted font-weight-normal font-italic d-block">Option: <%#Eval("ProductOption") %></span>
                                </div>
                                <strong>x <%#Eval("Quantity") %></strong>
                            </li>
                            <li class="d-flex justify-content-between py-3 border-bottom">
                                <strong class="text-muted">Subtotal </strong>
                                <strong>RM
                                    <asp:Label ID="LabelSubtotal" runat="server" Text='<%# ( float.Parse(Eval("ProductOption1.Product.ProductPrice").ToString()) * float.Parse(Eval("Quantity").ToString()) ).ToString("#,##0.00")%>'></asp:Label>
                                </strong>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                    <li class="d-flex justify-content-between py-3 border-bottom">
                        <strong class="text-muted">Total</strong>
                        <h5 class="font-weight-bold">RM
                            <asp:Label ID="LabelTotal" runat="server" Text=" "></asp:Label></h5>
                    </li>
                </ul>
                Please enter your address before proceeding to payment: 
                <asp:TextBox CssClass="form-control my-3" TextMode="MultiLine" ID="TextBoxAddress" runat="server" Style="max-width: 100%;"></asp:TextBox>
                <asp:RequiredFieldValidator Style="display: block;" ID="RequiredFieldValidator1" ControlToValidate="TextBoxAddress" Display="Dynamic" ForeColor="Red" runat="server" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                <br />
                <asp:LinkButton ID="LinkButtonGoPayment" runat="server" CssClass="btn btn-primary py-2 btn-block" OnClick="LinkButtonGoPayment_Click">Proceed to payment</asp:LinkButton>
            </div>
        </div>
    </div>
    <asp:LinqDataSource ID="LinqDataSourceCart" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="CartProducts" Where="CustomerID == @CustomerID">
        <WhereParameters>
            <asp:SessionParameter Name="CustomerID" SessionField="SignInID" Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
