﻿namespace ExternalWeb
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using Microsoft.Web.WebPages.OAuth;
    
    public static class AuthConfig
    {
        /// <summary>
        /// To allow registration through 3rd party websites
        /// </summary>
        public static void RegisterAuth()
        {
            //// To let users of this site log in using their accounts from other sites such as Microsoft, Facebook, and Twitter,
            //// you must update this site. For more information visit http://go.microsoft.com/fwlink/?LinkID=252166

            //// OAuthWebSecurity.RegisterMicrosoftClient(
            ////    clientId: "",
            ////    clientSecret: "");

            //// OAuthWebSecurity.RegisterTwitterClient(
            ////    consumerKey: "",
            ////    consumerSecret: "");

            //// OAuthWebSecurity.RegisterFacebookClient(
            ////    appId: "",
            ////    appSecret: "");

            //// OAuthWebSecurity.RegisterGoogleClient();
        }
    }
}
