using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace PolicyDataApi.Controllers
{
    [ApiController]
    [Route("")]
    public class RolesController : ControllerBase
    {
        private readonly ILogger<RolesController> _logger;

        /// contains the tenants associated with a userId
        private static readonly List<User> _users = new List<User>
        {
            new User
            {
                UserId = "5d5f045d731061000115a7a8",
                AssociatedTenants = new List<TenantRole>
                {
                    new TenantRole
                    {
                        TenantId = 1,
                        Role = "admin"
                    }
                }
            }
        };

        public RolesController(ILogger<RolesController> logger)
        {
            _logger = logger;
        }

        /// <summary>
        /// Get the roles for a user at a tenant
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("users/{userId}/tenants/{tenantId}/roles")]
        public RolesResponse Get(string userId, int tenantId)
        {
            var roles = _users.Where(x => x.UserId == userId)
                .SelectMany(x => x.AssociatedTenants)
                .Where(x => x.TenantId == tenantId)
                .Select(x => x.Role)
                .ToList();

            return new RolesResponse
            {
                Roles = roles
            };
        }
    }

    class User
    {
        public string UserId { get; set; }

        public List<TenantRole> AssociatedTenants { get; set; }
    }

    class TenantRole
    {
        public int TenantId { get; set; }

        public string Role { get; set; }
    }
}
