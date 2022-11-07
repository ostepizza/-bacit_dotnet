using bacit_dotnet.MVC.DataAccess;
using bacit_dotnet.MVC.Entities;
using Dapper;
using Dapper.Contrib.Extensions;
using MySqlConnector;

namespace bacit_dotnet.MVC.Repositories
{
    /// <summary>
    /// Using packages Dapper and Dapper.Contrib
    /// </summary>
    public class DapperUserRepository : IUserRepository
    {
        private readonly ISqlConnector sqlConnector;

        public DapperUserRepository(ISqlConnector sqlConnector)
        {
            this.sqlConnector = sqlConnector;
        }
        public void Delete(string email)
        {
            var user = GetUserByEmail(email);
            if (user == null)
                return;
            using (var connection = sqlConnector.GetDbConnection() as MySqlConnection)
            {
                connection.Delete<UserEntity>(user);
            }
        }

        private UserEntity GetUserByEmail(string emp_email)
        {
            using (var connection = sqlConnector.GetDbConnection() as MySqlConnection)
            {
                return connection.QueryFirstOrDefault<UserEntity>("Select emp_nr, emp_fname, emp_lname, emp_email,emp_phone,emp_pword from users where email like @emailParameter; ", new { emailParameter = emp_email });
            }
        }

        public List<UserEntity> GetUsers()
        {
            using (var connection = sqlConnector.GetDbConnection() as MySqlConnection)
            {
                var users = connection.Query<UserEntity>("Select emp_nr, emp_fname, emp_lname, emp_email,emp_phone, emp_pword from users;"); //Regular Dapper
                return users.ToList();
            }
        }

        public void Save(UserEntity user)
        {
            var existingUser = GetUserByEmail(user.emp_email);
            using (var connection = sqlConnector.GetDbConnection() as MySqlConnection)
            {
                if (existingUser != null)
                {
                    user.emp_nr = existingUser.emp_nr; // set this so the update-magic knows what record to update. 
                    connection.Update<UserEntity>(user); //Dapper.Contrib
                }
                else
                {
                    connection.Insert<UserEntity>(user); //Dapper.Contrib
                }
            }
        }
    }
}
