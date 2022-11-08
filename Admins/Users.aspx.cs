using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AdminPanel.Admins
{
    public partial class Dashboard : System.Web.UI.Page
    {
        public SirooDataSetTableAdapters.UsersTableAdapter usrTA = new SirooDataSetTableAdapters.UsersTableAdapter();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (txtSearchMobile.Text=="")
            {
                sqlAllUsersDS.DataBind();
                GridView1.DataSourceID = null;
                GridView1.DataSource = sqlAllUsersDS;
                GridView1.DataBind();
            }
            else
            {
                
                GridView1.DataSourceID = null;
                GridView1.DataSource = sqlSearchDS;
                GridView1.DataBind();
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
        {
            object sel= GridView1.SelectedValue;
            DataKey dk= GridView1.SelectedDataKey;
            TextBox1.Text = GridView1.SelectedRow.Cells[2].Text;



            var dv = new DataView();
            var dt = new DataTable();

            // Here mySQLDataSource is the ID of SQLDataSource
            dv = sqlUserGroup.Select(DataSourceSelectArguments.Empty) as DataView;
            dt = dv.ToTable();
            if (dt.Rows.Count > 0)
            {
                hidUserRole.Value = dt.Rows[0][1].ToString();
                ddlRoles.SelectedValue = hidUserRole.Value;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SirooDataSet.UsersDataTable userDT = usrTA.GetDataByUserId(Guid.Parse(GridView1.SelectedValue.ToString()));
            usrTA.UpdateName(TextBox1.Text,userDT[0].Id);
            GridView1.DataBind();
        }

        protected void txtSearchMobile_TextChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
            GridView1.SelectedIndex = -1;
        }

        protected void sqlUserGroup_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

        }
    }
}