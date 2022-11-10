using bacit_dotnet.MVC.Entities;
using bacit_dotnet.MVC.Repositories;
using System.ComponentModel.DataAnnotations;
using System.Xml.Linq;

namespace bacit_dotnet.MVC.Models.Login
{
    public class LoginViewModel
    {
        [Required]
        [Display(Name = "Ansattnummer")]
        public string employeeNr { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Passord")]
        public string password { get; set; }
    }
}
