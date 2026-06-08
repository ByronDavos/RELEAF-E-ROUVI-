-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Εξυπηρετητής: 127.0.0.1
-- Χρόνος δημιουργίας: 30 Ιαν 2025 στις 17:51:49
-- Έκδοση διακομιστή: 10.4.32-MariaDB
-- Έκδοση PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Βάση δεδομένων: `thesis_system`
--

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `actionlogs`
--

CREATE TABLE `actionlogs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `assignment_id` int(11) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `presentation_date` date NOT NULL,
  `presentation_time` time NOT NULL,
  `location` varchar(255) NOT NULL,
  `details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `committees`
--

CREATE TABLE `committees` (
  `id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `lecturer_id` int(11) NOT NULL,
  `role` enum('supervisor','member') NOT NULL,
  `status` enum('invited','accepted','declined') NOT NULL,
  `invitation_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `response_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `diplomaassignments`
--

CREATE TABLE `diplomaassignments` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `thesis_id` int(11) NOT NULL,
  `status` enum('under_assignment','active','under_review','completed','cancelled') NOT NULL,
  `assignment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `completion_date` timestamp NULL DEFAULT NULL,
  `final_grade` decimal(5,2) DEFAULT NULL,
  `repository_link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `invitations`
--

CREATE TABLE `invitations` (
  `invitation_id` int(11) NOT NULL,
  `theses_id` int(11) NOT NULL,
  `invited_by` int(11) NOT NULL,
  `invitee_id` int(11) NOT NULL,
  `invitation_date` date DEFAULT NULL,
  `response` enum('accepted','rejected','pending') DEFAULT 'pending',
  `response_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `content` varchar(300) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `statistics`
--

CREATE TABLE `statistics` (
  `stat_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` enum('epivlepon','melos') NOT NULL,
  `avg_completion_time` decimal(5,2) DEFAULT NULL,
  `avg_grade` decimal(5,2) DEFAULT NULL,
  `total_theses` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `theses`
--

CREATE TABLE `theses` (
  `id` int(11) NOT NULL,
  `topic_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `status` enum('available','assigned','completed','cancelled') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `topics`
--

CREATE TABLE `topics` (
  `topic_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `pdf_file_path` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Άδειασμα δεδομένων του πίνακα `topics`
--

INSERT INTO `topics` (`topic_id`, `title`, `description`, `pdf_file_path`, `created_by`) VALUES
(1, 'Network-centric systems', '', NULL, 1),
(2, 'Integrated Systems', '', NULL, 7),
(3, 'Artificial Intelligence', '', NULL, 8),
(4, 'WEB', '', NULL, 9),
(5, 'Artificial Intelligence', '', NULL, 10),
(6, 'Data Engineering', '', NULL, 11),
(7, 'informatics', '', NULL, 12),
(8, 'Arxeologia', '', NULL, 13),
(9, 'Business', '', NULL, 14),
(10, 'SQL injections', '', NULL, 15),
(11, 't', '', NULL, 16),
(12, 'Big Data', '', NULL, 17),
(13, 'Pharmaceutical Drugs', '', NULL, 18),
(14, 'Nekro8aftiki', '', NULL, 19),
(15, 'kippah', '', NULL, 20),
(16, 'Logistics', '', NULL, 21),
(17, 'Information Theory', '', NULL, 22),
(18, 'Telecommunication Electronics', '', NULL, 23),
(19, 'Physics', '', NULL, 24),
(20, 'Statistics and Probability', '', NULL, 25),
(21, 'Artificial Intelligence', '', NULL, 26),
(22, 'Economic Theory', '', NULL, 27),
(23, 'Renewable Energy Systems', '', NULL, 28),
(24, 'Electric Vehicles', '', NULL, 29),
(25, 'AI', '', NULL, 30),
(26, 'topic', '', NULL, 32),
(27, 'top', '', NULL, 33),
(28, 'thalasioi ipopotamoi', '', NULL, 34),
(29, 'Provata', '', NULL, 35),
(30, 'assassinations', '', NULL, 36),
(31, 'Bet Predictions', '', NULL, 37),
(32, 'Network-centric systems', '', NULL, 1),
(33, 'Integrated Systems', '', NULL, 7),
(34, 'Artificial Intelligence', '', NULL, 8),
(35, 'WEB', '', NULL, 9),
(36, 'Artificial Intelligence', '', NULL, 10),
(37, 'Data Engineering', '', NULL, 11),
(38, 'informatics', '', NULL, 12),
(39, 'Arxeologia', '', NULL, 13),
(40, 'Business', '', NULL, 14),
(41, 'SQL injections', '', NULL, 15),
(42, 't', '', NULL, 16),
(43, 'Big Data', '', NULL, 17),
(44, 'Pharmaceutical Drugs', '', NULL, 18),
(45, 'Nekro8aftiki', '', NULL, 19),
(46, 'kippah', '', NULL, 20),
(47, 'Logistics', '', NULL, 21),
(48, 'Information Theory', '', NULL, 22),
(49, 'Telecommunication Electronics', '', NULL, 23),
(50, 'Physics', '', NULL, 24),
(51, 'Statistics and Probability', '', NULL, 25),
(52, 'Artificial Intelligence', '', NULL, 26),
(53, 'Economic Theory', '', NULL, 27),
(54, 'Renewable Energy Systems', '', NULL, 28),
(55, 'Electric Vehicles', '', NULL, 29),
(56, 'AI', '', NULL, 30),
(57, 'topic', '', NULL, 32),
(58, 'top', '', NULL, 33),
(59, 'thalasioi ipopotamoi', '', NULL, 34),
(60, 'Provata', '', NULL, 35),
(61, 'assassinations', '', NULL, 36),
(62, 'Bet Predictions', '', NULL, 37);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('student','professor','admin') NOT NULL,
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional_data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Άδειασμα δεδομένων του πίνακα `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `email`, `role`, `additional_data`, `created_at`, `username`, `password`) VALUES
(1, 'Makis', 'Makopoulos', '104333999@students.upatras.gr', 'student', '{\"student_number\":\"10433999\",\"street\":\"test street\",\"number\":\"45\",\"city\":\"test city\",\"postcode\":\"39955\",\"father_name\":\"Orestis\",\"landline_telephone\":\"2610333000\",\"mobile_telephone\":\"6939096979\"}', '2024-12-29 20:37:19', 'us10433999', 'StudentPass123!'),
(2, 'John', 'Lennon', 'st10434000@upnet.gr', 'student', '{\"student_number\":\"10434000\",\"street\":\"Ermou\",\"number\":\"18\",\"city\":\"Athens\",\"postcode\":\"10431\",\"father_name\":\"George\",\"landline_telephone\":\"2610123456\",\"mobile_telephone\":\"6970001112\"}', '2024-12-29 20:37:19', 'us10434000', 'StudentPass123!'),
(3, 'Petros', 'Verikokos', 'st10434001@upnet.gr', 'student', '{\"student_number\":\"10434001\",\"street\":\"Adrianou\",\"number\":\"20\",\"city\":\"Thessaloniki\",\"postcode\":\"54248\",\"father_name\":\"Giannis\",\"landline_telephone\":\"2610778899\",\"mobile_telephone\":\"6970001112\"}', '2024-12-29 20:37:19', 'us10434001', 'StudentPass123!'),
(4, 'test', 'name', 'st10434002@upnet.gr', 'student', '{\"student_number\":\"10434002\",\"street\":\"str\",\"number\":\"1\",\"city\":\"patra\",\"postcode\":\"26222\",\"father_name\":\"father\",\"landline_telephone\":\"2610123456\",\"mobile_telephone\":\"6912345678\"}', '2024-12-29 20:37:19', 'us10434002', 'StudentPass123!'),
(5, 'Robert', 'Smith', 'st10434003@upnet.gr', 'student', '{\"student_number\":\"10434003\",\"street\":\"Fascination\",\"number\":\"17\",\"city\":\"London\",\"postcode\":\"1989\",\"father_name\":\"Alex\",\"landline_telephone\":\"2610251989\",\"mobile_telephone\":\"6902051989\"}', '2024-12-29 20:37:19', 'us10434003', 'StudentPass123!'),
(6, 'Rex', 'Tyrannosaurus', 'st10434004@upnet.gr', 'student', '{\"student_number\":\"10434004\",\"street\":\"Cretaceous\",\"number\":\"2\",\"city\":\"Laramidia\",\"postcode\":\"54321\",\"father_name\":\"Daspletosaurus\",\"landline_telephone\":\"2610432121\",\"mobile_telephone\":\"6911231234\"}', '2024-12-29 20:37:19', 'us10434004', 'StudentPass123!'),
(7, 'Paul', 'Mescal ', 'st10434005@upnet.gr', 'student', '{\"student_number\":\"10434005\",\"street\":\"Smith Str.\",\"number\":\"33\",\"city\":\"New York \",\"postcode\":\"59\",\"father_name\":\"Paul\",\"landline_telephone\":\"-\",\"mobile_telephone\":\"-\"}', '2024-12-29 20:37:19', 'us10434005', 'StudentPass123!'),
(8, 'Pedro', 'Pascal', 'st10434006@upnet.gr', 'student', '{\"student_number\":\"10434006\",\"street\":\"Johnson\",\"number\":\"90\",\"city\":\"New York \",\"postcode\":\"70\",\"father_name\":\"Jos\\u00e9 \",\"landline_telephone\":\"-\",\"mobile_telephone\":\"-\"}', '2024-12-29 20:37:19', 'us10434006', 'StudentPass123!'),
(9, 'David', 'Gilmour', 'st10434007@upnet.gr', 'student', '{\"student_number\":\"10434007\",\"street\":\"Sortef\",\"number\":\"29\",\"city\":\"New York\",\"postcode\":\"26\",\"father_name\":\"Douglas\",\"landline_telephone\":\"-\",\"mobile_telephone\":\"-\"}', '2024-12-29 20:37:19', 'us10434007', 'StudentPass123!'),
(10, 'Lana', 'Del Rey ', 'st10434008@upnet.gr', 'student', '{\"student_number\":\"10434008\",\"street\":\"Groove Str.\",\"number\":\"23\",\"city\":\"Los Angeles\",\"postcode\":\"1\",\"father_name\":\"none\",\"landline_telephone\":\"-\",\"mobile_telephone\":\"-\"}', '2024-12-29 20:37:19', 'us10434008', 'StudentPass123!'),
(11, 'Stevie', 'Nicks', 'st10434009@upnet.gr', 'student', '{\"student_number\":\"10434009\",\"street\":\"Magic Str. \",\"number\":\"8\",\"city\":\"New Orleans\",\"postcode\":\"35\",\"father_name\":\"Jess \",\"landline_telephone\":\"56\",\"mobile_telephone\":\"67\"}', '2024-12-29 20:37:19', 'us10434009', 'StudentPass123!'),
(12, 'Margaret', 'Qualley', 'st10434010@upnet.gr', 'student', '{\"student_number\":\"10434010\",\"street\":\"Substance Str.\",\"number\":\"25\",\"city\":\"Los Angeles \",\"postcode\":\"7\",\"father_name\":\"Paul\",\"landline_telephone\":\"67\",\"mobile_telephone\":\"90\"}', '2024-12-29 20:37:19', 'us10434010', 'StudentPass123!'),
(13, 'Mia', 'Goth', 'st10434011@upnet.gr', 'student', '{\"student_number\":\"10434011\",\"street\":\"Pearl Str. \",\"number\":\"4\",\"city\":\"Michigan\",\"postcode\":\"8\",\"father_name\":\"Lee\",\"landline_telephone\":\"-\",\"mobile_telephone\":\"-\"}', '2024-12-29 20:37:19', 'us10434011', 'StudentPass123!'),
(14, 'Florence ', 'Pugh', 'st10434012@upnet.gr', 'student', '{\"student_number\":\"10434012\",\"street\":\"Midsommar Str. l\",\"number\":\"1\",\"city\":\"Away\",\"postcode\":\"24\",\"father_name\":\"-\",\"landline_telephone\":\"5\",\"mobile_telephone\":\"2\"}', '2024-12-29 20:37:19', 'us10434012', 'StudentPass123!'),
(15, 'PJ ', 'Harvey', 'st10434013@upnet.gr', 'student', '{\"student_number\":\"10434013\",\"street\":\"Lonely Str.\",\"number\":\"27\",\"city\":\"Bridport\",\"postcode\":\"-7\",\"father_name\":\"Ray\",\"landline_telephone\":\"56\",\"mobile_telephone\":\"43\"}', '2024-12-29 20:37:19', 'us10434013', 'StudentPass123!'),
(16, 'Penélope', 'Cruz', 'st10434014@upnet.gr', 'student', '{\"student_number\":\"10434014\",\"street\":\"Almadovar\",\"number\":\"55\",\"city\":\"Madrid\",\"postcode\":\"23\",\"father_name\":\"Eduardo \",\"landline_telephone\":\"5\",\"mobile_telephone\":\"4\"}', '2024-12-29 20:37:19', 'us10434014', 'StudentPass123!'),
(17, 'Emma', 'Stone', 'st10434015@upnet.gr', 'student', '{\"student_number\":\"10434015\",\"street\":\"Poor Str.\",\"number\":\"3\",\"city\":\"Paris \",\"postcode\":\"34\",\"father_name\":\"none\",\"landline_telephone\":\"2333333\",\"mobile_telephone\":\"4455555\"}', '2024-12-29 20:37:19', 'us10434015', 'StudentPass123!'),
(18, 'Jenny', 'Vanou', 'st10434016@upnet.gr', 'student', '{\"student_number\":\"10434016\",\"street\":\"Mpouat Str.\",\"number\":\"23\",\"city\":\"Athens\",\"postcode\":\"10\",\"father_name\":\"Basil\",\"landline_telephone\":\"09\",\"mobile_telephone\":\"45\"}', '2024-12-29 20:37:19', 'us10434016', 'StudentPass123!'),
(19, 'Salma ', 'Hayek', 'st10434017@upnet.gr', 'student', '{\"student_number\":\"10434017\",\"street\":\"Desperado Str. \",\"number\":\"24\",\"city\":\"Madrid \",\"postcode\":\"656\",\"father_name\":\"Sami\",\"landline_telephone\":\"344\",\"mobile_telephone\":\"221\"}', '2024-12-29 20:37:19', 'us10434017', 'StudentPass123!'),
(20, 'Julie ', 'Delpy', 'st10434018@upnet.gr', 'student', '{\"student_number\":\"10434018\",\"street\":\"Before Str.\",\"number\":\"36\",\"city\":\"Paris\",\"postcode\":\"567\",\"father_name\":\"Kie\\u015blowski\",\"landline_telephone\":\"1223\",\"mobile_telephone\":\"3455\"}', '2024-12-29 20:37:19', 'us10434018', 'StudentPass123!'),
(21, 'Giannis', 'Aggelakas', 'st10434019@upnet.gr', 'student', '{\"student_number\":\"10434019\",\"street\":\"Trypes Str.\",\"number\":\"3\",\"city\":\"Athens\",\"postcode\":\"2354\",\"father_name\":\"Theos\",\"landline_telephone\":\"23\",\"mobile_telephone\":\"45\"}', '2024-12-29 20:37:19', 'us10434019', 'StudentPass123!'),
(22, 'Eleutheria ', 'Arvanitaki', 'st10434020@upnet.gr', 'student', '{\"student_number\":\"10434020\",\"street\":\"Entexno Str. \",\"number\":\"2\",\"city\":\"Athens\",\"postcode\":\"345\",\"father_name\":\"Kosmos\",\"landline_telephone\":\"657\",\"mobile_telephone\":\"345\"}', '2024-12-29 20:37:19', 'us10434020', 'StudentPass123!'),
(23, 'Marina', 'Spanou', 'st10434021@upnet.gr', 'student', '{\"student_number\":\"10434021\",\"street\":\"Pagkrati Str.\",\"number\":\"25\",\"city\":\"Athens\",\"postcode\":\"2456\",\"father_name\":\"Gates\",\"landline_telephone\":\"897\",\"mobile_telephone\":\"354\"}', '2024-12-29 20:37:19', 'us10434021', 'StudentPass123!'),
(24, 'Rena', 'Koumioti', 'st10434022@upnet.gr', 'student', '{\"student_number\":\"10434022\",\"street\":\"Mpouat Str.\",\"number\":\"24\",\"city\":\"Athens\",\"postcode\":\"5749\",\"father_name\":\"Ellhniko\",\"landline_telephone\":\"23557\",\"mobile_telephone\":\"32453\"}', '2024-12-29 20:37:19', 'us10434022', 'StudentPass123!'),
(25, 'Charlotte', 'Aitchison', 'st10434023@upnet.gr', 'student', '{\"student_number\":\"10434023\",\"street\":\"Boiler Room St\",\"number\":\"365\",\"city\":\"New York\",\"postcode\":\"360\",\"father_name\":\"Jon\",\"landline_telephone\":\"2610365365\",\"mobile_telephone\":\"693653365\"}', '2024-12-29 20:37:19', 'us10434023', 'StudentPass123!'),
(26, 'Rhaenyra', 'Targaryen', 'st10434024@upnet.gr', 'student', '{\"student_number\":\"10434024\",\"street\":\"Dragon St\",\"number\":\"2021\",\"city\":\"Kings Landing\",\"postcode\":\"2021\",\"father_name\":\"Viserys\",\"landline_telephone\":\"2610101010\",\"mobile_telephone\":\"6910101010\"}', '2024-12-29 20:37:19', 'us10434024', 'StudentPass123!'),
(27, 'Ben', 'Dover', 'st10434025@upnet.gr', 'student', '{\"student_number\":\"10434025\",\"street\":\"Colon Str.\",\"number\":\"124A\",\"city\":\"NY\",\"postcode\":\"11045\",\"father_name\":\"Carlos\",\"landline_telephone\":\"2584694587\",\"mobile_telephone\":\"5841852384\"}', '2024-12-29 20:37:19', 'us10434025', 'StudentPass123!'),
(28, 'Marios', 'Papadakis', 'st10434026@upnet.gr', 'student', '{\"student_number\":\"10434026\",\"street\":\"Korinthou\",\"number\":\"266\",\"city\":\"Patras\",\"postcode\":\"26223\",\"father_name\":\"Ioannis\",\"landline_telephone\":\"+302105562567\",\"mobile_telephone\":\"+306975562567\"}', '2024-12-29 20:37:19', 'us10434026', 'StudentPass123!'),
(29, 'Nicholas ', 'Hoult', 'st10434027@upnet.gr', 'student', '{\"student_number\":\"10434027\",\"street\":\"Nosferatu Str.\",\"number\":\"34\",\"city\":\"London\",\"postcode\":\"567\",\"father_name\":\"Roger\",\"landline_telephone\":\"436\",\"mobile_telephone\":\"46478\"}', '2024-12-29 20:37:19', 'us10434027', 'StudentPass123!'),
(30, 'Joo Hyuk', 'Nam', 'st10434028@upnet.gr', 'student', '{\"student_number\":\"10434028\",\"street\":\"Kanakari\",\"number\":\"135\",\"city\":\"Patra\",\"postcode\":\"26440\",\"father_name\":\"Baek Yi Jin\",\"landline_telephone\":\"2610443568\",\"mobile_telephone\":\"6978756432\"}', '2024-12-29 20:37:19', 'us10434028', 'StudentPass123!'),
(31, 'Nikos', 'Peletie', 'st10434029@upnet.gr', 'student', '{\"student_number\":\"10434029\",\"street\":\"Kolokotroni\",\"number\":\"6\",\"city\":\"Athens\",\"postcode\":\"34754\",\"father_name\":\"George\",\"landline_telephone\":\"2104593844\",\"mobile_telephone\":\"6987655433\"}', '2024-12-29 20:37:19', 'us10434029', 'StudentPass123!'),
(32, 'Nikos', 'Koukos', 'st10434030@upnet.gr', 'student', '{\"student_number\":\"10434030\",\"street\":\"Triton\",\"number\":\"12\",\"city\":\"Salamina\",\"postcode\":\"12216\",\"father_name\":\"Giannis\",\"landline_telephone\":\"210553985\",\"mobile_telephone\":\"6946901012\"}', '2024-12-29 20:37:19', 'us10434030', 'StudentPass123!'),
(33, 'Maria', 'Fouseki', 'st10434031@upnet.gr', 'student', '{\"student_number\":\"10434031\",\"street\":\"Jason \",\"number\":\"33\",\"city\":\"London\",\"postcode\":\"44391\",\"father_name\":\"Tasos\",\"landline_telephone\":\"2109993719\",\"mobile_telephone\":\"6923144642\"}', '2024-12-29 20:37:19', 'us10434031', 'StudentPass123!'),
(34, 'Nikos ', 'Korobos', 'st10434032@upnet.gr', 'student', '{\"student_number\":\"10434032\",\"street\":\"Masalias\",\"number\":\"4\",\"city\":\"Sparti\",\"postcode\":\"32095\",\"father_name\":\"Giannis\",\"landline_telephone\":\"2279036758\",\"mobile_telephone\":\"6948308576\"}', '2024-12-29 20:37:19', 'us10434032', 'StudentPass123!'),
(35, 'Maria', 'Togia', 'st10434033@upnet.gr', 'student', '{\"student_number\":\"10434033\",\"street\":\"Athinon\",\"number\":\"4\",\"city\":\"Athens\",\"postcode\":\"28482\",\"father_name\":\"Petros\",\"landline_telephone\":\"2100393022\",\"mobile_telephone\":\"6953782102\"}', '2024-12-29 20:37:19', 'us10434033', 'StudentPass123!'),
(36, 'Giorgos', 'Menegakis', 'st10434034@upnet.gr', 'student', '{\"student_number\":\"10434034\",\"street\":\"korinthou\",\"number\":\"56\",\"city\":\"patras\",\"postcode\":\"56892\",\"father_name\":\"nikos\",\"landline_telephone\":\"2610485796\",\"mobile_telephone\":\"6934527125\"}', '2024-12-29 20:37:19', 'us10434034', 'StudentPass123!'),
(37, 'Trakis', 'Giannakopoulos', 'st10434035@upnet.gr', 'student', '{\"student_number\":\"10434035\",\"street\":\"Othonos kai Amalias \",\"number\":\"100\",\"city\":\"Patras\",\"postcode\":\"26500\",\"father_name\":\"None\",\"landline_telephone\":\"2610381393\",\"mobile_telephone\":\"6028371830\"}', '2024-12-29 20:37:19', 'us10434035', 'StudentPass123!'),
(38, 'Chris', 'Kouvadis', 'st10434036@upnet.gr', 'student', '{\"student_number\":\"10434036\",\"street\":\"vanizelou\",\"number\":\"36\",\"city\":\"Patras\",\"postcode\":\"26500\",\"father_name\":\"Pfloutsou\",\"landline_telephone\":\"2610995999\",\"mobile_telephone\":\"6947937524\"}', '2024-12-29 20:37:19', 'us10434036', 'StudentPass123!'),
(39, 'pafloutsou', 'kaskarai', 'st10434037@upnet.gr', 'student', '{\"student_number\":\"10434037\",\"street\":\"kolokotroni\",\"number\":\"12\",\"city\":\"Patras\",\"postcode\":\"26500\",\"father_name\":\"mauragkas\",\"landline_telephone\":\"2610978423\",\"mobile_telephone\":\"6935729345\"}', '2024-12-29 20:37:19', 'us10434037', 'StudentPass123!'),
(40, 'Billy', 'Diesel', 'st10434038@upnet.gr', 'student', '{\"student_number\":\"10434038\",\"street\":\"Alexandras Ave\",\"number\":\"12\",\"city\":\"Athens\",\"postcode\":\"11521\",\"father_name\":\"Iman\",\"landline_telephone\":\"2101234567\",\"mobile_telephone\":\"6912345678\"}', '2024-12-29 20:37:19', 'us10434038', 'StudentPass123!'),
(41, 'Tome', 'of Madness', 'st10434039@upnet.gr', 'student', '{\"student_number\":\"10434039\",\"street\":\"Panepisthmiou\",\"number\":\"69\",\"city\":\"Patras\",\"postcode\":\"26441\",\"father_name\":\"Prafit\",\"landline_telephone\":\"2610654321\",\"mobile_telephone\":\"6969966996\"}', '2024-12-29 20:37:19', 'us10434039', 'StudentPass123!'),
(42, 'fort', 'nite', 'st10434040@upnet.gr', 'student', '{\"student_number\":\"10434040\",\"street\":\"karaiskakis\",\"number\":\"69\",\"city\":\"tilted tower\",\"postcode\":\"4747\",\"father_name\":\"epic games\",\"landline_telephone\":\"2610747474\",\"mobile_telephone\":\"6988112233\"}', '2024-12-29 20:37:19', 'us10434040', 'StudentPass123!'),
(43, 'Zeus', 'Ikosaleptos', 'st10434041@upnet.gr', 'student', '{\"student_number\":\"10434041\",\"street\":\"Novi\",\"number\":\"25\",\"city\":\"Athens\",\"postcode\":\"20033\",\"father_name\":\"Kleft\",\"landline_telephone\":\"2109090901\",\"mobile_telephone\":\"6900008005\"}', '2024-12-29 20:37:19', 'us10434041', 'StudentPass123!'),
(44, 'AG', 'Cook', 'st10434042@upnet.gr', 'student', '{\"student_number\":\"10434042\",\"street\":\"Britpop\",\"number\":\"7G\",\"city\":\"London\",\"postcode\":\"2021\",\"father_name\":\"PC Music\",\"landline_telephone\":\"2121212121\",\"mobile_telephone\":\"1212121212\"}', '2024-12-29 20:37:19', 'us10434042', 'StudentPass123!'),
(45, 'Maria', 'Mahmood', 'st10434043@upnet.gr', 'student', '{\"student_number\":\"10434043\",\"street\":\"Mouratidi\",\"number\":\"4\",\"city\":\"New York\",\"postcode\":\"25486\",\"father_name\":\"Paparizou\",\"landline_telephone\":\"2108452666\",\"mobile_telephone\":\"6980081351\"}', '2024-12-29 20:37:19', 'us10434043', 'StudentPass123!'),
(46, 'Kostas', 'Poupis', 'st10434044@upnet.gr', 'student', '{\"student_number\":\"10434044\",\"street\":\"Ag Kiriakis\",\"number\":\"11\",\"city\":\"Papaou\",\"postcode\":\"50501\",\"father_name\":\"Aelakis\",\"landline_telephone\":\"222609123\",\"mobile_telephone\":\"698452154\"}', '2024-12-29 20:37:19', 'us10434044', 'StudentPass123!'),
(47, 'Hugh', 'Jass', 'st10434045@upnet.gr', 'student', '{\"student_number\":\"10434045\",\"street\":\"Wall Street\",\"number\":\"69\",\"city\":\"Jerusalem\",\"postcode\":\"478\",\"father_name\":\"Mike Oxlong\",\"landline_telephone\":\"69696969\",\"mobile_telephone\":\"696969420\"}', '2024-12-29 20:37:19', 'us10434045', 'StudentPass123!'),
(48, 'Xontro ', 'Pigouinaki', 'st10434046@upnet.gr', 'student', '{\"student_number\":\"10434046\",\"street\":\"Krasopotirou\",\"number\":\"69\",\"city\":\"Colarato\",\"postcode\":\"14121\",\"father_name\":\"Adolf Heisenberg\",\"landline_telephone\":\"6913124205\",\"mobile_telephone\":\"4747859625\"}', '2024-12-29 20:37:19', 'us10434046', 'StudentPass123!'),
(49, 'Μaria', 'Nikolaou', 'st10434047@upnet.gr', 'student', '{\"student_number\":\"10434047\",\"street\":\"Achilleos\",\"number\":\"21\",\"city\":\"Athens\",\"postcode\":\"10437\",\"father_name\":\"Dimitris\",\"landline_telephone\":\"2109278907\",\"mobile_telephone\":\"6945533213\"}', '2024-12-29 20:37:19', 'us10434047', 'StudentPass123!'),
(50, 'Eleni', 'Fotiou', 'st10434048@upnet.gr', 'student', '{\"student_number\":\"10434048\",\"street\":\"Adrianou \",\"number\":\"65\",\"city\":\"Athens\",\"postcode\":\"10556\",\"father_name\":\"Nikos\",\"landline_telephone\":\"2108745645\",\"mobile_telephone\":\"6978989000\"}', '2024-12-29 20:37:19', 'us10434048', 'StudentPass123!'),
(51, 'Xara', 'Fanouriou', 'st10434049@upnet.gr', 'student', '{\"student_number\":\"10434049\",\"street\":\"Chaonias \",\"number\":\"54\",\"city\":\"Athens\",\"postcode\":\"10441\",\"father_name\":\"Petros\",\"landline_telephone\":\"2108724324\",\"mobile_telephone\":\"6945622222\"}', '2024-12-29 20:37:19', 'us10434049', 'StudentPass123!'),
(52, 'Nikos', 'Panagiotou', 'st10434050@upnet.gr', 'student', '{\"student_number\":\"10434050\",\"street\":\"Chomatianou\",\"number\":\"32\",\"city\":\"Athens\",\"postcode\":\"10439\",\"father_name\":\"Giorgos\",\"landline_telephone\":\"2107655555\",\"mobile_telephone\":\"6941133333\"}', '2024-12-29 20:37:19', 'us10434050', 'StudentPass123!'),
(53, 'Petros', 'Daidalos', 'st10434051@upnet.gr', 'student', '{\"student_number\":\"10434051\",\"street\":\"Dafnidos\",\"number\":\"4\",\"city\":\"Athens\",\"postcode\":\"11364\",\"father_name\":\"Pavlos\",\"landline_telephone\":\"2108534566\",\"mobile_telephone\":\"6976644333\"}', '2024-12-29 20:37:19', 'us10434051', 'StudentPass123!'),
(54, 'Giannis', 'Ioannou', 'st10434052@upnet.gr', 'student', '{\"student_number\":\"10434052\",\"street\":\"Danais\",\"number\":\"9\",\"city\":\"Athens\",\"postcode\":\"11631\",\"father_name\":\"Kostas\",\"landline_telephone\":\"2107644999\",\"mobile_telephone\":\"6976565655\"}', '2024-12-29 20:37:19', 'us10434052', 'StudentPass123!'),
(55, 'Tsili', 'Doghouse', 'st10434053@upnet.gr', 'student', '{\"student_number\":\"10434053\",\"street\":\"novi lane\",\"number\":\"33\",\"city\":\"Patras\",\"postcode\":\"26478\",\"father_name\":\"Stoiximan\",\"landline_telephone\":\"2610420420\",\"mobile_telephone\":\"6999999999\"}', '2024-12-29 20:37:19', 'us10434053', 'StudentPass123!'),
(56, 'Marialena', 'Antoniou', 'st10434054@upnet.gr', 'student', '{\"student_number\":\"10434054\",\"street\":\"Ermou\",\"number\":\"24\",\"city\":\"Athens\",\"postcode\":\"10563\",\"father_name\":\"Nikolaos\",\"landline_telephone\":\"210-5678901\",\"mobile_telephone\":\"693-5678901\"}', '2024-12-29 20:37:19', 'us10434054', 'StudentPass123!'),
(57, 'Ioannis', 'Panagiotou', 'st10434055@upnet.gr', 'student', '{\"student_number\":\"10434055\",\"street\":\"Kyprou\",\"number\":\"42\",\"city\":\"Patra\",\"postcode\":\"26441\",\"father_name\":\"Kwstas\",\"landline_telephone\":\"2610-123456\",\"mobile_telephone\":\"698-1234567\"}', '2024-12-29 20:37:19', 'us10434055', 'StudentPass123!'),
(58, 'George', 'Karamalis', 'st10434056@upnet.gr', 'student', '{\"student_number\":\"10434056\",\"street\":\"Kolokotroni\",\"number\":\"10\",\"city\":\"Larissa\",\"postcode\":\"41222\",\"father_name\":\"Petros\",\"landline_telephone\":\"2410-456789\",\"mobile_telephone\":\"697-4567890\"}', '2024-12-29 20:37:19', 'us10434056', 'StudentPass123!'),
(59, 'Kyriakos', 'Papapetrou', 'st10434057@upnet.gr', 'student', '{\"student_number\":\"10434057\",\"street\":\"Zakunthou\",\"number\":\"36\",\"city\":\"Volos\",\"postcode\":\"10654\",\"father_name\":\"Apostolos\",\"landline_telephone\":\"210-6789012\",\"mobile_telephone\":\"695-6789012\"}', '2024-12-29 20:37:19', 'us10434057', 'StudentPass123!'),
(60, 'Maria', 'Kp', 'st10434058@upnet.gr', 'student', '{\"student_number\":\"10434058\",\"street\":\"pelopidas \",\"number\":\"52\",\"city\":\"patra\",\"postcode\":\"28746\",\"father_name\":\"george\",\"landline_telephone\":\"2610555555\",\"mobile_telephone\":\"6932323232\"}', '2024-12-29 20:37:19', 'us10434058', 'StudentPass123!'),
(61, 'Nikos', 'papadopoulos', 'st10434059@upnet.gr', 'student', '{\"student_number\":\"10434059\",\"street\":\"anapafseos\",\"number\":\"34\",\"city\":\"patra\",\"postcode\":\"26503\",\"father_name\":\"takis\",\"landline_telephone\":\"2691045092\",\"mobile_telephone\":\"69090909\"}', '2024-12-29 20:37:19', 'us10434059', 'StudentPass123!'),
(62, 'Giannis ', 'Molotof', 'st10434060@upnet.gr', 'student', '{\"student_number\":\"10434060\",\"street\":\"Ermou\",\"number\":\"34\",\"city\":\"Patras\",\"postcode\":\"29438\",\"father_name\":\"Giorgos\",\"landline_telephone\":\"2610254390\",\"mobile_telephone\":\"6943126767\"}', '2024-12-29 20:37:19', 'us10434060', 'StudentPass123!'),
(63, 'Sagdy', 'Znuts', 'st10434061@upnet.gr', 'student', '{\"student_number\":\"10434061\",\"street\":\"Grove\",\"number\":\"12\",\"city\":\"San Andreas\",\"postcode\":\"123456\",\"father_name\":\"NULL\",\"landline_telephone\":\"123456789\",\"mobile_telephone\":\"123456789\"}', '2024-12-29 20:37:19', 'us10434061', 'StudentPass123!'),
(64, 'Mary', 'Poppins', 'st10434062@upnet.gr', 'student', '{\"student_number\":\"10434062\",\"street\":\"Niktolouloudias \",\"number\":\"123\",\"city\":\"Chalkida\",\"postcode\":\"23456\",\"father_name\":\"George\",\"landline_telephone\":\"2613456089\",\"mobile_telephone\":\"6980987654\"}', '2024-12-29 20:37:19', 'us10434062', 'StudentPass123!'),
(65, 'Tinker', 'Bell', 'st10434063@upnet.gr', 'student', '{\"student_number\":\"10434063\",\"street\":\"Vatomourias\",\"number\":\"55\",\"city\":\"Pano Raxoula\",\"postcode\":\"2345\",\"father_name\":\"Mixail\",\"landline_telephone\":\"2456034567\",\"mobile_telephone\":\"6987543345\"}', '2024-12-29 20:37:19', 'us10434063', 'StudentPass123!'),
(66, 'Lilly', 'Bloom', 'st10434064@upnet.gr', 'student', '{\"student_number\":\"10434064\",\"street\":\"Patnanasis\",\"number\":\"45\",\"city\":\"Patra\",\"postcode\":\"26440\",\"father_name\":\"Menelaos\",\"landline_telephone\":\"2610435988\",\"mobile_telephone\":\"6987555433\"}', '2024-12-29 20:37:19', 'us10434064', 'StudentPass123!'),
(67, 'GIORGOS', 'MASOURAS', 'st10434065@upnet.gr', 'student', '{\"student_number\":\"10434065\",\"street\":\"AGIOU IOANNNI RENTI\",\"number\":\"7\",\"city\":\"PEIRAIAS\",\"postcode\":\"47200\",\"father_name\":\"PETROS\",\"landline_telephone\":\"694837204\",\"mobile_telephone\":\"210583603\"}', '2024-12-29 20:37:19', 'us10434065', 'StudentPass123!'),
(68, 'KENDRICK', 'NUNN', 'st10434066@upnet.gr', 'student', '{\"student_number\":\"10434066\",\"street\":\"OAKA\",\"number\":\"25\",\"city\":\"ATHENS\",\"postcode\":\"666\",\"father_name\":\"GIANNAKOPOULOS\",\"landline_telephone\":\"6982736199\",\"mobile_telephone\":\"6906443321\"}', '2024-12-29 20:37:19', 'us10434066', 'StudentPass123!'),
(69, 'Depeche', 'Mode', 'st10434067@upnet.gr', 'student', '{\"student_number\":\"10434067\",\"street\":\"Enjoy The Silence\",\"number\":\"1990\",\"city\":\"London\",\"postcode\":\"1990\",\"father_name\":\"Dave\",\"landline_telephone\":\"1234567890\",\"mobile_telephone\":\"1234567770\"}', '2024-12-29 20:37:19', 'us10434067', 'StudentPass123!'),
(70, 'name', 'surname', 'st10434068@upnet.gr', 'student', '{\"student_number\":\"10434068\",\"street\":\"your\",\"number\":\"69\",\"city\":\"mom\",\"postcode\":\"15584\",\"father_name\":\"father\",\"landline_telephone\":\"222\",\"mobile_telephone\":\"2223\"}', '2024-12-29 20:37:19', 'us10434068', 'StudentPass123!'),
(71, 'Nikos', 'Kosmopoulos', 'st10434069@upnet.gr', 'student', '{\"student_number\":\"10434069\",\"street\":\"Araksou\",\"number\":\"12\",\"city\":\"Giotopoli\",\"postcode\":\"69420\",\"father_name\":\"Greg\",\"landline_telephone\":\"210 9241993\",\"mobile_telephone\":\"6978722312\"}', '2024-12-29 20:37:19', 'us10434069', 'StudentPass123!'),
(72, 'Aris', 'Poupis', 'st10434070@upnet.gr', 'student', '{\"student_number\":\"10434070\",\"street\":\"Mpofa\",\"number\":\"10\",\"city\":\"Kolonia\",\"postcode\":\"12345\",\"father_name\":\"Mpamias\",\"landline_telephone\":\"2105858858\",\"mobile_telephone\":\"6935358553\"}', '2024-12-29 20:37:19', 'us10434070', 'StudentPass123!'),
(73, 'Andreas', 'Komninos', 'akomninos@ceid.upatras.gr', 'professor', '{\"topic\":\"Network-centric systems\",\"landline\":\"2610996915\",\"mobile\":\"6977998877\",\"department\":\"CEID\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor73', 'ProfessorPass123!'),
(74, 'Vasilis', 'Foukaras', 'vasfou@ceid.upatras.gr', 'professor', '{\"topic\":\"Integrated Systems\",\"landline\":\"2610885511\",\"mobile\":\"6988812345\",\"department\":\"CEID\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor74', 'ProfessorPass123!'),
(75, 'Basilis', 'Karras', 'karras@nterti.com', 'professor', '{\"topic\":\"Artificial Intelligence\",\"landline\":\"23\",\"mobile\":\"545\",\"department\":\"CEID\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor75', 'ProfessorPass123!'),
(76, 'Eleni', 'Voyiatzaki', 'eleni@ceid.gr', 'professor', '{\"topic\":\"WEB\",\"landline\":\"34\",\"mobile\":\"245\",\"department\":\"CEID\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor76', 'ProfessorPass123!'),
(77, 'Andrew', 'Hozier Byrne', 'hozier@ceid.upatras.gr', 'professor', '{\"topic\":\"Artificial Intelligence\",\"landline\":\"2610170390\",\"mobile\":\"6917031990\",\"department\":\"CEID\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor77', 'ProfessorPass123!'),
(78, 'Nikos', 'Korobos', 'nikos.korobos12@gmail.com', 'professor', '{\"topic\":\"Data Engineering\",\"landline\":\"2610324365\",\"mobile\":\"6978530352\",\"department\":\"IT\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor78', 'ProfessorPass123!'),
(79, 'Kostas', 'Karanikolos', 'kostkaranik@gmail.com', 'professor', '{\"topic\":\"informatics\",\"landline\":\"2610324242\",\"mobile\":\"6934539920\",\"department\":\"CEID\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor79', 'ProfessorPass123!'),
(80, 'Mpampis', 'Sougias', 'mpampis123@gmail.com', 'professor', '{\"topic\":\"Arxeologia\",\"landline\":\"2610945934\",\"mobile\":\"6947845334\",\"department\":\"Arxeologias\",\"university\":\"UOI\"}', '2024-12-29 20:37:19', 'professor80', 'ProfessorPass123!'),
(81, 'Daskalos', 'Makaveli', 'makavelibet@gmail.com', 'professor', '{\"topic\":\"Business\",\"landline\":\"2310231023\",\"mobile\":\"6929349285\",\"department\":\"Economics\",\"university\":\"UOA\"}', '2024-12-29 20:37:19', 'professor81', 'ProfessorPass123!'),
(82, 'Maria', 'Palami', 'palam@upatras.gr', 'professor', '{\"topic\":\"SQL injections\",\"landline\":\"1234567890\",\"mobile\":\"6988223322\",\"department\":\"Engineering\",\"university\":\"University of SKG\"}', '2024-12-29 20:37:19', 'professor82', 'ProfessorPass123!'),
(83, 'Meni', 'Talaiporimeni', 'meniT@upatras.gr', 'professor', '{\"topic\":\"t\",\"landline\":\"2610333999\",\"mobile\":\"6999990999\",\"department\":\"CEID\",\"university\":\"UoP\"}', '2024-12-29 20:37:19', 'professor83', 'ProfessorPass123!'),
(84, 'Tzouli', 'Alexandratou', 'tzouli.ax@upatras.gr', 'professor', '{\"topic\":\"Big Data\",\"landline\":\"2264587412\",\"mobile\":\"6996116921\",\"department\":\"CEID\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor84', 'ProfessorPass123!'),
(85, 'Karikhs', 'Raftel', 'karikhs@yahoo.gr', 'professor', '{\"topic\":\"Pharmaceutical Drugs\",\"landline\":\"69\",\"mobile\":\"6945258923\",\"department\":\"Chemistry\",\"university\":\"University of Streets\"}', '2024-12-29 20:37:19', 'professor85', 'ProfessorPass123!'),
(86, 'Vlasis', 'Restas', 'toxrusoftiari@funerals.gr', 'professor', '{\"topic\":\"Nekro8aftiki\",\"landline\":\"78696910\",\"mobile\":\"69696964\",\"department\":\"Nekro8aftikis\",\"university\":\"University Of Ohio\"}', '2024-12-29 20:37:19', 'professor86', 'ProfessorPass123!'),
(87, 'Fat ', 'Banker', 'fatbanker@kapitalas.gr', 'professor', '{\"topic\":\"kippah\",\"landline\":\"6942014121\",\"mobile\":\"6969784205\",\"department\":\"Froutemporiki\",\"university\":\"University of Israel\"}', '2024-12-29 20:37:19', 'professor87', 'ProfessorPass123!'),
(88, 'Hamze', 'Mohamed', 'info@hamzat.gr', 'professor', '{\"topic\":\"Logistics\",\"landline\":\"1245789513\",\"mobile\":\"1456983270\",\"department\":\"Social Rehabitation\",\"university\":\"University of UAE\"}', '2024-12-29 20:37:19', 'professor88', 'ProfessorPass123!'),
(89, 'Stefania', 'Nikolaou', 'snikolaou@upatras.gr', 'professor', '{\"topic\":\"Information Theory\",\"landline\":\"2106723456\",\"mobile\":\"6942323452\",\"department\":\"ECE\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor89', 'ProfessorPass123!'),
(90, 'Petros', 'Danezis', 'pdanezis@upatras.gr', 'professor', '{\"topic\":\"Telecommunication Electronics\",\"landline\":\"2610908888\",\"mobile\":\"6971142424\",\"department\":\"ECE\",\"university\":\"University of Patras\\t\"}', '2024-12-29 20:37:19', 'professor90', 'ProfessorPass123!'),
(91, 'Papadopoulos ', 'Eustathios', 'eustratiospap@gmail.com', 'professor', '{\"topic\":\"Physics\",\"landline\":\"210-1234567\",\"mobile\":\"690-1234567\",\"department\":\"Physics\",\"university\":\"National and Kapodistrian University of Athens\"}', '2024-12-29 20:37:19', 'professor91', 'ProfessorPass123!'),
(92, 'Konstantinou', 'Maria', 'mariakon@gmail.com', 'professor', '{\"topic\":\"Statistics and Probability\",\"landline\":\"2310-7654321\",\"mobile\":\"694-7654321\",\"department\":\"Mathematics\",\"university\":\"Aristotle University of Thessaloniki\"}', '2024-12-29 20:37:19', 'professor92', 'ProfessorPass123!'),
(93, 'Jim', 'Nikolaou', 'jimnik@gmail.com', 'professor', '{\"topic\":\"Artificial Intelligence\",\"landline\":\"2610-9876543\",\"mobile\":\"697-9876543\",\"department\":\"Computer Science\",\"university\":\"University of Patras\"}', '2024-12-29 20:37:19', 'professor93', 'ProfessorPass123!'),
(94, 'Sophia', 'Michailidi', 'sophiamich@gmail.com', 'professor', '{\"topic\":\"Economic Theory\",\"landline\":\"2310-5432109\",\"mobile\":\"698-5432109\",\"department\":\"Economics\",\"university\":\"Athens University of Economics and Business\"}', '2024-12-29 20:37:19', 'professor94', 'ProfessorPass123!'),
(95, 'Michael ', 'Papadreou', 'michaelpap@gmail.com', 'professor', '{\"topic\":\"Renewable Energy Systems\",\"landline\":\"2610-4455667\",\"mobile\":\"697-4455667\",\"department\":\"Electrical Engineering\",\"university\":\"University of Ioannina\"}', '2024-12-29 20:37:19', 'professor95', 'ProfessorPass123!'),
(96, 'Elon', 'Musk', 'elonmusk@gmail.com', 'professor', '{\"topic\":\"Electric Vehicles\",\"landline\":\"1-888-518-3752\",\"mobile\":\"Null\",\"department\":\"Department of Physics\",\"university\":\"University of Pennsylvania, Philadelphia\"}', '2024-12-29 20:37:19', 'professor96', 'ProfessorPass123!'),
(97, 'Kostas', 'Kalantas', 'abcdef@example.com', 'professor', '{\"topic\":\"AI\",\"landline\":\"2610121212\",\"mobile\":\"6912121212\",\"department\":\"department\",\"university\":\"University\"}', '2024-12-29 20:37:19', 'professor97', 'ProfessorPass123!'),
(98, 'Giorgis', 'Fousekis', 'abcdefg@example.com', 'professor', '{\"topic\":\"topic\",\"landline\":\"land\",\"mobile\":\"mob\",\"department\":\"dep\",\"university\":\"university\"}', '2024-12-29 20:37:19', 'professor98', 'ProfessorPass123!'),
(99, 'Nikos', 'Koukos', 'exxample@example.com', 'professor', '{\"topic\":\"top\",\"landline\":\"la\",\"mobile\":\"mo\",\"department\":\"de\",\"university\":\"university\"}', '2024-12-29 20:37:19', 'professor99', 'ProfessorPass123!'),
(100, 'patrick', 'xrusopsaros', 'patric@xrusopsaros.com', 'professor', '{\"topic\":\"thalasioi ipopotamoi\",\"landline\":\"2610567917\",\"mobile\":\"6952852742\",\"department\":\"Solomos\",\"university\":\"Nemo\"}', '2024-12-29 20:37:19', 'professor100', 'ProfessorPass123!'),
(101, 'Paraskevas', 'koutsikos', 'paraskevas@kobres.ath', 'professor', '{\"topic\":\"Provata\",\"landline\":\"2298042035\",\"mobile\":\"6969696969\",\"department\":\"Ktinotrofia\",\"university\":\"University of Methana\"}', '2024-12-29 20:37:19', 'professor101', 'ProfessorPass123!'),
(102, 'Ezio', 'Auditore da Firenze', 'masterassassin@upatras.ceid.gr', 'professor', '{\"topic\":\"assassinations\",\"landline\":\"null\",\"mobile\":\"null\",\"department\":\"Monterigioni\",\"university\":\"University of Assasinos\"}', '2024-12-29 20:37:19', 'professor102', 'ProfessorPass123!'),
(103, 'Sotiris', 'Panaikas', 'spana@hotmail.com', 'professor', '{\"topic\":\"Bet Predictions\",\"landline\":\"1235654899\",\"mobile\":\"2310521010\",\"department\":\"opap\",\"university\":\"London\"}', '2024-12-29 20:37:19', 'professor103', 'ProfessorPass123!'),
(109, 'Aris', 'Gatas', 'arisgatas@gmail.com', 'admin', NULL, '2025-01-11 11:53:25', 'admin109', 'AdminPass123!'),
(110, 'Katia', 'Makri', 'katiamakri@gmail.com', 'admin', NULL, '2025-01-11 11:47:58', 'admin110', 'AdminPass123!'),
(111, 'Kostas', 'Papadopoulos', 'kostaspap@yahoo.com', 'admin', NULL, '2025-01-11 11:50:12', 'admin111', 'AdminPass123!'),
(114, 'Iosif', 'Papadakis', 'spapadakis@gmail.com', 'admin', NULL, '2025-01-11 11:51:48', 'admin114', 'AdminPass123!'),
(115, 'Ilia', 'Filopoulou', 'iliafil@yahoo.com', 'admin', NULL, '2025-01-11 11:54:14', 'admin115', 'AdminPass123!'),
(116, 'Thalia', 'Simou', 'thsimou@gmail.com', 'admin', NULL, '2025-01-11 11:52:36', 'admin116', 'AdminPass123!');

--
-- Δείκτες `users`
--
DELIMITER $$
CREATE TRIGGER `set_password_on_insert` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    SET NEW.password = SHA2(UUID(), 20);
END
$$
DELIMITER ;

--
-- Ευρετήρια για άχρηστους πίνακες
--

--
-- Ευρετήρια για πίνακα `actionlogs`
--
ALTER TABLE `actionlogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `assignment_id` (`assignment_id`);

--
-- Ευρετήρια για πίνακα `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_id` (`assignment_id`);

--
-- Ευρετήρια για πίνακα `committees`
--
ALTER TABLE `committees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_id` (`assignment_id`),
  ADD KEY `lecturer_id` (`lecturer_id`);

--
-- Ευρετήρια για πίνακα `diplomaassignments`
--
ALTER TABLE `diplomaassignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `thesis_id` (`thesis_id`);

--
-- Ευρετήρια για πίνακα `invitations`
--
ALTER TABLE `invitations`
  ADD PRIMARY KEY (`invitation_id`),
  ADD KEY `theses_id` (`theses_id`),
  ADD KEY `invited_by` (`invited_by`),
  ADD KEY `invitee_id` (`invitee_id`);

--
-- Ευρετήρια για πίνακα `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_id` (`assignment_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Ευρετήρια για πίνακα `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`stat_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Ευρετήρια για πίνακα `theses`
--
ALTER TABLE `theses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `fk_thesis_topic` (`topic_id`);

--
-- Ευρετήρια για πίνακα `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`topic_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Ευρετήρια για πίνακα `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT για άχρηστους πίνακες
--

--
-- AUTO_INCREMENT για πίνακα `actionlogs`
--
ALTER TABLE `actionlogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT για πίνακα `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT για πίνακα `committees`
--
ALTER TABLE `committees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT για πίνακα `diplomaassignments`
--
ALTER TABLE `diplomaassignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT για πίνακα `invitations`
--
ALTER TABLE `invitations`
  MODIFY `invitation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT για πίνακα `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT για πίνακα `statistics`
--
ALTER TABLE `statistics`
  MODIFY `stat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT για πίνακα `theses`
--
ALTER TABLE `theses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT για πίνακα `topics`
--
ALTER TABLE `topics`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT για πίνακα `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- Περιορισμοί για άχρηστους πίνακες
--

--
-- Περιορισμοί για πίνακα `actionlogs`
--
ALTER TABLE `actionlogs`
  ADD CONSTRAINT `actionlogs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `actionlogs_ibfk_2` FOREIGN KEY (`assignment_id`) REFERENCES `diplomaassignments` (`id`) ON DELETE SET NULL;

--
-- Περιορισμοί για πίνακα `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `diplomaassignments` (`id`) ON DELETE CASCADE;

--
-- Περιορισμοί για πίνακα `committees`
--
ALTER TABLE `committees`
  ADD CONSTRAINT `committees_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `diplomaassignments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `committees_ibfk_2` FOREIGN KEY (`lecturer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Περιορισμοί για πίνακα `diplomaassignments`
--
ALTER TABLE `diplomaassignments`
  ADD CONSTRAINT `diplomaassignments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `diplomaassignments_ibfk_2` FOREIGN KEY (`thesis_id`) REFERENCES `theses` (`id`) ON DELETE CASCADE;

--
-- Περιορισμοί για πίνακα `invitations`
--
ALTER TABLE `invitations`
  ADD CONSTRAINT `invitations_ibfk_1` FOREIGN KEY (`theses_id`) REFERENCES `theses` (`id`),
  ADD CONSTRAINT `invitations_ibfk_2` FOREIGN KEY (`invited_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `invitations_ibfk_3` FOREIGN KEY (`invitee_id`) REFERENCES `users` (`id`);

--
-- Περιορισμοί για πίνακα `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `diplomaassignments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notes_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Περιορισμοί για πίνακα `statistics`
--
ALTER TABLE `statistics`
  ADD CONSTRAINT `statistics_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Περιορισμοί για πίνακα `theses`
--
ALTER TABLE `theses`
  ADD CONSTRAINT `fk_thesis_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `theses_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Περιορισμοί για πίνακα `topics`
--
ALTER TABLE `topics`
  ADD CONSTRAINT `topics_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
