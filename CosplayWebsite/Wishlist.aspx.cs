using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class Wishlist1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Set navigation to active
            LinkButton control = this.Master.FindControl("wishListDropDown") as LinkButton;
            control.CssClass = "dropdown-item active";

            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Customer"))
            {
                
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string prodID = ((LinkButton)sender).Attributes["prodID"].ToString();
            DataClasses1DataContext db = new DataClasses1DataContext();
            Wishlist wishlist = db.Wishlists.FirstOrDefault(x => x.ProductID.ToString() == prodID && x.CustomerID == Session["SignInID"].ToString());
            db.Wishlists.DeleteOnSubmit(wishlist);
            db.SubmitChanges();
            Response.Redirect("Wishlist.aspx");
        }
    }
}