using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class ViewProduct : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            bindData();
        }

        private void bindData()
        {
            int id = int.Parse(Request.QueryString["id"].ToString());

            DataClasses1DataContext db = new DataClasses1DataContext();
            Product product = db.Products.FirstOrDefault(x => x.ProductID == id);

            Session["ProductType"] = product.ProductType;
            productType.Value = product.ProductType.ToString();

            string prodOpt = ddlOption.SelectedValue.ToString();
            ProductOption productOption;
            CartProduct cartProduct;

            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Customer"))
            {
                if (prodOpt.Equals(""))
                {
                    productOption = db.ProductOptions.FirstOrDefault(x => x.ProductID == id);
                    cartProduct = db.CartProducts.FirstOrDefault(x => x.CustomerID.Equals(Session["SignInID"]) &&
                        x.ProductID == id && x.ProductOption == productOption.ProductOption1);

                }
                else
                {
                    productOption = db.ProductOptions.FirstOrDefault(x => x.ProductID == id && x.ProductOption1.Equals(prodOpt));
                    cartProduct = db.CartProducts.FirstOrDefault(x => x.CustomerID.Equals(Session["SignInID"]) &&
                        x.ProductID == id && x.ProductOption == prodOpt);

                }
                if (productOption.StockNo > 0)
                {
                    //already added to cart before
                    if (cartProduct != null)
                    {
                        RangeValidatorQty.MaximumValue = (productOption.StockNo - cartProduct.Quantity).ToString();
                        lblStock.Text = RangeValidatorQty.MaximumValue + " available";
                    }
                    else
                    {
                        RangeValidatorQty.MaximumValue = product.ProductOptions[0].StockNo.ToString();
                        lblStock.Text = RangeValidatorQty.MaximumValue + " available";
                    }
                }
                else
                {
                    RangeValidatorQty.MaximumValue = "0";
                    lblStock.Text = RangeValidatorQty.MaximumValue + " available";
                }

            }
            else
            {
                RangeValidatorQty.MaximumValue = product.ProductOptions[0].StockNo.ToString();
                lblStock.Text = RangeValidatorQty.MaximumValue + " available";
            }

            ppname.Text = product.ProductName;
            CosplayerLink.InnerHtml = product.Cosplayer.CosplayerName;
            CosplayerLink.HRef = "ViewCosplayerGallery.aspx?id=" + product.CosplayerID;
            pprice.Text = "RM " + float.Parse(product.ProductPrice.ToString()).ToString("#,##0.00");
            ppdesc.Text = product.ProductDescription;
            LabelSourceMaterial.Text = product.ProductSourceMaterial;
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            //Add to cart
            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Customer"))
            {
                DataClasses1DataContext db = new DataClasses1DataContext();
                CartProduct newCartProduct = new CartProduct();

                newCartProduct.CustomerID = Session["SignInID"].ToString();
                newCartProduct.ProductID = int.Parse(Request.QueryString["id"].ToString());
                newCartProduct.ProductOption = ddlOption.SelectedValue.ToString();
                newCartProduct.Quantity = int.Parse(qty.Text);

                CartProduct cartProduct = db.CartProducts.FirstOrDefault(x => x.CustomerID.Equals(Session["SignInID"]) &&
                    x.ProductID == newCartProduct.ProductID && x.ProductOption == newCartProduct.ProductOption);
                
                
                if (newCartProduct.Quantity > 0)
                {
                    //already added to cart before, so increase quantity in cart only
                    if (cartProduct != null)
                    {
                        cartProduct.Quantity += newCartProduct.Quantity;
                        if (cartProduct.Quantity <= cartProduct.ProductOption1.StockNo)
                        {
                            db.SubmitChanges();
                            ClientScript.RegisterStartupScript(GetType(), "addToCart", "alert('Item added to cart successfully.');", true);
                            bindData();
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(GetType(), "addToCart", "alert('Not enough stock. Please enter a smaller quantity.');", true);
                        }


                    }
                    else if (newCartProduct.Quantity > 0) //havent add to cart before, only add if selected quantity is > 0
                    {
                        db.CartProducts.InsertOnSubmit(newCartProduct);
                        db.SubmitChanges();
                        ClientScript.RegisterStartupScript(GetType(), "addToCart", "alert('Item added to cart successfully.');", true);
                        bindData();
                    }
                }
                
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }

        protected void btnAddToWishlist_Click(object sender, EventArgs e)
        {
            //Add to wishlist
            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Customer"))
            {
                DataClasses1DataContext db = new DataClasses1DataContext();
                Wishlist newWishlist = new Wishlist();

                newWishlist.CustomerID = Session["SignInID"].ToString();
                newWishlist.ProductID = int.Parse(Request.QueryString["id"].ToString());

                Wishlist wishlist = db.Wishlists.FirstOrDefault(x => x.CustomerID.Equals(Session["SignInID"]) && x.ProductID == newWishlist.ProductID);

                if (wishlist != null)
                {
                    ClientScript.RegisterStartupScript(GetType(), "addedToCart", "alert('Item already exists in wishlist!');", true);
                }
                else
                {
                    db.Wishlists.InsertOnSubmit(newWishlist);
                    db.SubmitChanges();
                    ClientScript.RegisterStartupScript(GetType(), "addedToCart", "alert('Item added to wishlist successfully.');", true);
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void ddlOption_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = int.Parse(Request.QueryString["id"].ToString());
            DataClasses1DataContext db = new DataClasses1DataContext();
            ProductOption productOption = db.ProductOptions.FirstOrDefault(x => x.ProductID == id && x.ProductOption1.Equals(ddlOption.SelectedValue));
            CartProduct cartProduct = null;
            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Customer"))
            {
                cartProduct = db.CartProducts.FirstOrDefault(x => x.CustomerID.Equals(Session["SignInID"]) &&
                        x.ProductID == id && x.ProductOption == productOption.ProductOption1);
            }
            if (productOption.StockNo > 0)
            {
                //already added to cart before
                if (cartProduct != null)
                {
                    RangeValidatorQty.MaximumValue = (productOption.StockNo - cartProduct.Quantity).ToString();
                    lblStock.Text = RangeValidatorQty.MaximumValue + " available";
                }
                else
                {
                    RangeValidatorQty.MaximumValue = productOption.StockNo.ToString();
                    lblStock.Text = RangeValidatorQty.MaximumValue + " available";
                }
            } else
            {
                RangeValidatorQty.MaximumValue = "0";
                lblStock.Text = RangeValidatorQty.MaximumValue + " available";
            }
            
        }

        protected void RepeaterSimilarProd_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Label labelStock = (Label)e.Item.FindControl("LabelStock");
            HiddenField hiddenField = (HiddenField)e.Item.FindControl("HiddenField1");
            int productID = int.Parse(hiddenField.Value.ToString());
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
                Product prod = db.Products.FirstOrDefault(x => x.ProductID == productID);
                if (prod.ProductName.ToUpper().Contains(search.ToUpper()) ||
                    prod.ProductSourceMaterial.ToUpper().Contains(search.ToUpper()) ||
                    prod.CosplayerID.ToUpper().Contains(search.ToUpper()))
                {

                }
                else
                {
                    e.Item.Visible = false;
                }
            }
        }
    }
}