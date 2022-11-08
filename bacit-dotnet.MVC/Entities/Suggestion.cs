using System.ComponentModel.DataAnnotations.Schema;

namespace bacit_dotnet.MVC.Entities
{
    [Table("Suggestions")]
    public class SuggestionEntity
    {
        public int suggestion_id { get; set; }
        
        public string suggestion_title { get; set; }

        public string suggestion_description { get; set;}

        public DateTime suggestion_deadline { get; set; }

        public DateTime suggestion_enddate { get; set; }

    }
}