using bacit_dotnet.MVC.Models.Login;
using Microsoft.AspNetCore.Mvc;

namespace bacit_dotnet.MVC.Controllers
{
    public class LeggTilBrukerController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}

