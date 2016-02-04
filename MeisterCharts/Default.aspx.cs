using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MeisterCharts
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
            var relativePath = "~/api/export/file";
            RadClientExportManager1.PdfSettings.ProxyURL = ResolveUrl(relativePath);
            RadClientExportManager1.PdfSettings.Author = "Alexander Kroiss";
            RadClientExportManager1.PdfSettings.Landscape = true;
            RadClientExportManager1.PdfSettings.Fonts.Add("Arial Unicode MS", "Fonts/ArialUnicodeMS.ttf");


            if (!Page.IsPostBack)
            {
                #region ReadQueryString
                var ertrag = Convert.ToDouble(Request.QueryString["e"]);
                var bestand = Convert.ToDouble(Request.QueryString["b"]);
                var aufwand = Convert.ToDouble(Request.QueryString["a"]);
                var pacht = Convert.ToDouble(Request.QueryString["p"]);

                if ((ertrag + bestand + aufwand + pacht) != 0)
                {
                    TbBestandsveränderung.Value = bestand;
                    TbErtrag.Value = ertrag;
                    TbAufwand.Value = aufwand;
                    TbPacht.Value = pacht;

                    var maschinen = Convert.ToDouble(Request.QueryString["m"]);
                    TbAfAMaschinen.Value = maschinen;
                    var gebäude = Convert.ToDouble(Request.QueryString["g"]);
                    TbAfAGebäude.Value = gebäude;
                    var sozial = Convert.ToDouble(Request.QueryString["s"]);
                    TbSozial.Value = sozial;
                    var alek = Convert.ToDouble(Request.QueryString["alek"]);
                    TbALEinkommen.Value = alek;
                    var leben = Convert.ToDouble(Request.QueryString["l"]);
                    TbLebenskosten.Value = leben;
                    var svb = Convert.ToDouble(Request.QueryString["svb"]);
                    TbSVB.Value = svb;
                    var steuer = Convert.ToDouble(Request.QueryString["st"]);
                    TbSteuer.Value = steuer;
                    var zinsen = Convert.ToDouble(Request.QueryString["z"]);
                    TbZinsen.Value = zinsen;
                }
                #endregion
            }

            radButtonGo_Click(null, null);            
        }

        protected void radButtonGo_Click(object sender, EventArgs e)
        {
            List<BarItem> ValuesArray = new List<BarItem>();
            var queryString = string.Concat("?", "e=", TbErtrag.Value, "&", "b=", TbBestandsveränderung.Value, "&",
    "a=", TbAufwand.Value, "&p=", TbPacht.Value, "&m=", TbAfAMaschinen.Value, "&g=", TbAfAGebäude.Value,
    "&s=", TbSozial.Value, "&alek=", TbALEinkommen.Value, "&l=", TbLebenskosten.Value, "&svb=", TbSVB.Value,
    "&st=", TbSteuer.Value, "&z=", TbZinsen.Value);
            TbQueryString.Text = string.Concat(@"http://meistercharts.azurewebsites.net/default.aspx", queryString);

            var ertrag = new BarItem();
            ertrag.Name = "Ertrag/Leistung";
            ertrag.NameP1 = "Ertrag";
            ertrag.ValuePositiv1 = (double)TbErtrag.Value;
            ertrag.ValuePositiv2 = (double)TbBestandsveränderung.Value;
            ertrag.NameP2 = ertrag.ValuePositiv2 != 0 ? "Bestandsveränderung" : "";
            ertrag.ColorP1 = "#004d1a";
            ertrag.ColorP2 = "#004d1a";

            var db = new BarItem();
            db.Name = "Variable Kosten und DB";
            db.ValueNegativ1 = (double)TbAufwand.Value;
            db.NameN1 = "-Aufwand";
            db.ColorN1 = "#006080";
            db.NameP1 = "Gesamtdeckungsbeitrag";
            db.ColorP1 = "#b35900";
            db.ValuePositiv1 = ertrag.ValuePositiv1 + ertrag.ValuePositiv2 - db.ValueNegativ1;

            var einkünfte = new BarItem();
            einkünfte.Name = "Einkünfte LuF";
            einkünfte.ValueNegativ1 = (double)TbPacht.Value;
            einkünfte.NameN1 = "-Pachtkosten";
            einkünfte.ColorN1 = "#330000";
            einkünfte.ValueNegativ2 = (double)TbAfAGebäude.Value;
            einkünfte.ColorN2 = einkünfte.ColorN1;
            einkünfte.NameN2 = "-AfA Gebäude";
            einkünfte.ColorN3 = einkünfte.ColorN1;
            einkünfte.ValueNegativ3 = (double)TbAfAMaschinen.Value;
            einkünfte.NameN3 = "-AfA Maschinen";
            einkünfte.NameP1 = "Einkünfte LuF";
            einkünfte.ColorP1 = "#4d3219";
            einkünfte.ValuePositiv1 = db.ValuePositiv1 + db.ValuePositiv2 - einkünfte.ValueNegativ1 - einkünfte.ValueNegativ2 - einkünfte.ValueNegativ3;

            var gesamteinkommen = new BarItem();
            gesamteinkommen.Name = "Gesamteinkommen";
            gesamteinkommen.ValuePositiv2 = (double)TbSozial.Value;
            gesamteinkommen.ColorP2 = "#806000";
            gesamteinkommen.NameP2 = gesamteinkommen.ValuePositiv2 != 0 ? "+Sozialeinkommen" : "";
            gesamteinkommen.ValuePositiv3 = (double)TbALEinkommen.Value;
            gesamteinkommen.NameP3 = gesamteinkommen.ValuePositiv3 != 0 ? "+außerlandw. Einkommen" : "";
            gesamteinkommen.ColorP3 = gesamteinkommen.ColorP2;
            gesamteinkommen.NameP1 = "Einkünfte LuF";
            gesamteinkommen.ColorP1 = einkünfte.ColorP1;
            gesamteinkommen.ValuePositiv1 = einkünfte.ValuePositiv1;

            var deckelung = new BarItem();
            deckelung.Name = "Unter/Ueberdeckelung";
            deckelung.ValueNegativ1 = (double)TbLebenskosten.Value;
            deckelung.ValueNegativ2 = (double)TbSteuer.Value;
            deckelung.ValueNegativ3 = (double)TbSVB.Value;
            deckelung.NameN1 = "-Lebenshaltungsaufwand";
            deckelung.ColorN1 = "#004c99";
            deckelung.ColorP1 = "#cc6500";
            deckelung.ColorN2 = "#006633";
            deckelung.NameN2 = deckelung.ValueNegativ2 != 0 ? "-Einkommenssteuer" : "";
            deckelung.NameN3 = "-SVB Beiträge";
            deckelung.ColorN3 = "#660000";
            deckelung.NameP1 = "Unter/Ueberdeckelung";
            deckelung.ValuePositiv1 = Math.Round(gesamteinkommen.ValuePositiv1 + gesamteinkommen.ValuePositiv2 + gesamteinkommen.ValuePositiv3
                - deckelung.ValueNegativ1 - deckelung.ValueNegativ2 - deckelung.ValueNegativ3, 2);

            var kdg = new BarItem();
            kdg.Name = "mf. Kapitaldienstgrenze";
            kdg.ValuePositiv1 = deckelung.ValuePositiv1;
            kdg.NameP1 = deckelung.NameP1;
            kdg.NameP2 = "+AfA Gebäude";
            kdg.ColorP2 = einkünfte.ColorN3;
            kdg.ColorP3 = einkünfte.ColorN3;
            kdg.ColorP1 = deckelung.ColorP1;
            kdg.ValuePositiv2 = (double)TbAfAGebäude.Value;
            kdg.ValuePositiv3 = (double)TbZinsen.Value;

            kdg.NameP3 = kdg.ValuePositiv3 != 0 ? "+Schuldzinsen" : "";

            ValuesArray.Add(ertrag);
            ValuesArray.Add(db);
            ValuesArray.Add(einkünfte);
            ValuesArray.Add(gesamteinkommen);
            ValuesArray.Add(deckelung);
            ValuesArray.Add(kdg);

            RadHtmlChart1.DataSource = ValuesArray;
            RadHtmlChart1.DataBind();
        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
        }
    }

    public class BarItem
    {
        public BarItem()
        {
            Init();
        }
 
        private void Init()
        {
            NameN1 = "";
            NameN2 = "";
            NameN3 = "";
            NameP1 = "";
            NameP2 = "";
            NameP3 = "";

            ColorP1 = "#72d633";
            ColorP2 = "#72d633";
            ColorP3 = "#72d633";
            ColorN1 = "#fb612d";
            ColorN2 = "#fb612d";
            ColorN3 = "#fb612d";
        }

        public BarItem(string name, double valuep1, double valuen1)
        {
            Init();
            Name = name;
            ValuePositiv1 = valuep1;
            if (valuen1 != 0)
            {
                ValueNegativ1 = valuen1;
            }
        }


        public string Name { get; set; }
        public string NameP1 { get; set; }
        public string NameP2 { get; set; }
        public string NameP3 { get; set; }
        public string NameN1 { get; set; }
        public string NameN2 { get; set; }
        public string NameN3 { get; set; }
        public double ValuePositiv1 { get; set; }
        public double ValuePositiv2 { get; set; }
        public double ValuePositiv3 { get; set; }
        public double ValueNegativ1 { get; set; }
        public double ValueNegativ2 { get; set; }
        public double ValueNegativ3 { get; set; }
        public string ColorP1 { get; set; }
        public string ColorP2 { get; set; }
        public string ColorP3 { get; set; }
        public string ColorN1 { get; set; }
        public string ColorN2 { get; set; }
        public string ColorN3 { get; set; }
    }

    public class DataInput
    {
        public DataInput(string name, int value)
        {
            Name = name;
            Value = value;
        }

        public string Name { get; set; }
        public int Value { get; set; }
    }
}