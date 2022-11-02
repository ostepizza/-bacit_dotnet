using System.ComponentModel.DataAnnotations.Schema;

namespace bacit_dotnet.MVC.Entities
{
    [Table("suggestions")]
    public class SuggestionEntity
    {
        public int suggestion_id;
        public string suggestion_title;
        public string suggestion_description;
        public int status_id;
        public string suggested_emp_nr;
    }
}