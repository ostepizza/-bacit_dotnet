using bacit_dotnet.MVC.DataAccess;
using bacit_dotnet.MVC.Entities;
using MySqlConnector;
using System.Data;

namespace bacit_dotnet.MVC.Repositories
{
    public class SqlUserRepository : IUserRepository
    {
        private readonly ISqlConnector sqlConnector;

        public SqlUserRepository(ISqlConnector sqlConnector)
        {
            this.sqlConnector = sqlConnector;
        }
        public void Delete(string email)
        {
            var sql = $"delete from users where email = '{email}'";
            RunCommand(sql);
        }

        public List<UserEntity> GetUsers()
        {
            using (var connection = sqlConnector.GetDbConnection())
            {
                var reader = ReadData("Select emp_nr, emp_fname, emp_lname, emp_pword,emp_phone,team_id from Users;", connection);
                var users = new List<UserEntity>();
                while (reader.Read())
                {
                    UserEntity user = MapUserFromReader(reader);
                    users.Add(user);
                }
                connection.Close();
                return users;

            }
        }

        private static UserEntity MapUserFromReader(IDataReader reader)
        {
            var user = new UserEntity();
            user.emp_nr = reader.GetInt32(0);
            user.emp_fname = reader.GetString(1);
            user.emp_lname = reader.GetString(2);
            user.emp_email = reader.GetString(3);
            user.emp_pword = reader.GetString(4);
            user.EmployeeNumber = reader.GetString(5);
            user.Team = reader.GetString(6);
            user.Role = reader.GetString(6);
            return user;
        }

        public void Save(UserEntity user)
        {
            UserEntity existingUser = null;
            using (var connection = sqlConnector.GetDbConnection())
            {
                var reader = ReadData("Select id, Name, Email, Password,EmployeeNumber,Team, Role from users;", connection);
               
                while (reader.Read())
                {
                    existingUser = MapUserFromReader(reader);
                }
                connection.Close();
            }
            if (existingUser!=null)
            {
                var sql = $@"update users 
                                set 
                                   Name = '{user.Name}', 
                                   Password='{user.Password}',
                                   EmployeeNumber = '{user.EmployeeNumber}',
                                   Team ='{user.Team}', 
                                   Role ='{user.Role}' 
                                where email = '{user.Email}';";
                RunCommand(sql);
            }
            else 
            {
                var sql = $"insert into users(Name, Email, Password,EmployeeNumber,Team, Role ) values('{user.Name}', '{user.Email}', '{user.Password}', '{user.EmployeeNumber}','{user.Team}','{user.Role}');";
                RunCommand(sql);
            }
            
        }

        private void RunCommand(string sql)
        {
            using (var connection = sqlConnector.GetDbConnection())
            {
                connection.Open();
                var command = connection.CreateCommand();
                command.CommandText = sql;
                command.ExecuteNonQuery();
                connection.Close();
            }
        }

        private IDataReader ReadData(string query, IDbConnection connection)
        {
            connection.Open();
            using var command = connection.CreateCommand();
            command.CommandType = System.Data.CommandType.Text;
            command.CommandText = query;
            return command.ExecuteReader();
        }
    }
}

