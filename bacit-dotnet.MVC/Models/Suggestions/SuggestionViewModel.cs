using System.ComponentModel.DataAnnotations;

namespace bacit_dotnet.MVC.Models.Suggestions
{
    public class SuggestionViewModel
    {
        [Required]
        [MinLength(7, ErrorMessage ="Skriv en ordentlig tittel!")]
        public string suggestion_id { get; set; }

        public string suggestion_title { get; set; }

        public int suggestion_description { get; set; }

        public string Description { get; set; }

        public string TimeStamp { get; set; }
    }
}
