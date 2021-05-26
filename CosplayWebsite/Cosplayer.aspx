<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cosplayer.aspx.cs" Inherits="CosplayWebsite.Cosplayer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">

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
                            <img runat="server" class="img-thumbnail" id="profilePic" style="width: 100px; height: 100px;" src="#" />
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
                            <asp:RequiredFieldValidator ID="ReqCosName" ControlToValidate="TextBoxName" ValidationGroup="valGrpCosProfile" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group row m-2 text-left">
                            <label for="TextBoxCosplayerDescription" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Description:</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="TextBoxCosplayerDesc" TextMode="MultiLine" placeholder="Max 200 characters" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="ReqCosDesc" ValidationGroup="valGrpCosProfile" ControlToValidate="TextBoxCosplayerDesc" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="ButtonEditProfile" ValidationGroup="valGrpCosProfile" runat="server" CssClass="btn btn-primary m-2" Text="Save Changes" OnClick="ButtonEditProfile_Click" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!--Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalTitle">Add New Product</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center px-5">
                        <div class="gallery">
                            <img class="img-thumbnail" id="placeholderImage" style="width: 100px; height: 100px;" src="https://via.placeholder.com/100" />
                        </div>
                        <label class="btn btn-secondary m-2">
                            <span class="fas fa-image mr-2"></span>Choose Product Images
                            <asp:FileUpload ID="FileUploadProductImage" runat="server" Style="display: none" AllowMultiple="true" />
                        </label>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="valGrpProductUpload" CssClass="text-danger" runat="server" ID="reqProdImage" ControlToValidate="FileUploadProductImage" Display="Dynamic" ForeColor="Red" ErrorMessage="Please upload at least one product image!" />
                        <br />
                        <div class="form-group row m-2 text-left">
                            <label for="TextBoxProductName" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Product Name:</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="TextBoxProductName" placeholder="Max 100 characters" MaxLength="100" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ValidationGroup="valGrpProductUpload" ID="ReqProdName" ControlToValidate="TextBoxProductName" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group row m-2 text-left">
                            <label for="TextBoxDescription" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Product Description:</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="TextBoxDescription" TextMode="MultiLine" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ValidationGroup="valGrpProductUpload" ID="ReqProdDesc" ControlToValidate="TextBoxDescription" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group row m-2 text-left">
                            <label for="TextBoxSourceMaterial" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Source Material:</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="TextBoxSourceMaterial" placeholder="Max 100 characters" MaxLength="100" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ValidationGroup="valGrpProductUpload" ControlToValidate="TextBoxSourceMaterial" ID="ReqProdSourceMat" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group row m-2 text-left">
                            <label for="TextBoxPrice" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Price:</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="TextBoxPrice" runat="server" CssClass="form-control" Type="number" step="0.01" max="9999" min="1" value="1"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ValidationGroup="valGrpProductUpload" ControlToValidate="TextBoxPrice" ID="ReqProdPrice" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ValidationGroup="valGrpProductUpload" ControlToValidate="TextBoxPrice" ID="RangeProdPrice" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter price between 1 to 9999" Type="Double" MinimumValue="1" MaximumValue="9999"></asp:RangeValidator>
                        </div>
                        <div class="form-group row m-2 text-left">
                            <label for="DropDownListProductType" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Product Type:</label>
                            <div class="col-sm-8">
                                <asp:DropDownList ID="DropDownListProductType" runat="server" CssClass="form-control"
                                    DataSourceID="LinqDataSource2"
                                    DataTextField="ProductTypeDesc"
                                    DataValueField="ProductTypeID">
                                </asp:DropDownList>
                            </div>
                            <asp:RequiredFieldValidator ValidationGroup="valGrpProductUpload" ControlToValidate="DropDownListProductType" ID="ReqProdType" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                        </div>

                        <br />

                    </div>
                    <div class="modal-footer">
                        <asp:Button ValidationGroup="valGrpProductUpload" ID="ButtonFileUpload" runat="server" OnClick="btnFileUpload_Click" CssClass="btn btn-primary m-2" Text="Upload New Product" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="row">

            <div class="col-lg-auto">
                <!--Cosplayer Profile Card-->
                <div class="card bg-light shadow-sm" style="width: 12.5rem;">
                    <asp:Image ID="ImageCosplayerProfilePicture" runat="server" CssClass="card-img-top img-thumbnail" />
                    <div class="card-body">
                        <h5 class="card-title">@<asp:Label ID="LabelCosplayerID" runat="server" Text="Cosplayer ID"></asp:Label></h5>
                        <h6>
                            <asp:Label ID="LabelCosplayerName" runat="server" Text="Cosplayer name"></asp:Label></h6>
                        <p class="card-text">
                            <asp:Label ID="LabelCosplayerDesc" runat="server" Text="Cosplayer description"></asp:Label>
                        </p>
                        <button type="button" class="btn btn-primary my-1" data-toggle="modal" data-target="#editProfileModal" style="width: 160px;">
                            <span class="fas fa-user-edit mr-2"></span>Edit Profile
                        </button>
                        <button type="button" class="btn btn-primary my-1" data-toggle="modal" data-target="#addProductModal" style="width: 160px;">
                            <span class="fas fa-plus mr-2"></span>New Product
                        </button>
                        <asp:LinkButton runat="server" CssClass="btn btn-primary my-1" href="ManageOrders.aspx" Style="display: inline-block; width: 160px;">
                            <span class="fas fa-clipboard mr-2"></span>Manage Orders
                        </asp:LinkButton>
                    </div>
                </div>
            </div>



            <div class="col-lg">
                <!--Products Gallery-->
                <h1 class="display-4">My Gallery</h1>
                <hr />
                <asp:Repeater ID="RepeaterProducts" runat="server" OnItemDataBound="RepeaterProducts_ItemDataBound" DataSourceID="LinqDataSource1">
                    <ItemTemplate>

                        <%-- Edit Product Modal --%>
                        <div class="modal fade" id="manageProductModal<%# Eval("ProductID") %>" tabindex="-1" role="dialog" aria-labelledby="addProductModalTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editProductModalTitle">Edit Product</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                            <div class="modal-body text-center px-5">
                                                <div>
                                                    <img class="img-thumbnail" id="placeholderImage" style="max-width: 100px; max-height: 100px;" src='<%# Eval("ProductImages[0].Image.ImagePath") %>' />
                                                </div>
                                                <br />

                                                <div class="form-group row m-2 text-left">
                                                    <label for="TextBoxProductName" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Product Name:</label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="TextBoxProductName" placeholder="Max 100 characters" MaxLength="100" runat="server" CssClass="form-control" Text='<%# Bind("ProductName") %>'></asp:TextBox>
                                                    </div>
                                                    <asp:RequiredFieldValidator ValidationGroup="valGrpManageProduct" ID="ReqProdName" ControlToValidate="TextBoxProductName" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group row m-2 text-left">
                                                    <label for="TextBoxDescription" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Product Description:</label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="TextBoxDescription" TextMode="MultiLine" runat="server" CssClass="form-control" Text='<%# Bind("ProductDescription") %>'></asp:TextBox>
                                                    </div>
                                                    <asp:RequiredFieldValidator ValidationGroup="valGrpManageProduct" ID="ReqProdDesc" ControlToValidate="TextBoxDescription" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group row m-2 text-left">
                                                    <label for="TextBoxSourceMaterial" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Source Material:</label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="TextBoxSourceMaterial" placeholder="Max 100 characters" MaxLength="100" runat="server" CssClass="form-control" Text='<%# Bind("ProductSourceMaterial") %>'></asp:TextBox>
                                                    </div>
                                                    <asp:RequiredFieldValidator ValidationGroup="valGrpManageProduct" ControlToValidate="TextBoxSourceMaterial" ID="ReqProdSourceMat" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group row m-2 text-left">
                                                    <label for="TextBoxPrice" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Price (RM):</label>
                                                    <div class="col-sm-8">
                                                        <asp:TextBox ID="TextBoxPrice" Enabled="false" runat="server" CssClass="form-control" Type="number" step="0.01" max="9999" min="1" value="1" Text='<%# Bind("ProductPrice") %>'></asp:TextBox>
                                                    </div>
                                                    <asp:RequiredFieldValidator ValidationGroup="valGrpManageProduct" ControlToValidate="TextBoxPrice" ID="ReqProdPrice" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                                                    <asp:RangeValidator ValidationGroup="valGrpManageProduct" ControlToValidate="TextBoxPrice" ID="RangeProdPrice" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter price between 1 to 9999" Type="Double" MinimumValue="1" MaximumValue="9999"></asp:RangeValidator>
                                                </div>
                                                <div class="form-group row m-2 text-left">
                                                    <label for="ddlProductType" class="col-sm-4 col-form-label" style="padding-left: 0px; padding-right: 0px;">Product Type:</label>
                                                    <div class="col-sm-8">
                                                        <asp:DropDownList ID="ddlProductType" runat="server" CssClass="form-control"
                                                            DataSourceID="LinqDataSource2"
                                                            DataTextField="ProductTypeDesc"
                                                            DataValueField="ProductTypeID"
                                                            SelectedValue='<%# Bind("ProductType") %>'>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <asp:RequiredFieldValidator ValidationGroup="valGrpManageProduct" ControlToValidate="ddlProductType" ID="ReqProdType" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="This field is required!"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button ValidationGroup="valGrpManageProduct" ID="ButtonManageStock" runat="server" CssClass="btn btn-primary m-2" Text="Manage Stocks" OnClick="ButtonManageStock_Click" />
                                                <asp:LinkButton ID="LinkButtonUpdateProduct" CssClass="btn btn-primary" runat="server" ValidationGroup="valGrpManageProduct" CausesValidation="True" Text="Update" OnClick="ButtonUpdateProduct_Click"/>
                                                <button  data-dismiss="modal" class="btn btn-secondary">Cancel</button>
                                                <%--<asp:LinkButton ID="LinkButton2" CssClass="btn btn-secondary" runat="server" CausesValidation="False" Text="Cancel" />--%>
                                            </div>
                                </div>
                            </div>
                        </div>

                        <%-- Product card --%>
                        <div class="card m-2 shadow-sm align-top" style="width: 12rem; display: inline-block;">
                            <asp:Panel ID="Panel1" runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem, "ProductName") %>'>
                                <asp:Image ID="ImageProductImage" runat="server" CssClass="card-img-top" src='<%# DataBinder.Eval(Container.DataItem, "ProductImages[0].Image.ImagePath") %>' Style="max-height: 190px; max-width: 190px; width: initial;" />
                                <div class="card-body">
                                    <a href="ViewProduct.aspx?id=<%# Eval("ProductID") %>" class="text-dark">
                                    <h6 style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        <asp:Label CssClass="card-title" ID="LabelProdName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ProductName") %>'></asp:Label>
                                    </h6></a>
                                    RM
                                    <asp:Label ID="LabelPrice" runat="server" Text='<%#float.Parse(DataBinder.Eval(Container.DataItem, "ProductPrice").ToString()).ToString("#,##0.00") %>'></asp:Label>
                                    <br />
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ProductID") %>' />
                                    <div class="text-muted">
                                        <asp:Label ID="LabelStock" runat="server" Text='0'></asp:Label>
                                        in stock
                                    </div>
                                    <a href="#" onclick='getProductID(<%# DataBinder.Eval(Container.DataItem, "ProductID") %>)' data-toggle="modal" data-target="#manageProductModal<%# Eval("ProductID") %>">Edit Product</a>
                                </div>
                            </asp:Panel>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="Products" Where="CosplayerID == @CosplayerID" EnableUpdate="True">
                    <WhereParameters>
                        <asp:SessionParameter Name="CosplayerID" SessionField="SignInID" Type="String" />
                    </WhereParameters>
                </asp:LinqDataSource>
                <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="CosplayWebsite.DataClasses1DataContext" EntityTypeName="" TableName="ProductTypes">
                </asp:LinqDataSource>
            </div>
        </div>
    </div>
    <asp:TextBox ID="TextBoxProductID" runat="server" Style="display: none;"></asp:TextBox>
    <asp:HiddenField ID="HiddenFieldProductID" runat="server" />


    <script>
        $(function () {
            // Multiple images preview in browser
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

            $('#<%=FileUploadProductImage.ClientID%>').on('change', function () {
                imagesPreview(this, 'div.gallery');
            });
        });

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

        function getProductID(id) {
            document.getElementById("MainContent_TextBoxProductID").setAttribute("Text", id);
            document.getElementById("MainContent_HiddenFieldProductID").setAttribute("Value", id);
        }
    </script>


</asp:Content>
