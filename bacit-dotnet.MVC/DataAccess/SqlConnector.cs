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
            var reader = ReadData("Select emp_nr, emp_fname, emp_lname, emp_email, emp_phone, emp_pword from users;", connection);
            var users = new List<UserEntity>();
            while (reader.Read())
            {
                var user = new UserEntity();
                user.emp_nr = reader.GetInt32("emp_nr");
                user.emp_fname = reader.GetString(1);
                user.emp_lname = reader.GetString(2);
                user.emp_email = reader.GetString(3);
                user.emp_phone = reader.GetString(4);
                user.emp_pword = reader.GetString(5);

                Console.WriteLine(reader.GetString(3));
                users.Add(user);
            }
            connection.Close();
            return users;
        }
        
        public IEnumerable<SuggestionEntity> GetSuggestions()
        {
            using var connection = new MySqlConnection(config.GetConnectionString("MariaDB"));
            connection.Open();
            var reader = ReadData("Select suggestion_id, suggestion_title, suggestion_description, suggestion_deadline, suggestion_enddate from suggestions");
            var suggestions = new List<SuggestionEntity>();
            while (reader.Read())
            {
                var suggestion = new SuggestionEntity();
                suggestion.suggestion_id = reader.GetInt32("suggestion_id");
                suggestion.suggestion_title = reader.GetString(1);
                suggestion.suggestion_description = reader.GetString(2);
                suggestion.suggestion_deadline = reader.GetInt32()
                suggestion.suggestion_enddate = reader.GetInt32()
                suggestions.Add(suggestion);
            }
            connection.Close();
            return suggestions;
        }
        
        public IEnumerable<RepairEntity> GetRepairs()
        {
            using var connection = new MySqlConnection(config.GetConnectionString("MariaDB"));
            connection.Open();
            var reader = ReadData("Select repair_id, repair_title, repair_description, repair_deadline, repair_enddate from repairs");
            var repairs = new List<RepairEntity>();
            while (reader.Read())
            {
                var repair = new RepairEntity();
                repair.repair_id = reader.GetString("repair_id")
                repair.repair_title = reader.GetString(1);
                repair.repair_description = reader.GetString(2);
                repair.repairs_deadline = reader.GetInt32();
                repair.repairs_enddate = reader.GetInt32();
                repairs.Add(repair);
            }
            connection.Close();
            return repairs;
        }
        
        public IEnumerable

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
