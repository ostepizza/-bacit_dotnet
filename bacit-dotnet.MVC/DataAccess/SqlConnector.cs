using bacit_dotnet.MVC.Entities;
using MySqlConnector;
using System.Data;
using System.Data.Common;

namespace bacit_dotnet.MVC.DataAccess
{
    public class SqlConnector : ISqlConnector
    {
        private readonly IConfiguration config;

        public SqlConnector(IConfiguration config)
        {
            this.config = config;
        }

        public IEnumerable<UserEntity> GetUsers()
        {
            using var connection = new MySqlConnection(config.GetConnectionString("MariaDB"));
            connection.Open();
            var reader = ReadData("Select emp_nr, emp_fname, emp_lname, emp_email, emp_phone, team_id, emp_pword from employees;", connection);
            var users = new List<UserEntity>();
            while (reader.Read())
            {
                var user = new UserEntity();
                user.emp_nr = reader.GetInt32("emp_nr");
                user.emp_fname = reader.GetString(1);
                user.emp_lname = reader.GetString(2);
                user.emp_email = reader.GetString(3);
                user.emp_phone = reader.GetString(4);
                user.team_id = reader.GetString(5);
                user.emp_pword = reader.GetString(6);

                Console.WriteLine(reader.GetString(3));
                users.Add(user);
            }
            connection.Close();
            return users;
        }

        public IDbConnection GetDbConnection()
        {
            return new MySqlConnection(config.GetConnectionString("MariaDb"));
        }

        private MySqlDataReader ReadData(string query, MySqlConnection conn)
        {
            using var command = conn.CreateCommand();
            command.CommandType = System.Data.CommandType.Text;
            command.CommandText = query;
            return command.ExecuteReader();
        }
          
    }
}
