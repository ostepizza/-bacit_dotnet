-- Sets up the database to use
create database if not exists webAppDatabase;
use webAppDatabase;

-- Create table for employees
CREATE TABLE `employees` (
    `emp_nr` INT(11) NOT NULL,
    `emp_fname` VARCHAR(255) NOT NULL,
    `emp_lname` VARCHAR(255) NOT NULL,
    `emp_phone` VARCHAR(30) NULL,
    `emp_email` VARCHAR(255) NULL,
    `team_id` INT(11) NULL,
    `emp_pword` VARCHAR(255) NOT NULL,
    `emp_active` TINYINT(1) NOT NULL DEFAULT '0',
    PRIMARY KEY (`emp_nr`),
    UNIQUE (`emp_email`)
);

-- Create table for teams
CREATE TABLE `teams` (
    `team_id` INT(11) NOT NULL AUTO_INCREMENT,
    `team_name` VARCHAR(255) NOT NULL,
    `leader_emp_nr` INT(11) NULL,
    PRIMARY KEY (`team_id`),
    UNIQUE (`team_name`),
    FOREIGN KEY (`leader_emp_nr`) REFERENCES employees(`emp_nr`)
);

-- Adds foreign key between employees and teams
ALTER TABLE `employees`
ADD FOREIGN KEY (`team_id`) REFERENCES teams(`team_id`);

-- Create table for superusers
CREATE TABLE `superusers` (
    `su_id` INT(11) NOT NULL AUTO_INCREMENT,
    `emp_nr` INT(11) NOT NULL,
    PRIMARY KEY (`su_id`),
    UNIQUE (`emp_nr`),
    FOREIGN KEY (`emp_nr`) REFERENCES employees(`emp_nr`)
);

-- Create table for statuses
CREATE TABLE `status` (
    `status_id` INT(11) NOT NULL AUTO_INCREMENT,
    `status_title` VARCHAR(11) NOT NULL,
    PRIMARY KEY (`status_id`),
    UNIQUE (`status_title`)
);

-- Create table for suggestions
CREATE TABLE `suggestions` (
    `suggestion_id` INT(11) NOT NULL AUTO_INCREMENT,
    `suggestion_title` VARCHAR(255) NOT NULL,
    `suggestion_description` VARCHAR(2000) NOT NULL,
    `suggestion_deadline` DATE NOT NULL,
    `suggestion_enddate` DATE NULL,
    `status_id` INT(11) NOT NULL,
    `suggested_emp_nr` INT(11) NOT NULL,
    `responsible_emp_nr` INT(11) NOT NULL,
    `team_id` INT(11) NOT NULL ,
    PRIMARY KEY (`suggestion_id`),
    FOREIGN KEY (`status_id`) REFERENCES status(`status_id`),
    FOREIGN KEY (`suggested_emp_nr`) REFERENCES employees(`emp_nr`),
    FOREIGN KEY (`responsible_emp_nr`) REFERENCES employees(`emp_nr`),
    FOREIGN KEY (`team_id`) REFERENCES teams(`team_id`)
);

-- Create table for repairs
CREATE TABLE `repairs` (
    `repairs_id` INT(11) NOT NULL AUTO_INCREMENT,
    `repairs_title` VARCHAR(255) NOT NULL,
    `repairs_description` VARCHAR(2000) NOT NULL,
    `repairs_deadline` DATE NOT NULL,
    `repairs_enddate` DATE NULL,
    `repairs_cost` VARCHAR(255) NULL,
    `status_id` INT(11) NOT NULL,
    `emp_nr` INT(11) NOT NULL,
    `team_id` INT(11) NOT NULL,
    PRIMARY KEY (`repairs_id`),
    FOREIGN KEY (`emp_nr`) REFERENCES employees(`emp_nr`),
    FOREIGN KEY (`team_id`) REFERENCES teams(`team_id`)
);

-- Create table for commenting on suggestions
CREATE TABLE `commentssug` ( 
    `commentsug_id` INT(11) NOT NULL AUTO_INCREMENT, 
    `suggestion_id` INT(11) NOT NULL, 
    `commentsug_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(), 
    `commentsug_text` VARCHAR(255) NOT NULL, 
    `emp_nr` INT(11) NOT NULL, 
    PRIMARY KEY (`commentsug_id`),
    FOREIGN KEY (`emp_nr`) REFERENCES employees(`emp_nr`)
);

-- Create table for commenting on repairs
CREATE TABLE `commentsrep` (
    `commentrep_id` INT(11) NOT NULL AUTO_INCREMENT, 
    `repairs_id` INT(11) NOT NULL, 
    `commentrep_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(), 
    `commentrep_text` VARCHAR(255) NOT NULL, 
    `emp_nr` INT(11) NOT NULL, 
    PRIMARY KEY (`commentrep_id`),
    FOREIGN KEY (`emp_nr`) REFERENCES employees(`emp_nr`)
);

-- Creates a user and a team
INSERT INTO `employees` (`emp_nr`, `emp_fname`, `emp_lname`, `emp_phone`, `emp_email`, `team_id`, `emp_pword`) VALUES ('0', 'Super', 'User', NULL, NULL, NULL, '1234');
INSERT INTO `superusers` (`su_id`, `emp_nr`) VALUES (NULL, '0');
INSERT INTO `teams` (`team_id`, `team_name`, `leader_emp_nr`) VALUES (NULL, 'The Test Team', '0');
SELECT * FROM `employees`;
SELECT * FROM `superusers`;
SELECT * FROM `teams`;

-- Shows that the new user is also on the superuser-table and which superuser-id the user has received
SELECT employees.emp_nr, employees.emp_fname, employees.emp_lname, superusers.emp_id, superusers.su_id 
FROM employees 
INNER JOIN superusers 
ON employees.emp_id=superusers.emp_id AND employees.emp_id = 0;