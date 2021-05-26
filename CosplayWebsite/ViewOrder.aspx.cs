using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class ViewOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Request.QueryString["id"]!=null)
            {
                if (!IsPostBack)
                {
                    DataClasses1DataContext db = new DataClasses1DataContext();
                    Order order = db.Orders.FirstOrDefault(x => x.OrderID.ToString().Equals(Request.QueryString["id"]));
                    if (order.CustomerID.Equals(Session["SignInID"]) && Session["SignInType"].Equals("Customer"))
                    {
                        setOrderDetails(order);
                    }
                    else if (order.CosplayerID.Equals(Session["SignInID"]) && Session["SignInType"].Equals("Cosplayer"))
                    {
                        setOrderDetails(order);
                        TextBoxTrackingNo.Text = order.TrackingNo;
                        PanelCosplayerOnly.Visible = true;
                        PanelEditOrderBtn.Visible = true;
                    }
                    else
                    {
                        Response.Redirect("Login.aspx");
                    }

                }

            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        private void setOrderDetails(Order order)
        {
            float totalPrice = (float)order.TotalPrice;
            LabelTotalPrice.Text = string.Format("{0:0.00}", totalPrice);
            LabelDate.Text = ((DateTime)order.OrderDate).ToShortDateString();
            LabelCosplayerID.Text = order.CosplayerID;
            LabelTrackingNo.Text = order.TrackingNo;
            LabelOrderStatus.Text = order.OrderStatus1.OrderStatusDescription;
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Request.QueryString["id"] != null)
            {
                DataClasses1DataContext db = new DataClasses1DataContext();
                Order order = db.Orders.FirstOrDefault(x => x.OrderID.ToString().Equals(Request.QueryString["id"]));
                if (order.CosplayerID.Equals(Session["SignInID"]) && Session["SignInType"].Equals("Cosplayer"))
                {
                    order.OrderStatus = int.Parse(DropDownListOrderStatus.SelectedValue);
                    order.TrackingNo = TextBoxTrackingNo.Text;
                    db.SubmitChanges();
                    Response.Redirect("ViewOrder.aspx?id=" + order.OrderID);
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }

            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void DropDownListOrderStatus_DataBound(object sender, EventArgs e)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Order order = db.Orders.FirstOrDefault(x => x.OrderID.ToString().Equals(Request.QueryString["id"]));
            ((DropDownList)sender).SelectedValue = order.OrderStatus.ToString();
        }

        protected void ButtonBack_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Order order = db.Orders.FirstOrDefault(x => x.OrderID.ToString().Equals(Request.QueryString["id"]));

            if (order.CustomerID.Equals(Session["SignInID"]) && Session["SignInType"].Equals("Customer"))
            {
                Response.Redirect("PurchaseHistory.aspx");
            }
            else if (order.CosplayerID.Equals(Session["SignInID"]) && Session["SignInType"].Equals("Cosplayer"))
            {
                Response.Redirect("ManageOrders.aspx");
            }
        }
    }
}