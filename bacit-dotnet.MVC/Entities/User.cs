using System.ComponentModel.DataAnnotations.Schema;

namespace bacit_dotnet.MVC.Entities
{
    [Table("Users")]
    public class UserEntity
    {
        public int emp_nr { get; set; }

        public string emp_fname  { get; set; }

        public string emp_lname { get; set; }

        public string emp_email { get; set; }

        public string emp_phone { get; set; }

        public string emp_pword { get; set; }
    }
}
