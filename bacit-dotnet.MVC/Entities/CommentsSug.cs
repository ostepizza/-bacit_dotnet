using System.ComponentModel.DataAnnotations.Schema;

namespace bacit_dotnet.MVC.Entities
{
	public class CommentSugEntity
	{
		public int commentsug_id { get; set; }

		public SuggestionEntity suggestion_id { get; set; }

		public DateTime commentsug_time { get; set; }

		public DateTime commentsug_text { get; set; }

		public UserEntity emp_id { get; set; }
}