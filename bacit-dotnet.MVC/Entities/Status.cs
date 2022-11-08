using System.ComponentModel.DataAnnotations.Schema;

namespace bacit_dotnet.MVC.Entities
{
    [Table("Status")]

    public class StatusEntity
    {
        public int status_id { get; set; }

        public string status_title { get; set; }
    }
}