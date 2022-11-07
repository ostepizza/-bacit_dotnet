using bacit_dotnet.MVC.Entities;
using bacit_dotnet.MVC.Models.Users;
using bacit_dotnet.MVC.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace bacit_dotnet.MVC.Controllers
{
    public class UsersController : Controller
    {
        private readonly IUserRepository userRepository;

        public UsersController(IUserRepository userRepository)
        {
            this.userRepository = userRepository;
        }
        [HttpGet]
        public IActionResult Index(string? email)
        {
            var model = new UserViewModel();
            model.Users = userRepository.GetUsers();
            if (email != null)
            {
                var currentUser = model.Users.FirstOrDefault(x => x.emp_email == email);
                if (currentUser != null)
                {
                    model.emp_nr = currentUser.emp_nr;
                    model.emp_fname = currentUser.emp_fname;
                    model.emp_lname = currentUser.emp_lname;
                    model.emp_email = currentUser.emp_email;
                    model.emp_phone = currentUser.emp_phone;
                    model.emp_pword = currentUser.emp_pword;
                }
            }
            return View(model);
        }

        [HttpPost]
        public IActionResult Save(UserViewModel model)
        {

            UserEntity newUser = new UserEntity
            {
                emp_fname = model.emp_fname,
                emp_lname = model.emp_lname,
                emp_email = model.emp_email,
                emp_phone = model.emp_phone,
                emp_pword = model.emp_pword,
            };
            userRepository.Save(newUser);
            return RedirectToAction("Index");
        }

        [HttpPost]
        public IActionResult Delete(string email)
        {
            userRepository.Delete(email);
            return RedirectToAction("Index");
        }
    }
}
