using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class CustomerProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Customer"))
                {
                    DataClasses1DataContext db = new DataClasses1DataContext();
                    Customer customer = db.Customers.FirstOrDefault(x => x.CustomerID.Equals(Session["SignInID"]));
                    
                    //Set navigation to active
                    LinkButton control = this.Master.FindControl("profileDropDown") as LinkButton;
                    control.CssClass = "dropdown-item active";

                    //Set customer details
                    LabelCustomerID.Text = customer.CustomerID;
                    LabelCustomerName.Text = customer.CustomerName;
                    TextBoxName.Text = customer.CustomerName;
                    if (db.Images.FirstOrDefault(x => x.ImageID == customer.CustomerProfilePic) != null)
                    {
                        ImageCustomerProfilePicture.Attributes["src"] = db.Images.FirstOrDefault(x => x.ImageID == customer.CustomerProfilePic).ImagePath;
                        profilePic.Src = db.Images.FirstOrDefault(x => x.ImageID == customer.CustomerProfilePic).ImagePath;
                    } else
                    {
                        ImageCustomerProfilePicture.Attributes["src"] = "https://via.placeholder.com/100";
                        profilePic.Src = "https://via.placeholder.com/100";
                    }
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void FormViewEditProfile_UpdateItem(int id)
        {

        }

        protected void ButtonEditProfile_Click(object sender, EventArgs e)
        {
            //Using ado.net entities
            Models.CosplayHubDBEntities db = new Models.CosplayHubDBEntities();
            List<Models.CustomerModel> customerModels = db.CustomerModels.ToList();
            Models.CustomerModel customer = new Models.CustomerModel();
            foreach (Models.CustomerModel customerModel in customerModels)
            {
                if (customerModel.CustomerID.Equals(Session["SignInID"]))
                {
                    customer = customerModel;
                }
            }
            if (TextBoxName.Text!= null && !TextBoxName.Text.Equals(""))
            {
                customer.CustomerName = TextBoxName.Text;
            }
            db.SaveChanges();

            if (FileUploadProfilePicture.HasFile && (
                      FileUploadProfilePicture.PostedFile.ContentType == "image/jpeg" ||
                      FileUploadProfilePicture.PostedFile.ContentType == "image/png"))
            {
                DataClasses1DataContext db1 = new DataClasses1DataContext();
                // add new image to database
                var file = FileUploadProfilePicture.PostedFile;

                Image image = new Image();
                db1.Images.InsertOnSubmit(image);
                db1.SubmitChanges();

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
                Image oldImage = db1.Images.FirstOrDefault(x => x.ImageID == customer.CustomerProfilePic);

                if (oldImage!= null)
                {
                    //get directory of image file
                    string projectDirectory = AppDomain.CurrentDomain.BaseDirectory;
                    string imagePath = projectDirectory + oldImage.ImagePath;

                    //deleting
                    File.Delete(imagePath);
                    db1.Images.DeleteOnSubmit(oldImage);
                }
                
                //set new image
                customer.CustomerProfilePic = image.ImageID;
                db.SaveChanges();
                db1.SubmitChanges();
            }

            Response.Redirect("CustomerProfile.aspx");
        }
    }
}