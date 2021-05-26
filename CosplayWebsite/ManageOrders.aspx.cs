using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class ManageOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Set navigation to active
                LinkButton control = this.Master.FindControl("manageOrdersDropDown") as LinkButton;
                control.CssClass = "dropdown-item active";
            }

        }
    }
}