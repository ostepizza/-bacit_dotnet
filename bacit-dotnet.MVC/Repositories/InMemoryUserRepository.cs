using bacit_dotnet.MVC.Entities;

namespace bacit_dotnet.MVC.Repositories
{
    public class InMemoryUserRepository : IUserRepository
    {
        private List<UserEntity> users;
        public InMemoryUserRepository()
        {
            users = new List<UserEntity>();
        }
        public void Save(UserEntity user)
        {
            var existingUser = GetUserByEmail(user.emp_email);
            if (existingUser == null)
            {
                users.Add(user);
            }
            else
            {
                existingUser.emp_email = user.emp_email;
                existingUser.emp_fname = user.emp_fname;
                existingUser.emp_lname = user.emp_lname;
                existingUser.emp_phone = user.emp_phone;
                existingUser.emp_pword = user.emp_pword;
            }
        }

        public List<UserEntity> GetUsers()
        {
            return users;
        }

        public void Delete(string email)
        {
            UserEntity? foundUser = GetUserByEmail(email);
            if (foundUser != null)
            {
                users.Remove(foundUser);
            }
        }

        private UserEntity? GetUserByEmail(string email)
        {
            return users
                             .FirstOrDefault(user =>
                             user.emp_email.Equals(email, StringComparison.InvariantCultureIgnoreCase));
        }
    }
}
