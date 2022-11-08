using System.ComponentModel.DataAnnotations.Schema;

namespace bacit_dotnet.MVC.Entities
{
	[Table("Superusers")]
	public class SuperusersEntity
	{
		public int su_id { get; set; }

		public UserEntity emp_nr { get; set; }
	}
}