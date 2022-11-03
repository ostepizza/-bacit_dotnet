using bacit_dotnet.MVC.Models.SuggestionsDetailed;
using Microsoft.AspNetCore.Mvc;

namespace bacit_dotnet.MVC.Controllers
{
    public class SuggestionsDetailedController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
