-- LACKS FOREIGN KEYS

-- Create table for employees
CREATE TABLE `employee` (
    `emp_nr` INT(11) NOT NULL ,
    `emp_fname` VARCHAR(255) NOT NULL ,
    `emp_lname` VARCHAR(255) NOT NULL ,
    `emp_phone` VARCHAR(30) NULL ,
    `emp_email` VARCHAR(255) NULL ,
    `team_id` INT(11) NULL ,
    `emp_pword` VARCHAR(255) NOT NULL ,
    PRIMARY KEY (`emp_nr`),
    UNIQUE (`emp_email`)
);

-- Create table for teams
CREATE TABLE `team` (
    `team_id` INT(11) NOT NULL AUTO_INCREMENT ,
    `team_name` VARCHAR(255) NOT NULL ,
    `leader_emp_nr` INT(11) NULL ,
    PRIMARY KEY (`team_id`),
    UNIQUE (`team_name`)
);

-- Create table for superusers
CREATE TABLE `superusers` (
    `su_id` INT(11) NOT NULL AUTO_INCREMENT ,
    `emp_nr` INT(11) NOT NULL ,
    PRIMARY KEY (`su_id`),
    UNIQUE (`emp_nr`)
);

-- Create table for statuses
CREATE TABLE `status` (
    `status_id` INT(11) NOT NULL AUTO_INCREMENT ,
    `status_title` VARCHAR(11) NOT NULL ,
    PRIMARY KEY (`status_id`),
    UNIQUE (`status_title`)
);

-- Create table for suggestions
CREATE TABLE `suggestion` (
    `suggestion_id` INT(11) NOT NULL AUTO_INCREMENT ,
    `suggestion_title` VARCHAR(255) NOT NULL ,
    `suggestion_description` VARCHAR(2000) NOT NULL ,
    `suggestion_deadline` DATE NOT NULL ,
    `suggestion_enddate` DATE NULL ,
    `status_id` INT(11) NOT NULL ,
    `suggested_emp_nr` INT(11) NOT NULL ,
    `responsible_emp_nr` INT(11) NOT NULL ,
    `team_id` INT(11) NOT NULL ,
    PRIMARY KEY (`suggestion_id`)
);

-- Create table for repairs
CREATE TABLE `repairs` (
    `repairs_id` INT(11) NOT NULL AUTO_INCREMENT ,
    `repairs_title` VARCHAR(255) NOT NULL ,
    `repairs_description` VARCHAR(2000) NOT NULL ,
    `repairs_deadline` DATE NOT NULL ,
    `repairs_enddate` DATE NULL ,
    `repairs_cost` VARCHAR(255) NULL ,
    `status_id` INT(11) NOT NULL ,
    `emp_nr` INT(11) NOT NULL ,
    `team_id` INT(11) NOT NULL ,
    PRIMARY KEY (`repairs_id`)
);

-- Create table for commenting on suggestions
CREATE TABLE `commentssug` ( 
    `commentsug_id` INT(11) NOT NULL AUTO_INCREMENT , 
    `suggestion_id` INT(11) NOT NULL , 
    `commentsug_time` TIMESTAMP NOT NULL , 
    `commentsug_text` VARCHAR(255) NOT NULL , 
    `emp_id` INT(11) NOT NULL , 
    PRIMARY KEY (`commentsug_id`)
);

-- Create table for commenting on repairs
CREATE TABLE `commentsrep` (
    `commentrep_id` INT(11) NOT NULL AUTO_INCREMENT , 
    `repairs_id` INT(11) NOT NULL , 
    `commentrep_time` TIMESTAMP NOT NULL , 
    `commentrep_text` VARCHAR(255) NOT NULL , 
    `emp_id` INT(11) NOT NULL , 
    PRIMARY KEY (`commentrep_id`)
);