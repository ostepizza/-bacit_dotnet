using System.ComponentModel.DataAnnotations.Schema;

namespace bacit_dotnet.MVC.Entities
{
    [Table("Repairs")]

    public class RepairEntity
    {
        public int repairs_id { get; set; }

        public string repairs_title { get; set; }

        public string repairs_description { get; set; }

        public DateTime repairs_deadline { get; set; }

        public DateTime repairs_enddate { get; set; }

        public string repairs_cost { get; set; }

        public StatusEntity status_id { get; set; }

        public string suggested_emp_nr { get; set; }

        public string responible_emp_nr { get; set; }

        public TeamEntity team_id { get; set; }
    }
}