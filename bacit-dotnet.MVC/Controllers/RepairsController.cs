using bacit_dotnet.MVC.Models.Repairs;
using Microsoft.AspNetCore.Mvc;

namespace bacit_dotnet.MVC.Controllers
{
    public class RepairsController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
