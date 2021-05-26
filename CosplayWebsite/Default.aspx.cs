using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class _Default : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["search"] != null)
            {
                LabelTitle.Text = "Search results for: " + Request.QueryString["search"];
            }
            

        }

        protected void LinqDataSourceProduct_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            e.Arguments.SortExpression = ddlSortBy.SelectedValue;
        }

        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            rptAllProduct.DataBind();
        }

        protected void rptAllProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Label labelStock = ((Label)e.Item.FindControl("LabelStock"));
            HiddenField hiddenField = ((HiddenField)e.Item.FindControl("HiddenField1"));

            int productID = int.Parse(hiddenField.Value.ToString());
            Product prod = db.Products.FirstOrDefault(x => x.ProductID == productID);

            if (db.ProductOptions.FirstOrDefault(x => x.ProductID == productID) != null)
            {
                labelStock.Text = db.ProductOptions.Where(x => x.ProductID == int.Parse(hiddenField.Value)).Sum(x => x.StockNo) + "";
            }
            if (int.Parse(labelStock.Text) < 1)
            {
                e.Item.Visible = false;
            }
            if (Request.QueryString["search"] != null)
            {
                string search = Request.QueryString["search"];
                
                if (prod.ProductName.ToUpper().Contains(search.ToUpper()) || 
                    prod.ProductSourceMaterial.ToUpper().Contains(search.ToUpper()) ||
                    prod.CosplayerID.ToUpper().Contains(search.ToUpper()) ||
                    prod.ProductDescription.ToUpper().Contains(search.ToUpper()))
                {

                } else
                {
                    e.Item.Visible = false;
                }
            }
            if(!ddlFilterBy.SelectedValue.ToString().Equals("All")
                && !prod.ProductType.ToString().Equals(ddlFilterBy.SelectedValue))
            {
                e.Item.Visible = false;
            }
        }

        protected void ddlFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Request.QueryString["search"] != null)
            {
                LabelTitle.Text = "Search results for: " + Request.QueryString["search"];
            }
            else if (ddlFilterBy.SelectedItem.ToString().Equals("Costume"))
            {
                LabelTitle.Text = "All Costumes";
            }
            else if (ddlFilterBy.SelectedItem.ToString().Equals("Figurine"))
            {
                LabelTitle.Text = "All Figurines";
            }
            else if (ddlFilterBy.SelectedItem.ToString().Equals("All"))
            {
                LabelTitle.Text = "All Products";
            }
            rptAllProduct.DataBind();
        }

        protected void ddlFilterBy_DataBound(object sender, EventArgs e)
        {
            ddlFilterBy.Items.Insert(0, new ListItem("All", "All"));
        }
    }
}