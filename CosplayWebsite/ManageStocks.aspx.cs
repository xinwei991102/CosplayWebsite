using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class ManageStocks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Product prod = db.Products.FirstOrDefault(x => x.ProductID.ToString() == Request.QueryString["id"]);
            if (Session["SignInID"].Equals(prod.CosplayerID))
            {
                LabelProductName.Text = prod.ProductName;

            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }

        protected void FormViewInsertProductOption_ItemCreated(object sender, EventArgs e)
        {


        }

        protected void FormViewInsertProductOption_DataBound(object sender, EventArgs e)
        {
            if (FormViewInsertProductOption.CurrentMode == FormViewMode.Insert)
            {
                TextBox prodID = (TextBox)FormViewInsertProductOption.FindControl("ProductIDTextBox");
                if (prodID != null)
                {
                    prodID.Text = Request.QueryString["id"];
                }
            }
        }

        protected void FormViewInsertProductOption_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {

            GridViewProductOptions.DataSourceID = "LinqDataSourceProdOptions";
            GridViewProductOptions.DataBind();
        }
    }
}