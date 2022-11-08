<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="AdminPanel.Admins.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:TextBox ID="txtSearchMobile" placeholder="جستجو..." runat="server" AutoPostBack="True" OnTextChanged="txtSearchMobile_TextChanged"></asp:TextBox>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="sqlAllUsersDS" ForeColor="#333333" GridLines="None" OnPageIndexChanging="GridView1_PageIndexChanging" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" PageSize="2">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Family" HeaderText="Family" SortExpression="Family" />
            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
            <asp:BoundField DataField="Cellphone" HeaderText="Cellphone" SortExpression="Cellphone" />
            <asp:BoundField DataField="Points" HeaderText="Points" SortExpression="Points" />
            <asp:BoundField DataField="Credits" HeaderText="Credits" SortExpression="Credits" />
            <asp:BoundField DataField="Money" HeaderText="Money" SortExpression="Money" />
        </Columns>
        <EditRowStyle BackColor="#7C6F57" />
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />
    </asp:GridView>
    <br />
    <asp:DropDownList ID="ddlRoles" runat="server" DataSourceID="sqlRoles" DataTextField="RoleDescription" DataValueField="Id">
    </asp:DropDownList>
    <asp:SqlDataSource ID="sqlRoles" runat="server" ConnectionString="<%$ ConnectionStrings:sirooappConnectionString %>" SelectCommand="SELECT [Id], [RoleDescription] FROM [Roles] WHERE ([IsDeleted] = @IsDeleted) ORDER BY [Priority]">
        <SelectParameters>
            <asp:Parameter DefaultValue="false" Name="IsDeleted" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Update" />
    <br />
    <asp:SqlDataSource ID="sqlSearchDS" runat="server" ConnectionString="<%$ ConnectionStrings:sirooappConnectionString %>" SelectCommand="SELECT [Id], [Name], [Family], [Username], [Cellphone], [Points], [Credits], [Money] FROM [Users] WHERE ([Cellphone] LIKE '%' + @Cellphone + '%') OR ([Username] LIKE '%' + @Cellphone + '%') ORDER BY [Created] DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearchMobile" Name="Cellphone" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAllUsersDS" runat="server" ConnectionString="<%$ ConnectionStrings:sirooappConnectionString %>" SelectCommand="SELECT [Id], [Name], [Family], [Username], [Cellphone], [Points], [Credits], [Money] FROM [Users] ORDER BY [Created] DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlUserGroup" runat="server" ConnectionString="<%$ ConnectionStrings:sirooappConnectionString %>" OnSelected="sqlUserGroup_Selected" SelectCommand="SELECT        Roles.RoleDescription,Roles.Id
FROM            Roles INNER JOIN
                         UsersRoles ON Roles.Id = UsersRoles.Role
WHERE        (UsersRoles.IsDeleted = 0) AND (UsersRoles.[User] = @userId)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="userId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hidUserRole" runat="server" />
</asp:Content>
