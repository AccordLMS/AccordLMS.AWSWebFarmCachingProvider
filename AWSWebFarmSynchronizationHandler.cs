﻿namespace AccordLMS.Providers.Caching.AWSWebFarmCachingProvider
{
    using System.Web;

    using DotNetNuke.Common.Utilities;
    using DotNetNuke.Entities.Host;
    using DotNetNuke.Services.Cache;

    /// <summary>
    ///     This synchronization handler receives requests from other servers and passes them to the cache system for
    ///     processing.  Error handling is purposefully allowed to bubble up from here to ensure the caller is notified.
    /// </summary>
    public class AWSWebFarmSynchronizationHandler : IHttpHandler
    {
        /// <summary>
        ///     Gets a value indicating whether indicates that this handler can be reused for multiple requests.
        /// </summary>
        public bool IsReusable => true;

        public void ProcessRequest(HttpContext context)
        {
            // Validate the request for required inputs, return if no action possible
            if (string.IsNullOrWhiteSpace(context.Request.QueryString["command"]))
            {
                return; // No command we cannot process
            }

            if (string.IsNullOrWhiteSpace(context.Request.QueryString["detail"]))
            {
                return; // No action we cannot return
            }

            // Only continue if our provider is current
            if (!(CachingProvider.Instance() is Caching.AWSWebFarmCachingProvider.AWSWebFarmCachingProvider))
            {
                return;
            }

            // Get the values, noting that if in debug we are not encrypted
            var command = Host.DebugMode
                ? context.Request.QueryString["command"]
                : UrlUtils.DecryptParameter(context.Request.QueryString["command"], Host.GUID);

            var detail = Host.DebugMode
                ? context.Request.QueryString["detail"]
                : UrlUtils.DecryptParameter(context.Request.QueryString["detail"], Host.GUID);

            // Pass the action on, if the current caching provider is ours
            var provider = (Caching.AWSWebFarmCachingProvider.AWSWebFarmCachingProvider)CachingProvider.Instance();
            provider.ProcessSynchronizationRequest(command, detail);
        }
    }
}