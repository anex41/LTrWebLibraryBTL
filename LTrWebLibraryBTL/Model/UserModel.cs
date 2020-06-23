using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LTrWebLibraryBTL.Model
{
    public class UserModel
    {
        private int userId;
        private string userAccount;
        private string userPassword;
        private string userDisplayName;
        private string userEmail;
        private string userAddress;
        private int userStatus;
        private int userRole;
        private int libraryId;

        public int UserId { get; set; }
        public string UserAccount { get; set; }
        public string UserPassword { get; set; }
        public string UserDisplayName { get; set; }
        public string UserEmail { get; set; }
        public string UserAddress { get; set; }
        public int UserStatus { get; set; }
        public int UserRole { get; set; }
        public int LibraryId { get; set; }

        public UserModel() { }
    }
}