using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class Cosplayer : System.Web.UI.Page
    {
        private bool refreshState;
        private bool isRefresh;

        protected override void LoadViewState(object savedState)
        {
            object[] AllStates = (object[])savedState;
            base.LoadViewState(AllStates[0]);
            refreshState = bool.Parse(AllStates[1].ToString());
            if (Session["ISREFRESH"] != null && !Session["ISREFRESH"].Equals(""))
                isRefresh = (refreshState == (bool)Session["ISREFRESH"]);
        }

        protected override object SaveViewState()
        {
            Session["ISREFRESH"] = refreshState;
            object[] AllStates = new object[3];
            AllStates[0] = base.SaveViewState();
            AllStates[1] = !(refreshState);
            return AllStates;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Cosplayer"))
                {
                    DataClasses1DataContext db = new DataClasses1DataContext();
                    Cosplayer cosplayer = db.Cosplayers.FirstOrDefault(x => x.CosplayerID.Equals(Session["SignInID"]));

                    TextBoxCosplayerDesc.Attributes["maxlength"] = "200";

                    //Set navigation to active
                    LinkButton control = this.Master.FindControl("profileDropDown") as LinkButton;
                    control.CssClass = "dropdown-item active";


                    //Set cosplayer details
                    LabelCosplayerID.Text = cosplayer.CosplayerID;
                    LabelCosplayerName.Text = cosplayer.CosplayerName;
                    TextBoxName.Text = cosplayer.CosplayerName;
                    LabelCosplayerDesc.Text = cosplayer.CosplayerDescription;
                    TextBoxCosplayerDesc.Text = cosplayer.CosplayerDescription;
                    ImageCosplayerProfilePicture.Attributes["src"] = db.Images.FirstOrDefault(x => x.ImageID == cosplayer.CosplayerProfilePic).ImagePath;
                    profilePic.Src = db.Images.FirstOrDefault(x => x.ImageID == cosplayer.CosplayerProfilePic).ImagePath;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }


        }

        protected void btnFileUpload_Click(object sender, EventArgs e)
        {
            if (isRefresh == false && Page.IsValid)
            {
                try
                {
                    //check if uploaded files fulfill requirements
                    if (FileUploadProductImage.HasFile
                        && FileUploadProductImage.PostedFiles.All(x => (x.ContentType == "image/jpeg" || x.ContentType == "image/png")))
                    {
                        DataClasses1DataContext db = new DataClasses1DataContext();

                        //add product to database Products table
                        Product newProduct = new Product();

                        newProduct.CosplayerID = Session["SignInID"].ToString();
                        newProduct.ProductName = TextBoxProductName.Text;
                        newProduct.ProductDescription = TextBoxDescription.Text;
                        newProduct.ProductSourceMaterial = TextBoxSourceMaterial.Text;
                        newProduct.ProductType = int.Parse(DropDownListProductType.SelectedValue);
                        newProduct.ProductPrice = float.Parse(TextBoxPrice.Text);

                        db.Products.InsertOnSubmit(newProduct);
                        db.SubmitChanges();

                        int fileNo = 0;
                        foreach (var file in FileUploadProductImage.PostedFiles)
                        {
                            fileNo++;

                            Image image = new Image();
                            db.Images.InsertOnSubmit(image);
                            db.SubmitChanges();

                            if (file.ContentType == "image/jpeg")
                            {
                                //Save the image in /Images folder with image id as file name
                                file.SaveAs(Server.MapPath("~/Images/") + image.ImageID + ".jpg");

                                //Save the image path in the database Images table
                                image.ImagePath = "/Images/" + image.ImageID + ".jpg";

                            }
                            else if (file.ContentType == "image/png")
                            {
                                //Save the image in /Images folder with image id as file name
                                file.SaveAs(Server.MapPath("~/Images/") + image.ImageID + ".png");

                                //Save the image path in the database Images table
                                image.ImagePath = "/Images/" + image.ImageID + ".png";
                            }

                            db.SubmitChanges();

                            //Save the image and corresponding product to database ProductImagesTable
                            ProductImage productImage = new ProductImage();
                            productImage.Product = newProduct;
                            productImage.Image = image;

                            db.ProductImages.InsertOnSubmit(productImage);
                            db.SubmitChanges();
                        }

                        //Clear controls
                        FileUploadProductImage.Attributes.Remove("PostedFiles");
                        TextBoxProductName.Text = null;
                        TextBoxDescription.Text = null;
                        TextBoxSourceMaterial.Text = null;
                        TextBoxPrice.Text = null;

                        //force refresh page after uploading
                        Response.Redirect(Request.RawUrl);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(GetType(), "invalidImageAlert", "alert('Please upload proper jpg or png images.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(GetType(), "exceptionAlert", "alert('Error in adding product." + ex.Message + "');", true);
                }
            }

        }

        protected void RepeaterProducts_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
         e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataClasses1DataContext db = new DataClasses1DataContext();

                Label labelStock = ((Label)e.Item.FindControl("LabelStock"));
                HiddenField hiddenField = ((HiddenField)e.Item.FindControl("HiddenField1"));
                int productID = int.Parse(hiddenField.Value.ToString());
                if (db.ProductOptions.FirstOrDefault(x => x.ProductID == productID) != null)
                {
                    labelStock.Text = db.ProductOptions.Where(x => x.ProductID == int.Parse(hiddenField.Value)).Sum(x => x.StockNo) + "";
                }
            }
        }

        protected void ButtonManageStock_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageStocks.aspx?id=" + HiddenFieldProductID.Value);
        }

        protected void ButtonUpdateProduct_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                RepeaterItem item = (sender as LinkButton).NamingContainer as RepeaterItem;

                string prodName = (item.FindControl("TextBoxProductName") as TextBox).Text;
                string prodDesc = (item.FindControl("TextBoxDescription") as TextBox).Text;
                string prodSourceMat = (item.FindControl("TextBoxSourceMaterial") as TextBox).Text;
                int prodType = int.Parse((item.FindControl("ddlProductType") as DropDownList).SelectedValue);

                DataClasses1DataContext db = new DataClasses1DataContext();
                Product prod = db.Products.FirstOrDefault(x => x.ProductID.ToString().Equals(HiddenFieldProductID.Value));
                prod.ProductName = prodName;
                prod.ProductDescription = prodDesc;
                prod.ProductSourceMaterial = prodSourceMat;
                prod.ProductType = prodType;

                db.SubmitChanges();
                Response.Redirect("Cosplayer.aspx");
            }
            
        }

        protected void FormViewEditProduct_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect("Cosplayer.aspx");
        }

        protected void ButtonEditProfile_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Cosplayer cosplayer = db.Cosplayers.FirstOrDefault(x => x.CosplayerID.Equals(Session["SignInID"]));

            if (TextBoxName.Text != null && !TextBoxName.Text.Equals(""))
            {
                cosplayer.CosplayerName = TextBoxName.Text;
                cosplayer.CosplayerDescription = TextBoxCosplayerDesc.Text;
                db.SubmitChanges();

            }

            if (FileUploadProfilePicture.HasFile && (
                      FileUploadProfilePicture.PostedFile.ContentType == "image/jpeg" ||
                      FileUploadProfilePicture.PostedFile.ContentType == "image/png"))
            {
                // add new image to database
                var file = FileUploadProfilePicture.PostedFile;

                Image image = new Image();
                db.Images.InsertOnSubmit(image);
                db.SubmitChanges();

                if (file.ContentType == "image/jpeg")
                {
                    //Save the image in /Images folder with image id as file name
                    file.SaveAs(Server.MapPath("~/Images/") + image.ImageID + ".jpg");

                    //Save the image path in the database Images table
                    image.ImagePath = "/Images/" + image.ImageID + ".jpg";

                }
                else if (file.ContentType == "image/png")
                {
                    //Save the image in /Images folder with image id as file name
                    file.SaveAs(Server.MapPath("~/Images/") + image.ImageID + ".png");

                    //Save the image path in the database Images table
                    image.ImagePath = "/Images/" + image.ImageID + ".png";
                }

                //delete old image/////////////////
                Image oldImage = db.Images.FirstOrDefault(x => x.ImageID == cosplayer.CosplayerProfilePic);

                //get directory of image file
                string projectDirectory = AppDomain.CurrentDomain.BaseDirectory;
                string imagePath = projectDirectory + oldImage.ImagePath;

                //deleting
                File.Delete(imagePath);
                db.Images.DeleteOnSubmit(oldImage);

                //set new image
                cosplayer.CosplayerProfilePic = image.ImageID;
                db.SubmitChanges();
            }

            Response.Redirect("Cosplayer.aspx");
        }
       
    }
}