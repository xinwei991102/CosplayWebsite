<%@ Page Title="Cosplayer Registration" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CosplayerRegister.aspx.cs" Inherits="CosplayWebsite.CosplayerRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="text-center mx-auto" style="max-width: 1000px;">
        <div class="container text-black py-3 text-center">
            <h1 class="display-4">Customer Registration</h1>
        </div>
        <div class="mt-2">
            <div class="gallery">
                <img runat="server" class="img-thumbnail" id="profilePic" style="width: 100px; height: 100px;" src="https://via.placeholder.com/100"/>
                    </div>
                    <label class="btn btn-secondary m-2">
                        <span class="fas fa-image mr-2"></span>Choose Profile Picture
                        <asp:FileUpload ID="FileUploadProfilePicture" runat="server" Style="display: none" />
                    </label>
                    <br />
        </div>
        <div class="form-group">
            <div class="row m-3 text-left">
                <div class="col-3 pr-0">
                    <asp:Label ID="Label_username" CssClass="col-form-label col-form-label-lg" runat="server" Text="*Username: "></asp:Label>
                </div>
                <div class="col-6">
                    <asp:TextBox Style="max-width: 100%;" ID="TextBox_username" CssClass="form-control form-control-lg" runat="server" placeholder="Enter Username"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TextBox_username" Display="Dynamic" ForeColor="Red" runat="server" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                  <asp:CustomValidator ID="CustomValidatorUsername" runat="server" ErrorMessage="Username taken!" Display="Dynamic"
                    ControlToValidate="TextBox_username" ForeColor="Red" OnServerValidate="CustomValidatorUsername_ServerValidate"></asp:CustomValidator>
            </div>
            <div class="row m-3 text-left">
                <div class="col-3 pr-0">
                    <asp:Label ID="Label_fullName" CssClass="col-form-label col-form-label-lg" runat="server" Text="*Full Name: "></asp:Label>
                </div>
                <div class="col-6">
                    <asp:TextBox Style="max-width: 100%;" ID="TextBox_fullName" CssClass="form-control form-control-lg" runat="server" placeholder="Enter Full Name"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="TextBox_fullName" Display="Dynamic" ForeColor="Red" runat="server" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>

            </div>
            <div class="row m-3 text-left">
                <div class="col-3 pr-0">
                    <asp:Label ID="Label_email" CssClass="col-form-label col-form-label-lg" runat="server" Text="*Email: "></asp:Label>
                </div>
                <div class="col-6">
                    <asp:TextBox Style="max-width: 100%;" ID="TextBox_email" CssClass="form-control form-control-lg" runat="server" TextMode="Email"  placeholder="Enter Email"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="TextBox_email" Display="Dynamic" ForeColor="Red" runat="server" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_email"
                    ForeColor="Red" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                    Display = "Dynamic" ErrorMessage = "Invalid email address!"/>
                <asp:CustomValidator ID="CustomValidatorEmail" runat="server" ErrorMessage="Email taken!" Display="Dynamic"
                    ControlToValidate="TextBox_email" ForeColor="Red" OnServerValidate="CustomValidatorEmail_ServerValidate"></asp:CustomValidator>
            </div>
            <div class="row m-3 text-left">
                <div class="col-3 pr-0">
                    <asp:Label ID="Label_password" CssClass="col-form-label col-form-label-lg" runat="server" Text="*Password: "></asp:Label>
                </div>
                <div class="col-6">
                    <asp:TextBox ID="TextBox_password" TextMode="Password" runat="server" Style="max-width: 100%;" Class="form-control form-control-lg" placeholder="Enter Password"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="TextBox_password" Display="Dynamic" ForeColor="Red" runat="server" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
            </div>
            <div class="row m-3 text-left">
                <div class="col-3 pr-0">
                    <asp:Label ID="Label_confirmPassword" CssClass="col-form-label col-form-label-lg" runat="server" Text="*Confirm Password: "></asp:Label>
                </div>
                <div class="col-6">
                    <asp:TextBox ID="TextBox_confirmPassword" TextMode="Password" runat="server" Style="max-width: 100%;" Class="form-control form-control-lg" placeholder="Re-enter password"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="TextBox_confirmPassword" Display="Dynamic" ForeColor="Red" runat="server" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Must match password!" Display="Dynamic" ForeColor="Red" ControlToValidate="TextBox_confirmPassword" 
                    ControlToCompare="TextBox_password" Type="String" Operator="Equal"></asp:CompareValidator>
            </div>
                <div class="row m-3 text-left">
                <div class="col-3 pr-0">
                    <asp:Label ID="Label_cosplayerDescription" CssClass="col-form-label col-form-label-lg" runat="server" Text="Cosplayer Description: "></asp:Label>
                </div>
                <div class="col-6">
                    <asp:TextBox Style="max-width: 100%;" ID="TextBox_cosplayerDescription" TextMode="MultiLine" CssClass="form-control form-control-lg" runat="server" placeholder="Introduce yourself"></asp:TextBox><br />
                </div>
            </div>
            <div>
                * marks required fields.<br />
                By signing up, you agree to Cosplay Hub's
                <asp:LinkButton ID="LinkButton_termOfUse" runat="server">Term of Use</asp:LinkButton>
                & 
                    <asp:LinkButton ID="LinkButton_privacyPolicy" runat="server">Privacy Policy</asp:LinkButton>.<br />
                <input type="reset" value="Reset" class="form-control btn btn-secondary m-3 btn-lg"/>
                <asp:Button ID="Button_register" CssClass="form-control btn btn-primary m-3 btn-lg" runat="server" Text="Sign up" OnClick="Button_register_Click" />
                <br />
            </div>
        </div>
    </div>


    <script>
        $(function () {
            // Images preview in browser
            var imagesPreview = function (input, placeToInsertImagePreview) {

                if (input.files) {
                    $(placeToInsertImagePreview).empty();
                    var filesAmount = input.files.length;

                    for (i = 0; i < filesAmount; i++) {
                        var reader = new FileReader();
                        reader.onload = function (event) {

                            $($.parseHTML('<img class="img-thumbnail" style="width: 100px; height: 100px;">')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
                        }
                        reader.readAsDataURL(input.files[i]);
                    }
                }
            };

            $('#<%=FileUploadProfilePicture.ClientID%>').on('change', function () {
                imagesPreview(this, 'div.gallery');
            });
        });
        
    </script>

</asp:Content>
