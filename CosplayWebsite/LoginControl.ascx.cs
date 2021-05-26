using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class LoginControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void LinkButton_signUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserRegister.aspx");
        }

        protected void ButtonCustomerLogin_Click(object sender, EventArgs e)
        {
            //DataClasses1DataContext db = new DataClasses1DataContext();
            //Customer customer = db.Customers.FirstOrDefault(x => x.CustomerID.Equals(TextBox_customerUsername.Text));

            //if (customer != null)
            //{
            //    if (customer.CustomerID.Equals(TextBox_customerUsername.Text) && customer.CustomerPassword.Equals(Password_customerPassword.Value))
            //    {
            //        Session["SignInID"] = TextBox_customerUsername.Text;
            //        Session["SignInType"] = "Customer";
            //        Response.Redirect("Default.aspx");
            //    }
            //}
            //else
            //{
            //    Response.Redirect("Login.aspx");
            //}
            if (Page.IsValid)
            {
                Session["SignInID"] = TextBox_customerUsername.Text;
                Session["SignInType"] = "Customer";
                Response.Redirect("Default.aspx");
            }
        }

        protected void ButtonCosplayerLogin_Click(object sender, EventArgs e)
        {
            //DataClasses1DataContext db = new DataClasses1DataContext();
            //Cosplayer cosplayer = db.Cosplayers.FirstOrDefault(x => x.CosplayerID.Equals(TextBox_cosplayerUsername.Text));

            //if (cosplayer != null)
            //{
            //    if (cosplayer.CosplayerID.Equals(TextBox_cosplayerUsername.Text) && cosplayer.CosplayerPassword.Equals(Password_cosplayerPassword.Value))
            //    {
            //        Session["SignInID"] = TextBox_cosplayerUsername.Text;
            //        Session["SignInType"] = "Cosplayer";
            //        Response.Redirect("Default.aspx");
            //    }

            //}
            //else
            //{
            //    Response.Redirect("Login.aspx");
            //}
            if (Page.IsValid)
            {
                Session["SignInID"] = TextBox_cosplayerUsername.Text;
                Session["SignInType"] = "Cosplayer";
                Response.Redirect("Default.aspx");
            }

        }

        protected void ButtonCustomerReset_Click(object sender, EventArgs e)
        {
            TextBox_customerUsername.Text = null;
            Password_customerPassword.Value = null;
        }

        protected void ButtonCosplayerReset_Click(object sender, EventArgs e)
        {
            TextBox_cosplayerUsername.Text = null;
            Password_cosplayerPassword.Value = null;
        }

        protected void CusCusPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Customer customer = db.Customers.FirstOrDefault(x => x.CustomerID.Equals(TextBox_customerUsername.Text));
            if (customer == null)
            {
                args.IsValid = false;
            }
            else
            {
                if (Password_customerPassword.Value.Equals(customer.CustomerPassword))
                {
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }
        }

        protected void CusCosPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Cosplayer cosplayer = db.Cosplayers.FirstOrDefault(x => x.CosplayerID.Equals(TextBox_cosplayerUsername.Text));
            if (cosplayer == null)
            {
                args.IsValid = false;
            }
            else
            {
                if (Password_cosplayerPassword.Value.Equals(cosplayer.CosplayerPassword))
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
}