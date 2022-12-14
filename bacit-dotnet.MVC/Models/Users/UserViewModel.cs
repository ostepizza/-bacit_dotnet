using bacit_dotnet.MVC.Entities;
using bacit_dotnet.MVC.Repositories;

namespace bacit_dotnet.MVC.Models.Users
{
    public class UserViewModel
    {

        public int emp_nr { get; set; }
        
        public string emp_fname { get; set; }

        public string emp_lname { get; set; }

        public string emp_email { get; set; }

        public string emp_phone { get; set; }

        public string emp_pword { get; set; }

        public List<string> AvailableRoles { get; set; }

        public string ValididationErrorMessage { get; set; }

        public IEnumerable<UserEntity> Users { get; set; }
    }
}
