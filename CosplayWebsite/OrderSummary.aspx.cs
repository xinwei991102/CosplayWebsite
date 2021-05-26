using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CosplayWebsite
{
    public partial class OrderSummary : System.Web.UI.Page
    {
        float total;
        protected void Page_Load(object sender, EventArgs e)
        {
            TextBoxAddress.Attributes["maxlength"] = "1000";
            if (Session["SignInID"] != null && !Session["SignInID"].Equals("") && Session["SignInType"].Equals("Customer"))
            {
                if (PreviousPage != null && PreviousPage.IsCrossPagePostBack || IsPostBack)
                {
                    DataClasses1DataContext db = new DataClasses1DataContext();
                    List<CartProduct> cartProducts = db.CartProducts.Where(x => x.CustomerID.Equals(Session["SignInID"])).ToList();

                    if (cartProducts.Count == 0)
                    {

                    } else
                    {
                        total = 0;
                        for (int i = 0; i < cartProducts.Count; i++)
                        {
                            total += (float)cartProducts[i].Quantity * (float)cartProducts[i].ProductOption1.Product.ProductPrice;
                        }
                        LabelTotal.Text = string.Format("{0:0.00}", total);
                        
                    }
                } else
                {
                    Response.Redirect("Cart.aspx");
                }
            } else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void LinkButtonGoPayment_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            List<CartProduct> cartProducts = db.CartProducts.Where(x => x.CustomerID.Equals(Session["SignInID"])).ToList();

            //sort cartproducts by cosplayer id
            cartProducts = cartProducts.OrderBy(x => x.ProductOption1.Product.CosplayerID).ToList();

            //create first order
            string cosplayerIDtemp = cartProducts[0].ProductOption1.Product.CosplayerID;
            Order firstOrder = new Order();
            firstOrder.CosplayerID = cosplayerIDtemp;
            firstOrder.CustomerID = Session["SignInID"].ToString();
            firstOrder.Address = TextBoxAddress.Text;
            firstOrder.OrderStatus = 1;
            firstOrder.TotalPrice = 0;
            firstOrder.OrderDate = DateTime.Now;

            db.Orders.InsertOnSubmit(firstOrder);
            db.SubmitChanges();
            int orderID = firstOrder.OrderID;

            for (int i = 0; i < cartProducts.Count; i++)
            {
                //if cosplayer ID equals previous order's cosplayer ID, add order product to previous order
                if (cartProducts[i].ProductOption1.Product.CosplayerID.Equals(cosplayerIDtemp)) 
                {
                    Order curOrder = db.Orders.FirstOrDefault(x => x.OrderID == orderID);
                    curOrder.TotalPrice += cartProducts[i].Quantity * cartProducts[i].ProductOption1.Product.ProductPrice;
                    OrderProduct orderProduct = new OrderProduct();
                    orderProduct.OrderID = orderID;
                    orderProduct.ProductID = cartProducts[i].ProductID;
                    orderProduct.ProductOption = cartProducts[i].ProductOption;
                    orderProduct.Quantity = cartProducts[i].Quantity;
                    db.OrderProducts.InsertOnSubmit(orderProduct);
                    db.SubmitChanges();

                    cartProducts[i].ProductOption1.StockNo -= cartProducts[i].Quantity; //deduct stock

                    db.CartProducts.DeleteOnSubmit(cartProducts[i]);
                    db.SubmitChanges();


                } else //else create new order and add order product
                {
                    cosplayerIDtemp = cartProducts[i].ProductOption1.Product.CosplayerID;
                    Order newOrder = new Order();
                    newOrder.CosplayerID = cosplayerIDtemp;
                    newOrder.CustomerID = Session["SignInID"].ToString();
                    newOrder.Address = TextBoxAddress.Text;
                    newOrder.OrderStatus = 1;
                    newOrder.TotalPrice = 0;
                    newOrder.OrderDate = DateTime.Now;

                    db.Orders.InsertOnSubmit(newOrder);
                    db.SubmitChanges();

                    orderID = newOrder.OrderID;
                    newOrder.TotalPrice += cartProducts[i].Quantity * cartProducts[i].ProductOption1.Product.ProductPrice;
                    OrderProduct orderProduct = new OrderProduct();
                    orderProduct.OrderID = orderID;
                    orderProduct.ProductID = cartProducts[i].ProductID;
                    orderProduct.ProductOption = cartProducts[i].ProductOption;
                    orderProduct.Quantity = cartProducts[i].Quantity;
                    db.OrderProducts.InsertOnSubmit(orderProduct);
                    db.SubmitChanges();

                    cartProducts[i].ProductOption1.StockNo -= cartProducts[i].Quantity; //deduct stock

                    db.CartProducts.DeleteOnSubmit(cartProducts[i]);
                    db.SubmitChanges();
                }

                
            }
            sendEmail();
            Response.Redirect("PurchaseHistory.aspx");
        }

        protected void sendEmail()
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Customer customer = db.Customers.FirstOrDefault(x => x.CustomerID.Equals(Session["SignInID"]));

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com");
            smtpClient.Port = 587;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new System.Net.NetworkCredential("CosplayHub2020@gmail.com", "19WMR09816");
            smtpClient.EnableSsl = true;

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("CosplayHub2020@gmail.com");
            mail.To.Add(customer.CustomerEmail);
            mail.Subject = "Order Confirmed";

            StringBuilder stringBuilder = new StringBuilder();
            StringWriter stringWriter = new StringWriter(stringBuilder);
            HtmlTextWriter htmlTextWriter = new HtmlTextWriter(stringWriter);
            RepeaterCartItems.RenderControl(htmlTextWriter);
            string orderItems = "<h2>Thank you for buying from Cosplay Hub!</h2>" + "<h3>We have received the following order from you:</h3>" +
                "<ul style=\"list-style-type:none\">" + stringBuilder.ToString() + "</ul>" +
                "<h3>Total Amount: RM" + total.ToString("#,##0.00") + "</h3>";

            mail.Body = orderItems;
            mail.IsBodyHtml = true;

            try
            {
                smtpClient.Send(mail);
                ClientScript.RegisterStartupScript(GetType(), "emailSuccess", "alert('Successfully sent order confirmation to email.');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "emailFailed", "alert('Failed to send order confirmation to email.');", true);
            }
        }
    }
}