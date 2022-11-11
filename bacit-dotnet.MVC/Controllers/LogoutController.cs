using Microsoft.AspNetCore.Mvc;

namespace bacit_dotnet.MVC.Controllers
{
    public class LogoutController : Controller
    {
        public IActionResult Index()
        {
            //remove session data
            //then redirect to login:
            return RedirectToAction("Index", "Login", new { area = "" });
        }
    }
}
