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
    public partial class ViewCosplayerGallery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Get data from another web page
            var id = Request.QueryString["id"];
            DataClasses1DataContext db = new DataClasses1DataContext();
            Cosplayer cosplayer = db.Cosplayers.FirstOrDefault(x => x.CosplayerID == id);
            Image image = db.Images.FirstOrDefault(x => x.ImageID == cosplayer.CosplayerProfilePic);
            LabelCosplayerID.Text = cosplayer.CosplayerID;
            LabelCosplayerName.Text = cosplayer.CosplayerName;
            LabelCosplayerDesc.Text = cosplayer.CosplayerDescription;
            ImageCosplayerProfilePicture.Attributes["src"] = image.ImagePath;

        }

        protected void rptCosplayerOnSale_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataClasses1DataContext db = new DataClasses1DataContext();
            Label labelStock = ((Label)e.Item.FindControl("LabelStock"));
            HiddenField hiddenField = ((HiddenField)e.Item.FindControl("HiddenField1"));
            int productID = int.Parse(hiddenField.Value.ToString());
            if (db.ProductOptions.FirstOrDefault(x => x.ProductID == productID) != null)
            {
                labelStock.Text = db.ProductOptions.Where(x => x.ProductID == int.Parse(hiddenField.Value)).Sum(x => x.StockNo) + "";
            }
            if (int.Parse(labelStock.Text) < 1)
            {
                e.Item.Visible = false;
            }
        }
    }
}