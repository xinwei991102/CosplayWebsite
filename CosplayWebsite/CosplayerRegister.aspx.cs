using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class CosplayerRegister : System.Web.UI.Page
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

        }

        protected void Button_register_Click(object sender, EventArgs e)
        {
            if (isRefresh == false && Page.IsValid)
            {
                try
                {
                    DataClasses1DataContext db = new DataClasses1DataContext();

                    Cosplayer newCosplayer = new Cosplayer();
                    newCosplayer.CosplayerID = TextBox_username.Text;
                    newCosplayer.CosplayerName = TextBox_fullName.Text;
                    newCosplayer.CosplayerEmail = TextBox_email.Text;
                    newCosplayer.CosplayerDescription = TextBox_cosplayerDescription.Text;
                    newCosplayer.CosplayerPassword = TextBox_password.Text;


                    db.Cosplayers.InsertOnSubmit(newCosplayer);


                    //check if uploaded files fulfill requirements
                    if (FileUploadProfilePicture.HasFile
                        && (FileUploadProfilePicture.PostedFile.ContentType == "image/jpeg" ||
                        FileUploadProfilePicture.PostedFile.ContentType == "image/png"))
                    {
                        
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

                        newCosplayer.CosplayerProfilePic = image.ImageID;
                        db.SubmitChanges();
                        Response.Redirect("Login.aspx");

                    }
                    else if(FileUploadProfilePicture.HasFile && FileUploadProfilePicture.PostedFile.ContentType != "image/jpeg" &&
                        FileUploadProfilePicture.PostedFile.ContentType != "image/png")
                    {
                        ClientScript.RegisterStartupScript(GetType(), "invalidImageAlert", "alert('Please upload proper jpg or png images.');", true);
                    } else
                    {
                        db.SubmitChanges();
                        Response.Redirect("Login.aspx");
                    }
                    
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(GetType(), "exceptionAlert", "alert('Error in uploading images." + ex.Message + "');", true);
                }
            }
        }

        protected void CustomValidatorUsername_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            if (db.Cosplayers.FirstOrDefault(x => x.CosplayerID.Equals(args.Value.ToString())) == null)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void CustomValidatorEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            if (db.Cosplayers.FirstOrDefault(x => x.CosplayerEmail.Equals(args.Value.ToString())) == null)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

    }
}