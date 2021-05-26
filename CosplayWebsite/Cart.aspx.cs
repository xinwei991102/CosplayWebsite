using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Customer"))
            {
                if (!IsPostBack)
                {
                    //Set navigation to active
                    LinkButton control = this.Master.FindControl("LinkBtnCart") as LinkButton;
                    control.CssClass = "nav-link active";
                    
                }

                updateTotal();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }


        }

        private void updateTotal()
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            List<CartProduct> cartProducts = db.CartProducts.Where(x => x.CustomerID.Equals(Session["SignInID"])).ToList();

            if (cartProducts.Count == 0)
            {
                PanelFooter.Visible = false;
                LabelEmpty.Visible = true;
            }
            else
            {
                float totalPrice = 0;
                for (int i = 0; i < cartProducts.Count; i++)
                {
                    totalPrice += (float)cartProducts[i].Quantity * (float)cartProducts[i].ProductOption1.Product.ProductPrice;
                }
                LabelTotalPrice.Text = totalPrice + "";
            }
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            string prodID = ((LinkButton)sender).Attributes["prodID"];
            string prodOption = ((LinkButton)sender).Attributes["prodOption"];
            DataClasses1DataContext db = new DataClasses1DataContext();
            CartProduct cartProduct = db.CartProducts.FirstOrDefault(x => x.ProductID.ToString().Equals(prodID) && x.ProductOption.ToString().Equals(prodOption) 
                && Session["SignInID"].ToString().Equals(x.CustomerID));
            db.CartProducts.DeleteOnSubmit(cartProduct);
            db.SubmitChanges();
            Response.Redirect("Cart.aspx");
        }

        protected void quantity_TextChanged(object sender, EventArgs e)
        {
            TextBox textBox = sender as TextBox;

            if (textBox != null)
            {
                var item = (RepeaterItem)textBox.NamingContainer;
                if (item != null)
                {
                    TextBox textBoxQty = (TextBox)item.FindControl("TextBoxQty");
                    int quantity = int.Parse(textBoxQty.Text);
                    int prodID = int.Parse(textBoxQty.Attributes["prodID"]);
                    string prodOption = textBoxQty.Attributes["prodOpt"];
                    DataClasses1DataContext db = new DataClasses1DataContext();
                    CartProduct cartProduct = db.CartProducts.FirstOrDefault(x => x.ProductID.ToString().Equals(prodID) && x.ProductOption.ToString().Equals(prodOption) &&
                        Session["SignInID"].ToString().Equals(x.CustomerID));
                    if (quantity >= cartProduct.ProductOption1.StockNo)
                    {
                        textBoxQty.Text = cartProduct.ProductOption1.StockNo + "";
                        quantity = (int)cartProduct.ProductOption1.StockNo;

                    }
                    cartProduct.Quantity = quantity;
                    db.SubmitChanges();
                    LinqDataSourceCart.TableName = "CartProducts";
                    RepeaterCart.DataBind();
                    updateTotal();
                }
            }
        }

        protected void RepeaterCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            CompareValidator compareValidator = (CompareValidator)e.Item.FindControl("CompareValidatorQty");
            TextBox textBoxQty = (TextBox)e.Item.FindControl("TextBoxQty");
            int prodId = int.Parse(textBoxQty.Attributes["prodID"]);
            string prodOption = textBoxQty.Attributes["prodOpt"];
            ProductOption productOption = db.ProductOptions.FirstOrDefault(x => x.ProductID == prodId && x.ProductOption1.Equals(prodOption));
            if (productOption.StockNo == 0)
            {
                compareValidator.ErrorMessage = "Item is out of stock. Please remove from cart before checkout.";
            } else
            {
                compareValidator.ErrorMessage = "Must enter positive integers.";
            }
        }
    }
}