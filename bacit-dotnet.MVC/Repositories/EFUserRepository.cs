using bacit_dotnet.MVC.DataAccess;
using bacit_dotnet.MVC.Entities;

namespace bacit_dotnet.MVC.Repositories
{
    public class EFUserRepository : IUserRepository
    {
        private readonly DataContext dataContext;

        public EFUserRepository(DataContext dataContext)
        {
            this.dataContext = dataContext;
        }
        public void Delete(string email)
        {
            UserEntity? user = GetUserByEmail(email);
            if (user == null)
                return;
            dataContext.Users.Remove(user);
            dataContext.SaveChanges();
        }

        private UserEntity? GetUserByEmail(string email)
        {
            return dataContext.Users.FirstOrDefault(x => x.emp_email == email);
        }

        public List<UserEntity> GetUsers()
        {
            return dataContext.Users.ToList();
        }

        public void Save(UserEntity user)
        {
            var existingUser = GetUserByEmail(user.emp_email);
            if (existingUser == null)
            {
                dataContext.Users.Add(user);
            }
            else
            {
                existingUser.emp_email = user.emp_email;
                existingUser.emp_phone = user.emp_phone;
                existingUser.emp_fname = user.emp_fname;
                existingUser.emp_lname = user.emp_lname;
                existingUser.emp_pword = user.emp_pword;
            }
            dataContext.SaveChanges();
        }
    }
}
