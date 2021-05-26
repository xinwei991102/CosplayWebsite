<%@ Page Title="Customer Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerProfile.aspx.cs" Inherits="CosplayWebsite.CustomerProfile" %>

<%@ Register Assembly="Microsoft.AspNet.EntityDataSource" Namespace="Microsoft.AspNet.EntityDataSource" TagPrefix="ef" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!--Edit Profile Modal -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProfileModalTitle">Edit Profile</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <div class="ppgallery">
                        <img runat="server" class="img-thumbnail" id="profilePic" style="width: 100px; height: 100px;" src="#"/>
                    </div>
                    <label class="btn btn-secondary m-2">
                        <span class="fas fa-image mr-2"></span>Choose Profile Picture
                            <asp:FileUpload ID="FileUploadProfilePicture" runat="server" Style="display: none" />
                    </label>
                    <br />
                    <div class="form-group row m-2 text-left">
                        <label for="TextBoxName" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Name:</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="TextBoxName" placeholder="Max 50 characters" MaxLength="50" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="valGrpCusProfile" ControlToValidate="TextBoxName" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                    </div>
                    <br />
                </div>
                <div class="modal-footer">
                    <asp:Button ID="ButtonEditProfile" ValidationGroup="valGrpCusProfile" runat="server" CssClass="btn btn-primary m-2" Text="Save Changes" OnClick="ButtonEditProfile_Click"/>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!--Cosplayer Profile Card-->
    <div class="card bg-light shadow-sm">
        <div class="card-body text-center">
            <asp:Image ID="ImageCustomerProfilePicture" runat="server" CssClass="img-thumbnail" style="width: 200px; height: 200px;"/>
            <h5 class="card-title">@<asp:Label ID="LabelCustomerID" runat="server" Text="Customer ID"></asp:Label></h5>
            <h6>
                <asp:Label ID="LabelCustomerName" runat="server" Text="Customer name"></asp:Label></h6>
            <asp:LinkButton ID="LinkButtonPurchaseHistory" class="btn btn-primary my-1" runat="server" PostBackUrl="~/PurchaseHistory.aspx">
                Purchase History
            </asp:LinkButton>
            <button type="button" class="btn btn-primary my-1" data-toggle="modal" data-target="#editProfileModal" style="width: 160px;">
                <span class="fas fa-user-edit mr-2"></span>Edit Profile
            </button>
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
                imagesPreview(this, 'div.ppgallery');
            });
        });
    </script>

</asp:Content>
