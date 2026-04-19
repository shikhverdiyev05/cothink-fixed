-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2025 at 07:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cothink`
--

-- --------------------------------------------------------

--
-- Table structure for table `article_comment`
--

CREATE TABLE `article_comment` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `comment_text` varchar(300) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `student_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `article_comment`
--

INSERT INTO `article_comment` (`id`, `article_id`, `comment_text`, `parent_id`, `student_id`, `created_at`, `likes`) VALUES
(2, 19, 'Tam da mene lazim olan sey!', 2, 103, '2025-12-08 16:03:21', 16),
(3, 19, 'cox ela meqaledir.', NULL, 1, '2025-12-08 16:04:28', 23);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category` varchar(40) NOT NULL,
  `category_img` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category`, `category_img`) VALUES
(1, 'Proqramlaşdırma', 'physics.svg'),
(2, 'Riyaziyyat', 'math.svg'),
(3, 'Tarix', 'history.svg'),
(4, 'Qrafik Dizayn', 'physics.svg'),
(5, 'Fizika', 'physics.svg');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `comment_text` varchar(400) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `post_id`, `student_id`, `parent_id`, `comment_text`, `created_at`, `likes`) VALUES
(7, 41, 109, NULL, 'Salam, bu melumati haradan elde etmisiz?', '2025-12-11 14:01:36', 12),
(8, 41, 103, NULL, 'Cox maraqlidir!', '2025-12-11 14:02:11', 7);

-- --------------------------------------------------------

--
-- Table structure for table `commentss`
--

CREATE TABLE `commentss` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `comment_text` text NOT NULL,
  `likes` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `commentss`
--

INSERT INTO `commentss` (`id`, `post_id`, `student_id`, `parent_id`, `comment_text`, `likes`, `created_at`) VALUES
(6, 13, 107, NULL, 'Cox Faydali Post Oldu!', 5, '2025-12-10 16:18:27'),
(7, 1, 105, NULL, 'Cox Qesey!', 12, '2025-12-10 16:18:55'),
(8, 8, 109, NULL, 'Men bu postdan cox sey oyrendim\r\n', 0, '2025-12-10 16:28:12'),
(9, 8, 106, 8, 'Mende Hemcinin!', 23, '2025-12-10 16:38:28');

-- --------------------------------------------------------

--
-- Table structure for table `course_comment`
--

CREATE TABLE `course_comment` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `comment_text` varchar(200) NOT NULL,
  `likes` int(11) NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_comment`
--

INSERT INTO `course_comment` (`id`, `course_id`, `student_id`, `comment_text`, `likes`, `created_at`, `parent_id`) VALUES
(1, 1, 102, 'Cox ela kursdur', 233, '0000-00-00 00:00:00.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `course_video`
--

CREATE TABLE `course_video` (
  `video_id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `lesson_title` varchar(100) DEFAULT NULL,
  `video_link` varchar(250) DEFAULT NULL,
  `course_files` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_video`
--

INSERT INTO `course_video` (`video_id`, `course_id`, `category_id`, `lesson_title`, `video_link`, `course_files`) VALUES
(1, 1, 5, 'Nyuttonun II qanunu ', 'https://youtu.be/K4HxNNGx9eg?si=Xx1ijYUbjl8HDhVz', 's'),
(10, 1, 5, 'Nyutonun III qanununu', 'https://youtu.be/fG6lRnJkifY?si=QeESNe8Agy_Tbe0C', 'helelik yoxdi'),
(20, 21, 2, 'Arrays and Linked Lists', 'https://www.youtube.com/watch?v=9oKlB1u2KX4', 'https://example.com/files/arrays_linkedlists.pdf'),
(27, 28, 4, '4kfnkj4knjx;kjr', 'ef;njfkvnlkr;fmkj', NULL),
(28, 29, 4, '4kfnkj4knjx;kjr', 'ef;njfkvnlkr;fmkj', NULL),
(29, 30, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mentors`
--

CREATE TABLE `mentors` (
  `mentor_id` int(11) NOT NULL,
  `mentor_name` char(32) NOT NULL,
  `mentor_email` varchar(100) NOT NULL,
  `mentor_password` char(20) NOT NULL,
  `mentor_username` char(32) NOT NULL,
  `description` varchar(300) NOT NULL,
  `category_id` int(11) NOT NULL,
  `profile_img` varchar(200) NOT NULL,
  `languages` varchar(100) NOT NULL,
  `linkedn_link` varchar(300) NOT NULL,
  `students` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `position` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mentors`
--

INSERT INTO `mentors` (`mentor_id`, `mentor_name`, `mentor_email`, `mentor_password`, `mentor_username`, `description`, `category_id`, `profile_img`, `languages`, `linkedn_link`, `students`, `rating`, `position`) VALUES
(17, 'Turqay', 'nahid_agazade@mail.ru', '20232023', 'agazaadeeeh', 'Men FullStack developerem!', 1, 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=60', 'Azerbaycani', 'https://linkedin.com/in/elvinmath', 45, 230, 'Teacher'),
(18, 'Turqay', 'turqay234@gmail.com', '20022002', 'turrqaayyy', 'Men Frontend developerem!', 2, 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=60', 'Azerbaycani', 'https://linkedin.com/in/elvinmath', 35, 23, 'Developer'),
(21, 'Angelina Jolie', 'aslan34@gmail.com', '20002000', 'nuurllaaann', 'Men Frontend developerem!', 2, 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=60', 'Azerbaycani', 'https://linkedin.com/in/elvinmath', 345, 67, '#online #tehsil'),
(22, 'Nihat', 'rafq34@gmail.com', '10101010', 'nihhaatt', 'Men Frontend developerem!', 2, 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=60', 'Azerbaycani', 'https://linkedin.com/in/elvinmath', 99, 230, ''),
(23, 'Elvin Məmmədov', 'elvin@example.com', 'password123', 'elvinmath', 'Riyaziyyat üzrə təcrübəli müəllim, 10 ildən artıq tədris təcrübəsi.', 1, 'https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=800&q=60', 'Azerbaijani,English', 'https://linkedin.com/in/elvinmath', 120, 5, 'Teacher'),
(24, 'Aysel Əliyeva', 'aysel@example.com', 'password123', 'ayselhistory', 'Tarix üzrə ekspert, qədim və müasir dövrləri öyrədir.', 2, 'https://images.unsplash.com/photo-1502764613149-7f1d229e230f?auto=format&fit=crop&w=800&q=60', 'Azerbaijani,English', 'https://linkedin.com/in/ayselhistory', 95, 5, 'Teacher'),
(25, 'Kamran Həsənov', 'kamran@example.com', 'password123', 'kamrandesign', 'Qrafik dizayn və UX/UI sahəsində peşəkar.', 4, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&q=60', 'Azerbaijani,English', 'https://linkedin.com/in/kamrandesign', 140, 5, 'Designer'),
(26, 'Leyla Quliyeva', 'leyla@example.com', 'password123', 'leylaweb', 'Frontend və JavaScript üzrə təcrübəli mentor.', 3, 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=800&q=60', 'Azerbaijani,English', 'https://linkedin.com/in/leylaweb', 110, 5, 'Developer'),
(27, 'Rəşad Məlikov', 'rashad@example.com', 'password123', 'rashadstats', 'Statistika və məlumat analizi üzrə ekspert mentor.', 1, 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=60', 'Azerbaijani,English', 'https://linkedin.com/in/rashadstats', 130, 5, 'Analyst'),
(28, 'Mail Sixverdiyev', 'mailsxverdiyev@gmail.com', 'mail2004', '', '', 3, '', '', 'ssssssssssssss', 0, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `mentor_article`
--

CREATE TABLE `mentor_article` (
  `article_id` int(11) NOT NULL,
  `article_title` char(40) DEFAULT NULL,
  `mentor_id` int(11) DEFAULT NULL,
  `article_desc` varchar(200) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `article_tags` varchar(100) DEFAULT NULL,
  `article_img` varchar(200) DEFAULT NULL,
  `article_topic` varchar(5000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL,
  `saved` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mentor_article`
--

INSERT INTO `mentor_article` (`article_id`, `article_title`, `mentor_id`, `article_desc`, `category_id`, `article_tags`, `article_img`, `article_topic`, `created_at`, `likes`, `saved`) VALUES
(1, 'IT saheleri', 17, 'IT saheleri uzre umumi melumatlar', 1, '#IT #programming', '', 'Proqramlaşdırma və İnkişaf (Development)\r\n\r\nProqram təminatı yaratmaq, veb saytlar, mobil tətbiqlər və oyunlar hazırlamaqla məşğul olurlar.\r\n\r\nFrontend Development: Veb saytların görünüşünü və interaktiv hissələrini yaradır. (HTML, CSS, JavaScript, React, Vue)\r\n\r\nBackend Development: Server tərəfi, məlumat bazaları və API-lər üzərində işləyir. (Node.js, PHP, Python, Java, C#)\r\n\r\nFull-Stack Development: Həm frontend, həm də backend biliklərinə sahibdir.\r\n\r\nMobile Development: Android və iOS tətbiqləri hazırlayır. (Swift, Kotlin, Flutter, React Native)\r\n\r\nGame Development: Oyun proqramlaşdırması, oyun mühərrikləri ilə işləyir. (Unity, Unreal Engine, C++, C#)\r\n\r\n2️⃣ Məlumat Bazası və Data Sahəsi\r\n\r\nDatabase Administration (DBA): Məlumat bazalarını qurur, idarə edir, optimizasiya edir. (MySQL, PostgreSQL, Oracle)\r\n\r\nData Analyst: Veriləri təhlil edir, hesabatlar hazırlayır.\r\n\r\nData Scientist: Verilərdən model və proqnozlar çıxarır, maşın öyrənməsi tətbiq edir. (Python, R, SQL, Machine Learning)\r\n\r\n3️⃣ Şəbəkə və Sistem İnfrastruktur\r\n\r\nSystem Administrator (SysAdmin): Server və şəbəkələri idarə edir, problemləri həll edir.\r\n\r\nNetwork Engineer: Şəbəkələrin qurulması və idarəsi. (Cisco, Juniper, LAN/WAN, VPN)\r\n\r\nCloud Engineer: Bulud platformaları ilə işləyir. (AWS, Azure, Google Cloud)\r\n\r\n4️⃣ Kiber Təhlükəsizlik (Cybersecurity)\r\n\r\nEthical Hacker / Penetration Tester: Sistemlərin zəifliklərini yoxlayır.\r\n\r\nSecurity Analyst: Şirkət şəbəkəsini və məlumatları qoruyur.\r\n\r\n5️⃣ UX/UI və Dizayn\r\n\r\nUI Designer: İstifadəçi interfeysinin vizual dizaynı.\r\n\r\nUX Designer: İstifadəçi təcrübəsini optimizasiya edir.\r\n\r\nGraphic Designer: Qrafik və vizual kontent yaradır.\r\n\r\n6️⃣ DevOps və Sistem Avtomatlaşdırma\r\n\r\nDevOps mühəndisləri kod yazanlar ilə sistem əməliyyatçıları arasında körpü qurur.\r\n\r\nAvtomatlaşdırma, CI/CD prosesləri, Docker, Kubernetes, Jenkins, Ansible istifadə olunur.\r\n\r\n7️⃣ Süni İntellekt və Maşın Öyrənməsi\r\n\r\nAI Engineer: Maşın öyrənməsi, süni intellekt layihələri hazırlayır.\r\n\r\nNLP, Computer Vision kimi ixtisaslaşmalar var.\r\n\r\n8️⃣ Digər İxtisaslaşmalar\r\n\r\nQA / Test Engineer: Proqram təminatının keyfiyyətini test edir.\r\n\r\nTechnical Support / Help Desk: İstifadəçilərə texniki dəstək verir.\r\n\r\nBlockchain Developer: Smart kontraktlar, kripto layihələri hazırlayır.', '2025-11-30 18:00:39', 0, 0),
(17, 'Riyaziyyatda Loqika', 17, 'Riyaziyyat problemlərində loqikanın rolu və praktiki nümunələr.', 1, 'riyaziyyat,logic,problem-solving', 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e9?auto=format&fit=crop&w=800&q=60', 'Riyaziyyat problemlərində loqikanın rolu və praktiki nümunələr. Burada biz riyaziyyatın gündəlik həyatda necə tətbiq olunduğunu, məsələlərin həll yollarını və maraqlı tapşırıqları ətraflı izah edəcəyik. Məqalə həm tələbələr, həm də mentorlar üçün faydalıdır.', '2025-12-06 21:09:42', 12, 5),
(18, 'Dünya Tarixi Analizi', 18, 'Əsas tarixi hadisələrin analizi və onların təsirləri.', 2, 'tarix,analiz,öyrən', 'https://images.unsplash.com/photo-1598188305253-bfb2d1d5f5ee?auto=format&fit=crop&w=800&q=60', 'Bu məqalədə qədim sivilizasiyaların həyat tərzi, mühüm tarixi hadisələr və onların indiki dövrə təsiri ətraflı şəkildə izah olunacaq. Oxucular tarixi məlumatları sistemli şəkildə öyrənəcək və tarixi analitik bacarıqlarını inkişaf etdirəcəklər.', '2025-12-06 21:09:42', 15, 7),
(19, 'Qrafik Dizayn Trendləri', 21, 'İllüstrasiya və UX/UI dizaynında son tendensiyalar.', 3, 'dizayn,UX,UI,illustration', 'https://images.unsplash.com/photo-1532634896-26909d0dff12?auto=format&fit=crop&w=800&q=60', '2025-ci ildə qrafik dizayn sahəsində yeni tendensiyalar: İllüstrasiya texnikaları, UX/UI dizayn nümunələri, rəng palitrası və kreativ ideyalar haqqında ətraflı bələdçi.', '2025-12-06 21:09:42', 18, 8),
(20, 'JavaScript ilə İnteraktiv Veb', 22, 'JS ilə veb inkişafında praktik nümunələr.', 4, 'javascript,web,development', 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e3?auto=format&fit=crop&w=800&q=60', 'Bu məqalədə JavaScript istifadə edərək interaktiv veb tətbiqlər yaratmağın yolları izah olunur. Misallar, kod parçaları və praktik tapşırıqlar oxucuya addım-addım göstərilir.', '2025-12-06 21:09:42', 20, 10),
(33, 'wwwwwwwwwww', 18, 'wwwwwwwwwwww', 4, 'wwwwww', 'uploads/images/1765363426_article.jpg', 'wwwwwwwwwwwwwwwwwwwwwww', '2025-12-10 10:43:46', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mentor_books`
--

CREATE TABLE `mentor_books` (
  `book_id` int(11) NOT NULL,
  `book_title` varchar(50) NOT NULL,
  `mentor_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` varchar(200) NOT NULL,
  `book_img` varchar(200) NOT NULL,
  `book_file` varchar(200) NOT NULL,
  `likes` int(11) NOT NULL,
  `saved` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mentor_books`
--

INSERT INTO `mentor_books` (`book_id`, `book_title`, `mentor_id`, `category_id`, `description`, `book_img`, `book_file`, `likes`, `saved`, `created_at`) VALUES
(1, 'Riyazi Analitika', 17, 2, 'Riyazi analitika ve ona aid tapsiriqlar', 'https://glc.edu.az/storage/data-analitika-ixtisasi.webp', 'https://www.scribd.com/document/525164679/Riyazi-analiz', 34, 12, '2025-12-04 14:27:52'),
(2, 'Hendesse', 18, 1, 'HTML Css haqqinda', ' https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb2zAMFfEm9k4GQZGegkIlftr3rmckaIGh1A&s', 'https://adpuquba.edu.az/wp-content/uploads/2020/12/A.S.Adigoz%C9%99lovT.M.%C6%8FliyevaA.I.Quliyev.-Elementar-h%C9%99nd%C9%99s%C9%99.pdf', 33, 2, '2025-12-04 14:51:28'),
(3, 'Riyaziyyatın Əsasları', 17, 1, 'Riyaziyyatın əsas konseptləri və misallar.', 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e9?auto=format&fit=crop&w=800&q=60', 'https://example.com/pdf/riyaziyyat.pdf', 12, 5, '2025-12-06 21:06:43'),
(4, 'Tarixi Səyahət', 18, 2, 'Dünya tarixinin əsas dövrləri və sivilizasiyaları.', 'https://images.unsplash.com/photo-1598188305253-bfb2d1d5f5ee?auto=format&fit=crop&w=800&q=60', 'https://example.com/pdf/tarix.pdf', 8, 3, '2025-12-06 21:06:43'),
(5, 'Qrafik Dizayn Təlimatı', 21, 3, 'Illustrator və Photoshop ilə dizayn öyrənin.', 'https://images.unsplash.com/photo-1532634896-26909d0dff12?auto=format&fit=crop&w=800&q=60', 'https://example.com/pdf/dizayn.pdf', 15, 7, '2025-12-06 21:06:43'),
(6, 'JavaScript Əsasları', 22, 4, 'JS ilə interaktiv web saytlar yaradın.', 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e3?auto=format&fit=crop&w=800&q=60', 'https://example.com/pdf/javascript.pdf', 18, 6, '2025-12-06 21:06:43'),
(7, 'Riyaziyyat Problemləri', 17, 1, 'Müxtəlif səviyyəli riyaziyyat problemləri və həll yolları.', 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8ea?auto=format&fit=crop&w=800&q=60', 'https://example.com/pdf/riyaziyyat_problemler.pdf', 10, 4, '2025-12-06 21:06:43'),
(8, 'Tarixi Kitablar', 18, 2, 'Tarixi araşdırmalar üçün seçilmiş kitablar və mənbələr.', 'https://images.unsplash.com/photo-1598188305253-bfb2d1d5f5ef?auto=format&fit=crop&w=800&q=60', 'https://example.com/pdf/tarixi_kitablar.pdf', 12, 5, '2025-12-06 21:06:43'),
(9, 'Web Dizayn Rəhbəri', 22, 4, 'HTML, CSS və JS ilə müasir web dizayn təlimatı.', 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e4?auto=format&fit=crop&w=800&q=60', 'https://example.com/pdf/web_dizayn.pdf', 20, 8, '2025-12-06 21:06:43');

-- --------------------------------------------------------

--
-- Table structure for table `mentor_course`
--

CREATE TABLE `mentor_course` (
  `course_id` int(11) NOT NULL,
  `course_title` varchar(100) DEFAULT NULL,
  `course_desc` varchar(200) DEFAULT NULL,
  `course_price` int(11) DEFAULT NULL,
  `mentor_id` int(11) DEFAULT NULL,
  `category_id` int(30) DEFAULT NULL,
  `course_img` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL,
  `saved` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mentor_course`
--

INSERT INTO `mentor_course` (`course_id`, `course_title`, `course_desc`, `course_price`, `mentor_id`, `category_id`, `course_img`, `created_at`, `likes`, `saved`) VALUES
(1, 'Nyutonun qanunlari', 'Nyutonun 3 qanunu var \r\n1. Etaletlilik\r\n2. Cismin tezyiqi kutle ile duz quvve ile ters mutanasibdir\r\n3. Tesir eks tesire beraberdir', 8, 17, 5, 'https://qebulol.az/wp-content/uploads/2025/07/isaak22-1024x576.jpg', '2025-11-30 18:13:42', 0, 0),
(19, ' Data Structures & Algorithms', 'Əsas data structures və algorithms: arrays, linked lists, trees, graphs, sorting və searching algorithms, real həyat problemləri ilə praktika.', 33, 22, 1, ' https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e1?auto=format&fit=crop&w=800&q=60', '2025-12-06 19:32:31', 34, 21),
(20, 'Qrafik Dizaynın Əsasları', 'Photoshop və Illustrator istifadə edərək vizual dizaynın əsaslarını öyrənin: logolar, posterlər və sosial media materialları yaradın.', 28, 21, 4, 'https://images.unsplash.com/photo-1532634896-26909d0dff12?auto=format&fit=crop&w=800&q=60', '2025-12-06 20:56:50', 56, 5),
(21, 'Riyazi Statistikaya Giriş', 'Əsas statistik anlayışları və hesablama üsullarını öyrənin: ortalama, dispersiya, ehtimallar və real nümunələr.', 35, 18, 2, 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8ea?auto=format&fit=crop&w=800&q=60', '2025-12-06 20:57:50', 78, 65),
(28, 'Qrafik diznajr nfx j', NULL, NULL, 18, 4, 'uploads/course_files/1765365825_course.png', '2025-12-10 11:23:45', 0, 0),
(29, 'Qrafik diznajr nfx j', NULL, NULL, 18, 4, 'uploads/course_files/1765365828_course.png', '2025-12-10 11:23:48', 0, 0),
(30, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-10 11:30:31', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mentor_post`
--

CREATE TABLE `mentor_post` (
  `post_id` int(11) NOT NULL,
  `mentor_id` int(11) DEFAULT NULL,
  `post_title` varchar(100) DEFAULT NULL,
  `post_desc` varchar(200) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `post_img` varchar(200) DEFAULT NULL,
  `post_tags` varchar(120) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) DEFAULT NULL,
  `saved` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mentor_post`
--

INSERT INTO `mentor_post` (`post_id`, `mentor_id`, `post_title`, `post_desc`, `category_id`, `post_img`, `post_tags`, `created_at`, `likes`, `saved`) VALUES
(1, 17, 'Bug nedir', 'Bug — proqramda gözlənilməyən nəticə verən və ya düzgün işləməsinə mane olan texniki səhvdir.', 1, '0', '', '2025-11-30 13:25:48', 0, 0),
(2, 18, 'Hendesenin cetinlikleri', 'Hendesenin cetinlikleri haqqinda ', 2, 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg43LlEFwrw0pw9MRILmOJfBrMMAYmmAOTz3vgsQF5gDTKGMgXFDmShkqSW-oWl0S1wc_popNSDWSOpBk3Qw4bl9NEQGkXA026cosQyTWAvi8WcqWqq7v0_GBMqR1CRbKuaOTd3jL1cHes', '#hendese ', '2025-12-01 16:15:08', 34, 22),
(3, 17, 'Riyaziyyatın Gözəlliyi', 'Riyaziyyatın gündəlik həyatımızdakı tətbiqləri və maraqlı problemlər.', 1, 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e9?auto=format&fit=crop&w=800&q=60', 'riyaziyyat,hesablama,logic', '2025-12-06 21:03:55', 12, 5),
(4, 18, 'Tarixi Dövrlərə Səyahət', 'Qədim sivilizasiyalar və onların həyat tərzləri haqqında öyrənin.', 2, 'https://images.unsplash.com/photo-1598188305253-bfb2d1d5f5ee?auto=format&fit=crop&w=800&q=60', 'tarix,mədəniyyət,öyrən', '2025-12-06 21:03:55', 20, 8),
(5, 21, 'Qrafik Dizayn Trendləri 2025', 'İllüstrasiya, UX/UI və vizual dizaynda yeni tendensiyalar.', 3, 'https://images.unsplash.com/photo-1532634896-26909d0dff12?auto=format&fit=crop&w=800&q=60', 'dizayn,UX,UI,illustration', '2025-12-06 21:03:55', 15, 7),
(6, 22, 'JavaScript ilə Interaktiv Veb', 'Praktik nümunələrlə JS-in veb inkişafında tətbiqi.', 4, 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e3?auto=format&fit=crop&w=800&q=60', 'javascript,web,development', '2025-12-06 21:03:55', 18, 6),
(7, 17, 'Riyaziyyat: Həll Yolları', 'Ən çətin riyaziyyat problemlərinə yaradıcı həll üsulları.', 1, 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8ea?auto=format&fit=crop&w=800&q=60', 'riyaziyyat,problem-solving', '2025-12-06 21:03:55', 10, 3),
(8, 18, 'Dünya Tarixi Analizi', 'Müxtəlif dövrlərdə baş verən mühüm hadisələrin analizi.', 2, 'https://images.unsplash.com/photo-1598188305253-bfb2d1d5f5ef?auto=format&fit=crop&w=800&q=60', 'tarix,analiz,öyrən', '2025-12-06 21:03:55', 14, 5),
(9, 21, 'UI/UX Dizayn üçün Figma', 'Figma ilə prototiplər hazırlamaq və istifadəçi təcrübəsini inkişaf etdirmək.', 3, 'https://images.unsplash.com/photo-1532634896-26909d0dff13?auto=format&fit=crop&w=800&q=60', 'UX,UI,figma,dizayn', '2025-12-06 21:03:55', 17, 9),
(10, 22, 'Web Performance Optimization', 'Veb saytların sürət və performans optimizasiyası.', 4, 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e4?auto=format&fit=crop&w=800&q=60', 'web,performance,optimization', '2025-12-06 21:03:55', 19, 11),
(11, 17, 'Riyaziyyat və Statistik Analiz', 'Riyaziyyatla məlumat analizi və statistik modellər yaratmaq.', 1, 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8eb?auto=format&fit=crop&w=800&q=60', 'riyaziyyat,data,statistika', '2025-12-06 21:03:55', 13, 6),
(12, 18, 'Tarixi Kitablar və Mənbələr', 'Tarixi araşdırmalar üçün etibarlı kitablar və mənbələr.', 2, 'https://images.unsplash.com/photo-1598188305253-bfb2d1d5f5f0?auto=format&fit=crop&w=800&q=60', 'tarix,kitab,mənbə', '2025-12-06 21:03:55', 11, 4),
(13, 21, 'Illustrator ilə Kreativ Posterlər', 'Adobe Illustrator istifadə edərək poster və vizual materiallar yaratmaq.', 3, 'https://images.unsplash.com/photo-1532634896-26909d0dff14?auto=format&fit=crop&w=800&q=60', 'illustrator,dizayn,poster', '2025-12-06 21:03:55', 16, 8),
(14, 22, 'Modern Web Dizayn Texnikaları', 'HTML, CSS və JS ilə müasir web sayt dizayn üsulları.', 4, 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e5?auto=format&fit=crop&w=800&q=60', 'web,design,frontend', '2025-12-06 21:03:55', 20, 10),
(36, 18, 'sssssssssssssss', 'ssssssssssssssssss', 4, '1765366896_1764669628_insta2.jpg', 'sssssssssssssss', '2025-12-10 11:41:36', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `saved_articles`
--

CREATE TABLE `saved_articles` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `saved_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `saved_articles`
--

INSERT INTO `saved_articles` (`id`, `student_id`, `article_id`, `saved_at`) VALUES
(1, 104, 17, '2025-12-08 23:53:43');

-- --------------------------------------------------------

--
-- Table structure for table `saved_books`
--

CREATE TABLE `saved_books` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `saved_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `saved_books`
--

INSERT INTO `saved_books` (`id`, `student_id`, `book_id`, `saved_at`) VALUES
(1, 110, 2, '2025-12-08 23:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `saved_course`
--

CREATE TABLE `saved_course` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `saved_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `saved_course`
--

INSERT INTO `saved_course` (`id`, `student_id`, `course_id`, `saved_at`) VALUES
(1, 103, 20, '2025-12-08 23:57:24');

-- --------------------------------------------------------

--
-- Table structure for table `saved_items`
--

CREATE TABLE `saved_items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` enum('student','mentor') NOT NULL,
  `content_id` int(11) NOT NULL,
  `content_type` enum('book','course','article') NOT NULL,
  `saved_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `saved_posts`
--

CREATE TABLE `saved_posts` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `saved_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `saved_posts`
--

INSERT INTO `saved_posts` (`id`, `student_id`, `post_id`, `saved_at`) VALUES
(2, 105, 4, '2025-12-10 09:11:15');

-- --------------------------------------------------------

--
-- Table structure for table `student_post`
--

CREATE TABLE `student_post` (
  `post_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `post_desc` varchar(200) DEFAULT NULL,
  `post_title` varchar(100) DEFAULT NULL,
  `post_img` varchar(200) DEFAULT NULL,
  `likes` int(11) NOT NULL,
  `saved` int(11) NOT NULL,
  `post_tags` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_post`
--

INSERT INTO `student_post` (`post_id`, `student_id`, `category_id`, `post_desc`, `post_title`, `post_img`, `likes`, `saved`, `post_tags`, `created_at`) VALUES
(37, 96, 4, 'bu gun sizinle men idim aytekin alxasli', 'saalaama', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUTExIWFhUXGR0bFxgYFxkbHhseGB4bHx0aHRsbHSggHh8lGxkbITEiJSkrLi4uGB8zODMsNygtLisBCgoKDg0OGxAQGzAmICUyLzc4Li0vLy8tMC8vLTItLTUtLS0tLy0tLS8tL', 0, 0, 'proqramlasirma, sertsizz', '2025-12-02 13:46:09'),
(38, 96, 4, 'AUTOCAD in izahlari', 'AutoCAD ', 'https://www.cadinterop.com/images/CADInterop/CAD/autocad.webp', 0, 0, '#autocad #dizayn', '2025-12-02 13:46:09'),
(41, 110, 3, 'Azerbaycan tarixinin gorkemli sexsiyyetleri', 'Azerbaycan tarixi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS65neZMnqrxmXm3sFujnzsOBDm3j5jtYQZnw&s', 0, 0, '#tarix #history', '2025-12-02 13:46:09'),
(52, 105, 2, ' Riyaziyyat problemləri və gündəlik həyatdakı tətbiqləri. \r\n ', 'Riyaziyyatın Maraqlı Dünyası', 'https://images.unsplash.com/photo-1581091870622-3b6b40a9f8e9?', 44, 42, '#eladi ', '2025-12-06 21:24:56');

-- --------------------------------------------------------

--
-- Table structure for table `student_table`
--

CREATE TABLE `student_table` (
  `student_id` int(11) NOT NULL,
  `student_name` char(32) NOT NULL,
  `student_email` varchar(100) NOT NULL,
  `student_password` char(11) NOT NULL,
  `profile_img` varchar(200) NOT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_table`
--

INSERT INTO `student_table` (`student_id`, `student_name`, `student_email`, `student_password`, `profile_img`, `rating`) VALUES
(1, 'Murad Huseynov', 'mourad33@gmail.com', 'Ganca20222', '', 23),
(96, '', '', '$2y$10$H5yi', '', 0),
(102, 'Angelina Jolie', 'sirinovnesib25@gmail.com', '$2y$10$dfPl', '', 0),
(103, 'Nurlan', 'nurlan2002@gmail.com', '$2y$10$NDFZ', '', 0),
(104, 'Nihat', 'nahid_agazade@mail.ru', '20232023', '', 0),
(105, 'Aqsin', 'aqsin234@gmail.com', 'baku2025', '', 0),
(106, 'Nihat', 'nihat34@gmail.com', '20002000', 'https://img.freepik.com/free-photo/young-woman-attend-courses-girl-student-studying-holding-notebooks-showing-thumb-up-approval-recommending-company-standing-blue-background_1258-70145.jpg?semt=ais_hy', 0),
(107, 'Aqsin', 'asif34@gmail.com', '30303030', '', 0),
(108, 'salam', 'mourads33@gmail.com', 'quba2023', '', 0),
(109, 'Nesib', 'hsdhbhsh@gmail.com', '123456789', 'https://www.socialsciencespace.com/wp-content/uploads/student-3500990_960_720_opt.jpg', 0),
(110, 'Nesib', 'aslan34@gmail.com', '123456789', '', 0),
(111, 'Angelina Jolie', 'angel22@gmail.com', 'quba2023', '', 0),
(112, 'Angelina Jolie', 'angel222@gmail.com', 'quba2023', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `subcateg_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`subcateg_id`, `category_id`, `subcategory`) VALUES
(1, 1, 'HTML'),
(2, 1, 'CSS'),
(3, 1, 'JavaScript'),
(4, 1, 'React'),
(5, 1, 'C#'),
(6, 2, 'Cebr'),
(7, 2, 'Hendese'),
(8, 2, 'Triqonometriya'),
(9, 4, 'Figma'),
(10, 4, 'AutoCad');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article_comment`
--
ALTER TABLE `article_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coma` (`article_id`),
  ADD KEY `coms` (`student_id`),
  ADD KEY `comp` (`parent_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `postref` (`parent_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `commentss`
--
ALTER TABLE `commentss`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comstud` (`post_id`),
  ADD KEY `parents` (`parent_id`),
  ADD KEY `studs` (`student_id`);

--
-- Indexes for table `course_comment`
--
ALTER TABLE `course_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stud` (`student_id`),
  ADD KEY `cors` (`course_id`),
  ADD KEY `compp` (`parent_id`);

--
-- Indexes for table `course_video`
--
ALTER TABLE `course_video`
  ADD PRIMARY KEY (`video_id`),
  ADD KEY `videos` (`course_id`),
  ADD KEY `categ` (`category_id`);

--
-- Indexes for table `mentors`
--
ALTER TABLE `mentors`
  ADD PRIMARY KEY (`mentor_id`),
  ADD KEY `catt` (`category_id`);

--
-- Indexes for table `mentor_article`
--
ALTER TABLE `mentor_article`
  ADD PRIMARY KEY (`article_id`),
  ADD KEY `article` (`mentor_id`),
  ADD KEY `categart` (`category_id`);

--
-- Indexes for table `mentor_books`
--
ALTER TABLE `mentor_books`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `bookm` (`mentor_id`),
  ADD KEY `bookc` (`category_id`);

--
-- Indexes for table `mentor_course`
--
ALTER TABLE `mentor_course`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `courses` (`mentor_id`),
  ADD KEY `courscateg` (`category_id`);

--
-- Indexes for table `mentor_post`
--
ALTER TABLE `mentor_post`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `postm` (`mentor_id`),
  ADD KEY `postc` (`category_id`);

--
-- Indexes for table `saved_articles`
--
ALTER TABLE `saved_articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `saveart` (`article_id`),
  ADD KEY `savestud` (`student_id`);

--
-- Indexes for table `saved_books`
--
ALTER TABLE `saved_books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `saved_course`
--
ALTER TABLE `saved_course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `saved_items`
--
ALTER TABLE `saved_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_save` (`user_id`,`user_type`,`content_id`,`content_type`),
  ADD KEY `uyfv` (`content_id`);

--
-- Indexes for table `saved_posts`
--
ALTER TABLE `saved_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poatsave` (`post_id`);

--
-- Indexes for table `student_post`
--
ALTER TABLE `student_post`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `poststud` (`student_id`),
  ADD KEY `postcat` (`category_id`);

--
-- Indexes for table `student_table`
--
ALTER TABLE `student_table`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`subcateg_id`),
  ADD KEY `subcateg` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `article_comment`
--
ALTER TABLE `article_comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `commentss`
--
ALTER TABLE `commentss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `course_comment`
--
ALTER TABLE `course_comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `course_video`
--
ALTER TABLE `course_video`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `mentors`
--
ALTER TABLE `mentors`
  MODIFY `mentor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `mentor_article`
--
ALTER TABLE `mentor_article`
  MODIFY `article_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `mentor_books`
--
ALTER TABLE `mentor_books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mentor_course`
--
ALTER TABLE `mentor_course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `mentor_post`
--
ALTER TABLE `mentor_post`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `saved_articles`
--
ALTER TABLE `saved_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `saved_books`
--
ALTER TABLE `saved_books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `saved_course`
--
ALTER TABLE `saved_course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `saved_items`
--
ALTER TABLE `saved_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `saved_posts`
--
ALTER TABLE `saved_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_post`
--
ALTER TABLE `student_post`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `student_table`
--
ALTER TABLE `student_table`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `subcateg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `article_comment`
--
ALTER TABLE `article_comment`
  ADD CONSTRAINT `coma` FOREIGN KEY (`article_id`) REFERENCES `mentor_article` (`article_id`),
  ADD CONSTRAINT `comp` FOREIGN KEY (`parent_id`) REFERENCES `article_comment` (`id`),
  ADD CONSTRAINT `coms` FOREIGN KEY (`student_id`) REFERENCES `student_table` (`student_id`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `student_post` (`post_id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student_table` (`student_id`),
  ADD CONSTRAINT `postref` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commentss`
--
ALTER TABLE `commentss`
  ADD CONSTRAINT `commen` FOREIGN KEY (`post_id`) REFERENCES `mentor_post` (`post_id`),
  ADD CONSTRAINT `parents` FOREIGN KEY (`parent_id`) REFERENCES `commentss` (`id`),
  ADD CONSTRAINT `studs` FOREIGN KEY (`student_id`) REFERENCES `student_table` (`student_id`);

--
-- Constraints for table `course_comment`
--
ALTER TABLE `course_comment`
  ADD CONSTRAINT `compp` FOREIGN KEY (`parent_id`) REFERENCES `course_comment` (`id`),
  ADD CONSTRAINT `cors` FOREIGN KEY (`course_id`) REFERENCES `mentor_course` (`course_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stud` FOREIGN KEY (`student_id`) REFERENCES `student_table` (`student_id`);

--
-- Constraints for table `course_video`
--
ALTER TABLE `course_video`
  ADD CONSTRAINT `categ` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `videos` FOREIGN KEY (`course_id`) REFERENCES `mentor_course` (`course_id`);

--
-- Constraints for table `mentors`
--
ALTER TABLE `mentors`
  ADD CONSTRAINT `catt` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `mentor_article`
--
ALTER TABLE `mentor_article`
  ADD CONSTRAINT `article` FOREIGN KEY (`mentor_id`) REFERENCES `mentors` (`mentor_id`),
  ADD CONSTRAINT `categart` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `mentor_books`
--
ALTER TABLE `mentor_books`
  ADD CONSTRAINT `bookc` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookm` FOREIGN KEY (`mentor_id`) REFERENCES `mentors` (`mentor_id`) ON DELETE CASCADE;

--
-- Constraints for table `mentor_course`
--
ALTER TABLE `mentor_course`
  ADD CONSTRAINT `courscateg` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `courses` FOREIGN KEY (`mentor_id`) REFERENCES `mentors` (`mentor_id`);

--
-- Constraints for table `mentor_post`
--
ALTER TABLE `mentor_post`
  ADD CONSTRAINT `postc` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `postm` FOREIGN KEY (`mentor_id`) REFERENCES `mentors` (`mentor_id`);

--
-- Constraints for table `saved_articles`
--
ALTER TABLE `saved_articles`
  ADD CONSTRAINT `saveart` FOREIGN KEY (`article_id`) REFERENCES `mentor_article` (`article_id`),
  ADD CONSTRAINT `savestud` FOREIGN KEY (`student_id`) REFERENCES `student_table` (`student_id`);

--
-- Constraints for table `saved_books`
--
ALTER TABLE `saved_books`
  ADD CONSTRAINT `saved_books_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `mentor_books` (`book_id`),
  ADD CONSTRAINT `saved_books_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student_table` (`student_id`);

--
-- Constraints for table `saved_course`
--
ALTER TABLE `saved_course`
  ADD CONSTRAINT `saved_course_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `mentor_course` (`course_id`),
  ADD CONSTRAINT `saved_course_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student_table` (`student_id`);

--
-- Constraints for table `saved_items`
--
ALTER TABLE `saved_items`
  ADD CONSTRAINT `sscourse` FOREIGN KEY (`content_id`) REFERENCES `mentor_course` (`course_id`),
  ADD CONSTRAINT `users` FOREIGN KEY (`content_id`) REFERENCES `mentor_books` (`book_id`),
  ADD CONSTRAINT `usersave` FOREIGN KEY (`user_id`) REFERENCES `mentors` (`mentor_id`),
  ADD CONSTRAINT `usres` FOREIGN KEY (`user_id`) REFERENCES `student_table` (`student_id`),
  ADD CONSTRAINT `uyfv` FOREIGN KEY (`content_id`) REFERENCES `mentor_article` (`article_id`);

--
-- Constraints for table `saved_posts`
--
ALTER TABLE `saved_posts`
  ADD CONSTRAINT `mentorsave` FOREIGN KEY (`student_id`) REFERENCES `student_table` (`student_id`),
  ADD CONSTRAINT `poostsave` FOREIGN KEY (`post_id`) REFERENCES `mentor_post` (`post_id`);

--
-- Constraints for table `student_post`
--
ALTER TABLE `student_post`
  ADD CONSTRAINT `postcat` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `poststud` FOREIGN KEY (`student_id`) REFERENCES `student_table` (`student_id`);

--
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcateg` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
