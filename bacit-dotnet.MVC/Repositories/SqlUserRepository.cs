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
            var sql = $"delete from users where emp_email = '{email}'";
            RunCommand(sql);
        }

        public List<UserEntity> GetUsers()
        {
            using (var connection = sqlConnector.GetDbConnection())
            {
                var reader = ReadData("Select emp_nr, emp_fname, emp_lname, emp_pword,emp_phone,team_id from users;", connection);
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
            user.emp_phone = reader.GetString(4);
            user.emp_pword = reader.GetString(5);
            return user;
        }

        public void Save(UserEntity user)
        {
            UserEntity existingUser = null;
            using (var connection = sqlConnector.GetDbConnection())
            {
                var reader = ReadData("Select emp_nr, emp_fname, emp_lname, emp_email, emp_phone,emp_pword from users;", connection);
               
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
                                   emp_fname = '{user.emp_fname}', 
                                   emp_lname = '{user.emp_lname}',
                                   emp_phone = '{user.emp_phone}',
                                   emp_pword ='{user.emp_pword}',  
                                where emp_email = '{user.emp_email}';";
                RunCommand(sql);
            }
            else 
            {
                var sql = $"insert into users(emp_fname, emp_lname, emp_email,emp_phone,emp_pword ) values('{user.emp_fname}', '{user.emp_lname}', '{user.emp_email}', '{user.emp_phone}','{user.emp_pword}');";
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

