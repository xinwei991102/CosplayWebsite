using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                
            }
            if (Session["SignInID"] == null || Session["SignInID"].Equals("")) //if no login found
            {
                LinkBtnSignOut.Visible = false;
                LinkBtnSignIn.Visible = true;
                profileNav.Visible = false;
                cartNav.Visible = false;
            }
            else //login found
            {
                LabelUsername.Text = Session["SignInID"].ToString();
                LinkBtnSignIn.Visible = false;
                LinkBtnSignOut.Visible = true;
                profileNav.Visible = true;
                if (Session["SignInType"].Equals("Cosplayer"))
                {
                    manageOrdersDropDown.Visible = true;
                    wishListDropDown.Visible = false;
                    cartNav.Visible = false;
                } else if (Session["SignInType"].Equals("Customer"))
                {
                    manageOrdersDropDown.Visible = false;
                    wishListDropDown.Visible = true;
                    cartNav.Visible = true;
                }
            }
        }

        protected void LinkBtnSignIn_Click(object sender, EventArgs e)
        {
            SignIn();
        }

        protected void LinkBtnSignOut_Click(object sender, EventArgs e)
        {
            SignOut();
        }

        private void SignIn()
        {
            Response.Redirect("Login.aspx");

        }

        private void SignOut()
        {
            Session["SignInID"] = null;
            Session["SignInType"] = null;
            LinkBtnSignOut.Visible = false;
            LinkBtnSignIn.Visible = true;
            profileNav.Visible = false;
            Response.Redirect("Default.aspx");
            cartNav.Visible = false;
        }

        protected void LinkBtnProfile_Click(object sender, EventArgs e)
        {
            if (Session["SignInID"] != null && Session["SignInType"] != null)
            {
                if (Session["SignInType"].Equals("Cosplayer"))
                {
                    Response.Redirect("Cosplayer.aspx");
                } else if (Session["SignInType"].Equals("Customer"))
                {
                    Response.Redirect("CustomerProfile.aspx");
                }
          
            } else
            {
                SignOut();
            }
            
        }

        protected void manageOrdersDropDown_Click(object sender, EventArgs e)
        {
            if (Session["SignInID"] != null && Session["SignInType"] != null)
            {
                if (Session["SignInType"].Equals("Cosplayer"))
                {
                    Response.Redirect("ManageOrders.aspx");
                }
            }
            else
            {
                SignOut();
            }
        }

        protected void LinkBtnCart_Click(object sender, EventArgs e)
        {
            if (Session["SignInID"] != null && Session["SignInType"] != null)
            {
                if (Session["SignInType"].Equals("Customer"))
                {
                    Response.Redirect("Cart.aspx");
                }
            }
            else
            {
                SignOut();
            }
        }

        protected void wishListDropDown_Click(object sender, EventArgs e)
        {
            if (Session["SignInID"] != null && Session["SignInType"] != null)
            {
                if (Session["SignInType"].Equals("Customer"))
                {
                    Response.Redirect("wishlist.aspx");
                }
            }
            else
            {
                SignOut();
            }
        }

        protected void LinkButtonSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx?search=" + TextBoxSearch.Text);
        }
    }
}