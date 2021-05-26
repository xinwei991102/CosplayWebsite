using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class PurchaseHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Customer"))
            {

            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            
        }
    }
}