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
    `emp_active` TINYINT(1) NOT NULL DEFAULT '1',
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
ALTER TABLE `employees` ADD FOREIGN KEY (`team_id`) REFERENCES teams(`team_id`);

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
    `status_title` VARCHAR(250) NOT NULL,
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
CREATE TABLE `commentsug` ( 
    `commentsug_id` INT(11) NOT NULL AUTO_INCREMENT, 
    `suggestion_id` INT(11) NOT NULL, 
    `commentsug_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(), 
    `commentsug_text` VARCHAR(500) NOT NULL, 
    `emp_nr` INT(11) NOT NULL, 
    PRIMARY KEY (`commentsug_id`),
    FOREIGN KEY (`emp_nr`) REFERENCES employees(`emp_nr`)
);

-- Create table for commenting on repairs
CREATE TABLE `commentrep` (
    `commentrep_id` INT(11) NOT NULL AUTO_INCREMENT, 
    `repairs_id` INT(11) NOT NULL, 
    `commentrep_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(), 
    `commentrep_text` VARCHAR(500) NOT NULL, 
    `emp_nr` INT(11) NOT NULL, 
    PRIMARY KEY (`commentrep_id`),
    FOREIGN KEY (`emp_nr`) REFERENCES employees(`emp_nr`)
);

-- CREATING EXAMPLE INFO
-- Adding employees
INSERT INTO `employees` (`emp_nr`, `emp_fname`, `emp_lname`, `emp_phone`, `emp_email`, `team_id`, `emp_pword`, `emp_active`) VALUES ('000', 'Super', 'User', NULL, NULL, NULL, '1234', 1);
INSERT INTO `employees` (`emp_nr`, `emp_fname`, `emp_lname`, `emp_phone`, `emp_email`, `team_id`, `emp_pword`, `emp_active`) VALUES ('001', 'Jens', 'Jensemann', NULL, NULL, NULL, '4321', 1);
INSERT INTO `employees` (`emp_nr`, `emp_fname`, `emp_lname`, `emp_phone`, `emp_email`, `team_id`, `emp_pword`, `emp_active`) VALUES ('002', 'Burg', 'Burgers', NULL, NULL, NULL, '9999', 1);
INSERT INTO `employees` (`emp_nr`, `emp_fname`, `emp_lname`, `emp_phone`, `emp_email`, `team_id`, `emp_pword`, `emp_active`) VALUES ('003', 'Jan', 'Banan', NULL, NULL, NULL, '8888', 0);
INSERT INTO `employees` (`emp_nr`, `emp_fname`, `emp_lname`, `emp_phone`, `emp_email`, `team_id`, `emp_pword`, `emp_active`) VALUES ('004', 'Jeff', 'Pringle', NULL, NULL, NULL, '7777', 1);
INSERT INTO `employees` (`emp_nr`, `emp_fname`, `emp_lname`, `emp_phone`, `emp_email`, `team_id`, `emp_pword`, `emp_active`) VALUES ('005', 'Lucky', 'Luke', NULL, NULL, NULL, '5555', 1);

-- Adding a superuser
INSERT INTO `superusers` (`su_id`, `emp_nr`) VALUES (NULL, '000');

-- Shows that the new IT user is also on the superuser-table and which superuser-id the user has received
SELECT employees.emp_nr, employees.emp_fname, employees.emp_lname, superusers.emp_nr, superusers.su_id 
FROM employees 
INNER JOIN superusers 
ON employees.emp_nr=superusers.emp_nr AND employees.emp_nr = 0;

-- Adding teams and updating employees with team ID
INSERT INTO `teams` (`team_id`, `team_name`, `leader_emp_nr`) VALUES (NULL, 'IT', '000');
UPDATE `employees` SET `team_id` = LAST_INSERT_ID() WHERE `emp_nr` = '000';

INSERT INTO `teams` (`team_id`, `team_name`, `leader_emp_nr`) VALUES (NULL, 'Administrasjon', '001');
UPDATE `employees` SET `team_id` = LAST_INSERT_ID() WHERE `emp_nr` = '001';

INSERT INTO `teams` (`team_id`, `team_name`, `leader_emp_nr`) VALUES (NULL, 'Økonomi', '002');
UPDATE `employees` SET `team_id` = LAST_INSERT_ID() WHERE `emp_nr` = '002';

INSERT INTO `teams` (`team_id`, `team_name`, `leader_emp_nr`) VALUES (NULL, 'Produksjon Avd. A', '004');
UPDATE `employees` SET `team_id` = LAST_INSERT_ID() WHERE `emp_nr` = '004';

INSERT INTO `teams` (`team_id`, `team_name`, `leader_emp_nr`) VALUES (NULL, 'Produksjon Avd. B', '005');
UPDATE `employees` SET `team_id` = LAST_INSERT_ID() WHERE `emp_nr` = '005';

-- Adding statuses
INSERT INTO `status` (`status_id`, `status_title`) VALUES (NULL, 'Ikke vurdert');
INSERT INTO `status` (`status_id`, `status_title`) VALUES (NULL, 'Godkjent');
INSERT INTO `status` (`status_id`, `status_title`) VALUES (NULL, 'Avslått');
INSERT INTO `status` (`status_id`, `status_title`) VALUES (NULL, 'Pågår');
INSERT INTO `status` (`status_id`, `status_title`) VALUES (NULL, 'Fullført');

UPDATE `status` SET `status_id` = 0 WHERE `status_title` = 'Ikke vurdert';
UPDATE `status` SET `status_id` = 1 WHERE `status_title` = 'Godkjent';
UPDATE `status` SET `status_id` = 2 WHERE `status_title` = 'Avslått';
UPDATE `status` SET `status_id` = 3 WHERE `status_title` = 'Pågår';
UPDATE `status` SET `status_id` = 4 WHERE `status_title` = 'Fullført';

-- Adding suggestions
INSERT INTO `suggestions` (`suggestion_id`, `suggestion_title`, `suggestion_description`, `suggestion_deadline`, `suggestion_enddate`, `status_id`, `suggested_emp_nr`, `responsible_emp_nr`, `team_id`)
SELECT NULL, 'Cola kjøleskap hos IT', 'Det er tungt arbeid å jobbe med PC. Derfor synes jeg at vi i IT burde få oss et helt eget Cola-themed kjøleskap nede hos oss.', '2023-01-28', NULL, 0, '000', '001', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '000';
UPDATE `suggestions` SET `suggestion_id` = 0 WHERE `suggestion_title` = 'Cola kjøleskap hos IT';

INSERT INTO `suggestions` (`suggestion_id`, `suggestion_title`, `suggestion_description`, `suggestion_deadline`, `suggestion_enddate`, `status_id`, `suggested_emp_nr`, `responsible_emp_nr`, `team_id`)
SELECT NULL, 'Lås opp døra', 'Vi er lei av å være innelåst i kjelleren!! Få oss ut!!!', '2022-12-24', NULL, 0, '002', '001', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '002';
UPDATE `suggestions` SET `suggestion_id` = 1 WHERE `suggestion_title` = 'Lås opp døra';

INSERT INTO `suggestions` (`suggestion_id`, `suggestion_title`, `suggestion_description`, `suggestion_deadline`, `suggestion_enddate`, `status_id`, `suggested_emp_nr`, `responsible_emp_nr`, `team_id`)
SELECT NULL, 'Nye SSDer', 'PC slow need harder drives', '2023-06-01', NULL, 0, '000', '002', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '000';
UPDATE `suggestions` SET `suggestion_id` = 2 WHERE `suggestion_title` = 'Nye SSDer';

INSERT INTO `suggestions` (`suggestion_id`, `suggestion_title`, `suggestion_description`, `suggestion_deadline`, `suggestion_enddate`, `status_id`, `suggested_emp_nr`, `responsible_emp_nr`, `team_id`)
SELECT NULL, 'Ny maskin', 'Vi trenger en ny maskin', '2023-04-14', NULL, 0, '004', '001', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '004';
UPDATE `suggestions` SET `suggestion_id` = 3 WHERE `suggestion_title` = 'Ny maskin';

INSERT INTO `suggestions` (`suggestion_id`, `suggestion_title`, `suggestion_description`, `suggestion_deadline`, `suggestion_enddate`, `status_id`, `suggested_emp_nr`, `responsible_emp_nr`, `team_id`)
SELECT NULL, 'Ny kaffetrakter', 'Blir for lite kaffe i produksjonshallen. Vi trenger en ny ein!', '2023-01-28', NULL, 0, '005', '002', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '005';
UPDATE `suggestions` SET `suggestion_id` = 4 WHERE `suggestion_title` = 'Ny kaffetrakter';

-- Adding repairs
INSERT INTO `repairs` (`repairs_id`, `repairs_title`, `repairs_description`, `repairs_deadline`, `repairs_enddate`, `repairs_cost`, `status_id`, `emp_nr`, `team_id`)
SELECT NULL, 'Ødelagt PSU', 'En maskin er nede pga. ødelagt PSU.', '2022-12-15', NULL, 450, 0, '000', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '000';
UPDATE `repairs` SET `repairs_id` = 0 WHERE `repairs_title` = 'Ødelagt PSU';

INSERT INTO `repairs` (`repairs_id`, `repairs_title`, `repairs_description`, `repairs_deadline`, `repairs_enddate`, `repairs_cost`, `status_id`, `emp_nr`, `team_id`)
SELECT NULL, 'Ødelagt tannhjul', 'Maskinen mista et tannhjul og er ute av drift', '2022-12-10', NULL, 1250, 0, '005', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '005';
UPDATE `repairs` SET `repairs_id` = 1 WHERE `repairs_title` = 'Ødelagt tannhjul';

INSERT INTO `repairs` (`repairs_id`, `repairs_title`, `repairs_description`, `repairs_deadline`, `repairs_enddate`, `repairs_cost`, `status_id`, `emp_nr`, `team_id`)
SELECT NULL, 'Verktøy gikk i stykker', 'En sag og to skrujern gikk i stykker', '2022-11-30', NULL, 650, 0, '004', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '004';
UPDATE `repairs` SET `repairs_id` = 2 WHERE `repairs_title` = 'Verktøy gikk i stykker';

INSERT INTO `repairs` (`repairs_id`, `repairs_title`, `repairs_description`, `repairs_deadline`, `repairs_enddate`, `repairs_cost`, `status_id`, `emp_nr`, `team_id`)
SELECT NULL, 'Ødelagt sandebånd', 'Sandebåndet er for glatt og må byttes', '2022-12-30', NULL, 2000, 0, '005', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '005';
UPDATE `repairs` SET `repairs_id` = 3 WHERE `repairs_title` = 'Ødelagt sandebånd';

INSERT INTO `repairs` (`repairs_id`, `repairs_title`, `repairs_description`, `repairs_deadline`, `repairs_enddate`, `repairs_cost`, `status_id`, `emp_nr`, `team_id`)
SELECT NULL, 'Tett malesprøyte', 'Malesprøyten er tett og må dyprenses', '2022-12-5', NULL, 200, 0, '004', `employees`.`team_id`
FROM `employees` WHERE `employees`.`emp_nr` = '004';
UPDATE `repairs` SET `repairs_id` = 4 WHERE `repairs_title` = 'Tett malesprøyte';

-- Adding suggestion comments
INSERT INTO `commentsug` (`commentsug_id`, `suggestion_id`, `commentsug_time`, `commentsug_text`, `emp_nr`)
VALUES (NULL, 0, CURRENT_DATETIME(), 'Bra forslag! Cola er godt!', '001');

INSERT INTO `commentsug` (`commentsug_id`, `suggestion_id`, `commentsug_time`, `commentsug_text`, `emp_nr`)
VALUES (NULL, 1, CURRENT_DATETIME(), 'Elendig forslag...', '001');

INSERT INTO `commentsug` (`commentsug_id`, `suggestion_id`, `commentsug_time`, `commentsug_text`, `emp_nr`)
VALUES (NULL, 2, CURRENT_DATETIME(), 'Det høres bra ut.', '001');

INSERT INTO `commentsug` (`commentsug_id`, `suggestion_id`, `commentsug_time`, `commentsug_text`, `emp_nr`)
VALUES (NULL, 3, CURRENT_DATETIME(), 'Oi, dette hørtes dyrt ut!!', '001');

INSERT INTO `commentsug` (`commentsug_id`, `suggestion_id`, `commentsug_time`, `commentsug_text`, `emp_nr`)
VALUES (NULL, 4, CURRENT_DATETIME(), 'KOFFEIN :DDDD', '001');

-- Adding repair comments
INSERT INTO `commentrep` (`commentrep_id`, `repairs_id`, `commentrep_time`, `commentrep_text`, `emp_nr`)
VALUES (NULL, 0, CURRENT_DATETIME(), 'Viktig å få fiksa!', '001');

INSERT INTO `commentrep` (`commentrep_id`, `repairs_id`, `commentrep_time`, `commentrep_text`, `emp_nr`)
VALUES (NULL, 1, CURRENT_DATETIME(), 'Bra å få ordna!', '001');

INSERT INTO `commentrep` (`commentrep_id`, `repairs_id`, `commentrep_time`, `commentrep_text`, `emp_nr`)
VALUES (NULL, 2, CURRENT_DATETIME(), 'Hvordan klarte du å ødelegge en sag???', '001');

INSERT INTO `commentrep` (`commentrep_id`, `repairs_id`, `commentrep_time`, `commentrep_text`, `emp_nr`)
VALUES (NULL, 3, CURRENT_DATETIME(), 'Helt enig!', '001');

INSERT INTO `commentrep` (`commentrep_id`, `repairs_id`, `commentrep_time`, `commentrep_text`, `emp_nr`)
VALUES (NULL, 4, CURRENT_DATETIME(), 'Deilig med billige reparasjoner :D', '001');