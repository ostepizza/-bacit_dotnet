using bacit_dotnet.MVC.Models.NewTeam;
using Microsoft.AspNetCore.Mvc;

namespace bacit_dotnet.MVC.Controllers
{
    public class NewTeamController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
