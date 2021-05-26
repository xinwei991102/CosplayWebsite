using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class UserRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button_customerReg_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerRegister.aspx");
        }

        protected void Button_cosplayerReg_Click(object sender, EventArgs e)
        {
            Response.Redirect("CosplayerRegister.aspx");
        }
    }
}