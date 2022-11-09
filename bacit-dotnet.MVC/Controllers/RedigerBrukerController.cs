using bacit_dotnet.MVC.Models.Login;
using Microsoft.AspNetCore.Mvc;

namespace bacit_dotnet.MVC.Controllers
{
    public class RedigerBrukerController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
