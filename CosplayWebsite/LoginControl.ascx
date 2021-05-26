<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginControl.ascx.cs" Inherits="CosplayWebsite.LoginControl" %>
<div class="text-center mx-auto row">
    <div class="col p-0 m-3 shadow-sm" style="max-width: 35rem;">
        <div class="container text-black py-3 text-center">
            <h1 class="display-4">Customer Sign In</h1>
        </div>
        <div class="form-group mt-3">
            <div class="row mx-3 text-left">
                <div class="col-3">
                    <asp:Label ID="Label_customerUsername" CssClass="col-form-label col-form-label-lg" runat="server" Text="Username: "></asp:Label>
                </div>
                <div class="col">
                    <asp:TextBox Style="max-width: 100%;" ID="TextBox_customerUsername" CssClass="form-control form-control-lg" runat="server" placeholder="Enter Username"></asp:TextBox>
                </div>
            </div>
            <div class="row mx-3 text-right">
                <div class="col">
                    <asp:RequiredFieldValidator ID="ReqCusUsername" ControlToValidate="TextBox_customerUsername" ValidationGroup="valGrpCustomerLogin"
                        runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!" />
                </div>
            </div>
            <div class="row mx-3 mt-1 text-left">
                <div class="col-3">
                    <asp:Label ID="Label_customerPassword" CssClass="col-form-label col-form-label-lg" runat="server" Text="Password: "></asp:Label>
                </div>
                <div class="col">
                    <input id="Password_customerPassword" placeholder="Enter Password" type="password" runat="server" style="max-width: 100%;" class="form-control form-control-lg" />
                </div>
            </div>
            <div class="row mx-3 text-right">
                <div class="col">
                    <asp:RequiredFieldValidator ID="ReqCusPassword" ValidationGroup="valGrpCustomerLogin" runat="server" Display="Dynamic" ForeColor="Red"
                        ErrorMessage="This field is required!" ControlToValidate="Password_customerPassword" />
                    <asp:CustomValidator ID="CusCusPassword" runat="server" ValidationGroup="valGrpCustomerLogin" OnServerValidate="CusCusPassword_ServerValidate" Display="Dynamic"
                        ForeColor="Red" ErrorMessage="Incorrect password or username" ControlToValidate="Password_customerPassword" />
                </div>
            </div>
            <div class="row mt-4 mx-3 mb-4 text-left">
                <div class="col">
                    <asp:Button ID="ButtonCustomerReset" CssClass="form-control btn btn-secondary btn-lg" runat="server" Text="Reset" OnClick="ButtonCustomerReset_Click" />
                </div>
                <div class="col">
                    <asp:Button ID="ButtonCustomerLogin" ValidationGroup="valGrpCustomerLogin" CssClass="form-control btn btn-primary btn-lg" runat="server" Text="Sign in" OnClick="ButtonCustomerLogin_Click" />
                </div>
            </div>
        </div>
    </div>
    <div class="col p-0 m-3 shadow-sm" style="max-width: 35rem;">
        <div class="container text-black py-3 text-center">
            <h1 class="display-4">Cosplayer Sign In</h1>
        </div>
        <div class="form-group mt-3">
            <div class="row mx-3 text-left">
                <div class="col-3">
                    <asp:Label ID="Label1" CssClass="col-form-label col-form-label-lg" runat="server" Text="Username: "></asp:Label>
                </div>
                <div class="col">
                    <asp:TextBox Style="max-width: 100%;" ID="TextBox_cosplayerUsername" CssClass="form-control form-control-lg" runat="server" placeholder="Enter Username"></asp:TextBox>
                </div>
            </div>
            <div class="row mx-3 text-right">
                <div class="col">
                    <asp:RequiredFieldValidator ValidationGroup="valGrpCosplayerLogin" ControlToValidate="TextBox_cosplayerUsername" ID="ReqCosUsername"
                        runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!" />
                </div>
            </div>
            <div class="row mx-3 mt-1 text-left">
                <div class="col-3">
                    <asp:Label ID="Label2" CssClass="col-form-label col-form-label-lg" runat="server" Text="Password: "></asp:Label>
                </div>
                <div class="col">
                    <input id="Password_cosplayerPassword" placeholder="Enter Password" type="password" runat="server" style="max-width: 100%;" class="form-control form-control-lg" />
                </div>
            </div>
            <div class="row mx-3 text-right">
                <div class="col">
                    <asp:RequiredFieldValidator ValidationGroup="valGrpCosplayerLogin" ControlToValidate="Password_cosplayerPassword" ID="ReqCosPassword" runat="server"
                        Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!" />
                    <asp:CustomValidator ValidationGroup="valGrpCosplayerLogin" ControlToValidate="Password_cosplayerPassword" OnServerValidate="CusCosPassword_ServerValidate"
                        ID="CusCosPassword" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="Incorrect password or username" />
                </div>
            </div>
            <div class="row mt-4 mx-3 mb-4 text-left">
                <div class="col">
                    <asp:Button ID="ButtonCosplayerReset" CssClass="form-control btn btn-secondary btn-lg" runat="server" Text="Reset" OnClick="ButtonCosplayerReset_Click" />
                </div>
                <div class="col">
                    <asp:Button ID="ButtonCosplayerLogin" ValidationGroup="valGrpCosplayerLogin" CssClass="form-control btn btn-primary btn-lg" runat="server" Text="Sign in" OnClick="ButtonCosplayerLogin_Click" />
                </div>
            </div>
        </div>
    </div>


</div>
<div class="mx-auto row text-center">
    <div class="col">
        <asp:LinkButton ID="LinkButton1" runat="server">Forget Password?</asp:LinkButton><br />
        <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton_signUp_Click">Not a CosplayHub member? Register here</asp:LinkButton><br />
    </div>

</div>
