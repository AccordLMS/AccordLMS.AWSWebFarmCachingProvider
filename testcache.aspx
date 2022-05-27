<%@ Page Language="C#" AutoEventWireup="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%@ Import Namespace="DotNetNuke" %>
<%@ Import Namespace="DotNetNuke.Data" %>
<%@ Import Namespace="DotNetNuke.Security" %>
<%@ Import Namespace="DotNetNuke.Entities.Users" %>
<%@ Import Namespace="DotNetNuke.Entities.Profile" %>

<!--
= DNN Create a Host User tool = 
Created by: Horacio Judeikin (www.evotiva.com)
License: Distributed under the terms of the GNU General Public License
Created : Aug 10, 2010 
Updated: n/a
-->

<script language="C#" runat="server">  
    
    #region ---------------------- Events ----------------------

    ///////////////////////////////////////////////////////////////////////
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
            }
        }
        catch (Exception ex)
        {
            lblError.Text = ex.ToString();
            pnlForm.Visible = false;
        }
    }



    
    
    
    #endregion

    
    private static string GetCookieDomain(int portalId)
    {
        string cookieDomain = String.Empty;
        if (PortalController.IsMemberOfPortalGroup(portalId))
        {
            //set cookie domain for portal group
            var groupController = new PortalGroupController();
            var group = groupController.GetPortalGroups().SingleOrDefault(p => p.MasterPortalId == PortalController.GetEffectivePortalId(portalId));

            if (@group != null
                    && !string.IsNullOrEmpty(@group.AuthenticationDomain)
                    && PortalSettings.Current.PortalAlias.HTTPAlias.Contains(@group.AuthenticationDomain))
            {
                cookieDomain = @group.AuthenticationDomain;
            }

            if (String.IsNullOrEmpty(cookieDomain))
            {
                cookieDomain = FormsAuthentication.CookieDomain;
            }
        }
        else
        {
            //set cookie domain to be consistent with domain specification in web.config
            cookieDomain = FormsAuthentication.CookieDomain;
        }


        return cookieDomain;
    }

    protected void btnSaveCache_Click(object sender, EventArgs e)
    {
        try
        {
            lblError.Text = "";
			DataCache.SetCache("TestCache", txtValolr.Text);
        }
        catch (Exception ex)
        {
            lblError.Text = ex.ToString();
        }
    }

    protected void btnLoadCache_Click(object sender, EventArgs e)
    {
        try
        {
            lblError.Text = "";
			var cache = DataCache.GetCache("TestCache");
			if (cache != null)
				lblResults.Text = cache.ToString();
			else
				lblResults.Text = "Cache empty";
        }
        catch (Exception ex)
        {
            lblError.Text = ex.ToString();
        }
    }

    protected void btnCleanCache_Click(object sender, EventArgs e)
    {
        try
        {
            lblError.Text = "";
			DataCache.RemoveCache("TestCache");
        }
        catch (Exception ex)
        {
            lblError.Text = ex.ToString();
        }
    }
  
            

</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta name="author" content="Horacio Judeikin - www.evotiva.com" />
    <meta name="description" content="DNN Create Host User tool" />
    <link rel="stylesheet" type="text/css" href="/Portals/_default/default.css" />
    <title>Cache Test</title>
</head>

<body style="margin-top: 10px; margin-left: 10px;">
    <form id="frmFindAndReplace" runat="server">
    <div>
		<h1>Cache Test</h1>
                
        <asp:Panel ID="pnlForm" runat="server">
        
            <span class="NormalBold">Valor a Guardar:</span>&nbsp; &nbsp;
			<asp:TextBox ID="txtValolr" CssClass="NormalTextBox" Columns="30" runat="server"></asp:TextBox>
            <br />
            <br />
            
            <asp:Button runat="server" id="btnSaveCache" OnClick="btnSaveCache_Click" Text="Save Cache" />
            <asp:Button runat="server" id="btnLoadCache" OnClick="btnLoadCache_Click" Text="Load Cache" />
            <asp:Button runat="server" id="btnCleanCache" OnClick="btnCleanCache_Click" Text="Clean Cache" />
         
                        
            <p></p>
            <asp:Label ID="lblResults" runat="server" Text="" CssClass="NormalBold"></asp:Label>
            <p></p>
            <asp:Label ID="lblError" runat="server" Text="" CssClass="NormalRed"></asp:Label>
            <p></p>
                      
        </asp:Panel>
    </div>

        
    </form>
</body>
</html>
