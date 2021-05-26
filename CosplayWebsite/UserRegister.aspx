<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserRegister.aspx.cs" Inherits="CosplayWebsite.UserRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="text-center">
        <div class="container text-black py-3 text-center">
            <h1 class="display-4">Register New Account</h1>
        </div>
        <asp:Button ID="Button_customerReg" CssClass="btn btn-primary btn-lg m-3" runat="server" Text="Customer Registration" Style="width: 100%; display: inline-block;" OnClick="Button_customerReg_Click" />
        <br />
        <asp:Button ID="Button_cosplayerReg" CssClass="btn btn-primary btn-lg m-3" runat="server" Text="Cosplayer Registration" Style="width: 100%; display: inline-block;" OnClick="Button_cosplayerReg_Click" />

    </div>


</asp:Content>
