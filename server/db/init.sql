-- PostgreSQL schema for cothink
-- Converted from MySQL (cothink.sql)
-- Safe to run multiple times: all tables use CREATE TABLE IF NOT EXISTS
--
-- Table creation order respects foreign-key dependencies:
--   1. categories
--   2. mentors, student_table          (reference categories)
--   3. mentor_article, mentor_books,
--      mentor_course, mentor_post      (reference mentors + categories)
--   4. course_video                    (references mentor_course + categories)
--   5. student_post                    (references student_table + categories)
--   6. article_comment                 (references mentor_article + student_table)
--   7. comments                        (references student_post + student_table)
--   8. commentss                       (references mentor_post + student_table)
--   9. course_comment                  (references mentor_course + student_table)
--  10. saved_articles, saved_books,
--      saved_course, saved_posts,
--      saved_items                     (references various tables above)
--  11. subcategories                   (references categories)

-- --------------------------------------------------------
-- 1. categories
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "categories" (
  "category_id"  SERIAL PRIMARY KEY,
  "category"     VARCHAR(40)  NOT NULL,
  "category_img" VARCHAR(200) NOT NULL
);

-- --------------------------------------------------------
-- 2a. mentors
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "mentors" (
  "mentor_id"       SERIAL PRIMARY KEY,
  "mentor_name"     CHAR(32)     NOT NULL,
  "mentor_email"    VARCHAR(100) NOT NULL,
  "mentor_password" CHAR(20)     NOT NULL,
  "mentor_username" CHAR(32)     NOT NULL,
  "description"     VARCHAR(300) NOT NULL,
  "category_id"     INTEGER      NOT NULL,
  "profile_img"     VARCHAR(200) NOT NULL,
  "languages"       VARCHAR(100) NOT NULL,
  "linkedn_link"    VARCHAR(300) NOT NULL,
  "students"        INTEGER      NOT NULL,
  "rating"          INTEGER      NOT NULL,
  "position"        VARCHAR(100) NOT NULL,
  CONSTRAINT "catt" FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id")
);

-- --------------------------------------------------------
-- 2b. student_table
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "student_table" (
  "student_id"       SERIAL PRIMARY KEY,
  "student_name"     CHAR(32)     NOT NULL,
  "student_email"    VARCHAR(100) NOT NULL,
  "student_password" CHAR(11)     NOT NULL,
  "profile_img"      VARCHAR(200) NOT NULL,
  "rating"           INTEGER      NOT NULL
);

-- --------------------------------------------------------
-- 3a. mentor_article
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "mentor_article" (
  "article_id"    SERIAL PRIMARY KEY,
  "article_title" CHAR(40)      DEFAULT NULL,
  "mentor_id"     INTEGER       DEFAULT NULL,
  "article_desc"  VARCHAR(200)  DEFAULT NULL,
  "category_id"   INTEGER       DEFAULT NULL,
  "article_tags"  VARCHAR(100)  DEFAULT NULL,
  "article_img"   VARCHAR(200)  DEFAULT NULL,
  "article_topic" VARCHAR(5000) DEFAULT NULL,
  "created_at"    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  "likes"         INTEGER       NOT NULL,
  "saved"         INTEGER       NOT NULL,
  CONSTRAINT "article"  FOREIGN KEY ("mentor_id")   REFERENCES "mentors"    ("mentor_id"),
  CONSTRAINT "categart" FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id")
);

-- --------------------------------------------------------
-- 3b. mentor_books
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "mentor_books" (
  "book_id"     SERIAL PRIMARY KEY,
  "book_title"  VARCHAR(50)  NOT NULL,
  "mentor_id"   INTEGER      NOT NULL,
  "category_id" INTEGER      NOT NULL,
  "description" VARCHAR(200) NOT NULL,
  "book_img"    VARCHAR(200) NOT NULL,
  "book_file"   VARCHAR(200) NOT NULL,
  "likes"       INTEGER      NOT NULL,
  "saved"       INTEGER      NOT NULL,
  "created_at"  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "bookm" FOREIGN KEY ("mentor_id")   REFERENCES "mentors"    ("mentor_id") ON DELETE CASCADE,
  CONSTRAINT "bookc" FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id") ON DELETE CASCADE
);

-- --------------------------------------------------------
-- 3c. mentor_course
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "mentor_course" (
  "course_id"    SERIAL PRIMARY KEY,
  "course_title" VARCHAR(100) DEFAULT NULL,
  "course_desc"  VARCHAR(200) DEFAULT NULL,
  "course_price" INTEGER      DEFAULT NULL,
  "mentor_id"    INTEGER      DEFAULT NULL,
  "category_id"  INTEGER      DEFAULT NULL,
  "course_img"   VARCHAR(200) DEFAULT NULL,
  "created_at"   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  "likes"        INTEGER      NOT NULL,
  "saved"        INTEGER      NOT NULL,
  CONSTRAINT "courses"    FOREIGN KEY ("mentor_id")   REFERENCES "mentors"    ("mentor_id"),
  CONSTRAINT "courscateg" FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id")
);

-- --------------------------------------------------------
-- 3d. mentor_post
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "mentor_post" (
  "post_id"     SERIAL PRIMARY KEY,
  "mentor_id"   INTEGER      DEFAULT NULL,
  "post_title"  VARCHAR(100) DEFAULT NULL,
  "post_desc"   VARCHAR(200) DEFAULT NULL,
  "category_id" INTEGER      DEFAULT NULL,
  "post_img"    VARCHAR(200) DEFAULT NULL,
  "post_tags"   VARCHAR(120) DEFAULT NULL,
  "created_at"  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  "likes"       INTEGER      DEFAULT NULL,
  "saved"       INTEGER      DEFAULT NULL,
  CONSTRAINT "postm" FOREIGN KEY ("mentor_id")   REFERENCES "mentors"    ("mentor_id"),
  CONSTRAINT "postc" FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id")
);

-- --------------------------------------------------------
-- 4. course_video
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "course_video" (
  "video_id"     SERIAL PRIMARY KEY,
  "course_id"    INTEGER      DEFAULT NULL,
  "category_id"  INTEGER      DEFAULT NULL,
  "lesson_title" VARCHAR(100) DEFAULT NULL,
  "video_link"   VARCHAR(250) DEFAULT NULL,
  "course_files" VARCHAR(200) DEFAULT NULL,
  CONSTRAINT "videos" FOREIGN KEY ("course_id")   REFERENCES "mentor_course" ("course_id"),
  CONSTRAINT "categ"  FOREIGN KEY ("category_id") REFERENCES "categories"    ("category_id")
);

-- --------------------------------------------------------
-- 5. student_post
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "student_post" (
  "post_id"     SERIAL PRIMARY KEY,
  "student_id"  INTEGER      DEFAULT NULL,
  "category_id" INTEGER      DEFAULT NULL,
  "post_desc"   VARCHAR(200) DEFAULT NULL,
  "post_title"  VARCHAR(100) DEFAULT NULL,
  "post_img"    VARCHAR(200) DEFAULT NULL,
  "likes"       INTEGER      NOT NULL,
  "saved"       INTEGER      NOT NULL,
  "post_tags"   VARCHAR(200) DEFAULT NULL,
  "created_at"  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "poststud" FOREIGN KEY ("student_id")  REFERENCES "student_table" ("student_id"),
  CONSTRAINT "postcat"  FOREIGN KEY ("category_id") REFERENCES "categories"    ("category_id")
);

-- --------------------------------------------------------
-- 6. article_comment
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "article_comment" (
  "id"           SERIAL PRIMARY KEY,
  "article_id"   INTEGER      NOT NULL,
  "comment_text" VARCHAR(300) NOT NULL,
  "parent_id"    INTEGER      DEFAULT NULL,
  "student_id"   INTEGER      NOT NULL,
  "created_at"   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  "likes"        INTEGER      NOT NULL,
  CONSTRAINT "coma" FOREIGN KEY ("article_id") REFERENCES "mentor_article"  ("article_id"),
  CONSTRAINT "coms" FOREIGN KEY ("student_id") REFERENCES "student_table"   ("student_id"),
  CONSTRAINT "comp" FOREIGN KEY ("parent_id")  REFERENCES "article_comment" ("id")
);

-- --------------------------------------------------------
-- 7. comments  (comments on student posts)
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "comments" (
  "id"           SERIAL PRIMARY KEY,
  "post_id"      INTEGER      NOT NULL,
  "student_id"   INTEGER      NOT NULL,
  "parent_id"    INTEGER      DEFAULT NULL,
  "comment_text" VARCHAR(400) NOT NULL,
  "created_at"   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  "likes"        INTEGER      DEFAULT NULL,
  CONSTRAINT "comments_ibfk_1" FOREIGN KEY ("post_id")    REFERENCES "student_post"  ("post_id"),
  CONSTRAINT "comments_ibfk_2" FOREIGN KEY ("student_id") REFERENCES "student_table" ("student_id"),
  CONSTRAINT "postref"         FOREIGN KEY ("parent_id")  REFERENCES "comments"      ("id") ON DELETE CASCADE
);

-- --------------------------------------------------------
-- 8. commentss  (comments on mentor posts)
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "commentss" (
  "id"           SERIAL PRIMARY KEY,
  "post_id"      INTEGER   NOT NULL,
  "student_id"   INTEGER   NOT NULL,
  "parent_id"    INTEGER   DEFAULT NULL,
  "comment_text" TEXT      NOT NULL,
  "likes"        INTEGER   DEFAULT 0,
  "created_at"   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "commen"  FOREIGN KEY ("post_id")    REFERENCES "mentor_post"  ("post_id"),
  CONSTRAINT "studs"   FOREIGN KEY ("student_id") REFERENCES "student_table" ("student_id"),
  CONSTRAINT "parents" FOREIGN KEY ("parent_id")  REFERENCES "commentss"    ("id")
);

-- --------------------------------------------------------
-- 9. course_comment
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "course_comment" (
  "id"           SERIAL PRIMARY KEY,
  "course_id"    INTEGER      NOT NULL,
  "student_id"   INTEGER      NOT NULL,
  "comment_text" VARCHAR(200) NOT NULL,
  "likes"        INTEGER      NOT NULL,
  "created_at"   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  "parent_id"    INTEGER      DEFAULT NULL,
  CONSTRAINT "cors"  FOREIGN KEY ("course_id")  REFERENCES "mentor_course"  ("course_id") ON DELETE CASCADE,
  CONSTRAINT "stud"  FOREIGN KEY ("student_id") REFERENCES "student_table"  ("student_id"),
  CONSTRAINT "compp" FOREIGN KEY ("parent_id")  REFERENCES "course_comment" ("id")
);

-- --------------------------------------------------------
-- 10a. saved_articles
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "saved_articles" (
  "id"         SERIAL PRIMARY KEY,
  "student_id" INTEGER   NOT NULL,
  "article_id" INTEGER   NOT NULL,
  "saved_at"   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "saveart"  FOREIGN KEY ("article_id") REFERENCES "mentor_article" ("article_id"),
  CONSTRAINT "savestud" FOREIGN KEY ("student_id") REFERENCES "student_table"  ("student_id")
);

-- --------------------------------------------------------
-- 10b. saved_books
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "saved_books" (
  "id"         SERIAL PRIMARY KEY,
  "student_id" INTEGER   NOT NULL,
  "book_id"    INTEGER   NOT NULL,
  "saved_at"   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "saved_books_ibfk_1" FOREIGN KEY ("book_id")    REFERENCES "mentor_books"  ("book_id"),
  CONSTRAINT "saved_books_ibfk_2" FOREIGN KEY ("student_id") REFERENCES "student_table" ("student_id")
);

-- --------------------------------------------------------
-- 10c. saved_course
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "saved_course" (
  "id"         SERIAL PRIMARY KEY,
  "student_id" INTEGER   NOT NULL,
  "course_id"  INTEGER   NOT NULL,
  "saved_at"   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "saved_course_ibfk_1" FOREIGN KEY ("course_id")  REFERENCES "mentor_course" ("course_id"),
  CONSTRAINT "saved_course_ibfk_2" FOREIGN KEY ("student_id") REFERENCES "student_table" ("student_id")
);

-- --------------------------------------------------------
-- 10d. saved_posts
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "saved_posts" (
  "id"         SERIAL PRIMARY KEY,
  "student_id" INTEGER   NOT NULL,
  "post_id"    INTEGER   NOT NULL,
  "saved_at"   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "mentorsave" FOREIGN KEY ("student_id") REFERENCES "student_table" ("student_id"),
  CONSTRAINT "poostsave"  FOREIGN KEY ("post_id")    REFERENCES "mentor_post"   ("post_id")
);

-- --------------------------------------------------------
-- 10e. saved_items
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "saved_items" (
  "id"           SERIAL PRIMARY KEY,
  "user_id"      INTEGER     NOT NULL,
  "user_type"    VARCHAR(10) NOT NULL CHECK ("user_type"    IN ('student', 'mentor')),
  "content_id"   INTEGER     NOT NULL,
  "content_type" VARCHAR(10) NOT NULL CHECK ("content_type" IN ('book', 'course', 'article')),
  "saved_at"     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "unique_save" UNIQUE ("user_id", "user_type", "content_id", "content_type")
);

-- --------------------------------------------------------
-- 11. subcategories
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS "subcategories" (
  "subcateg_id" SERIAL PRIMARY KEY,
  "category_id" INTEGER  NOT NULL,
  "subcategory" CHAR(32) NOT NULL,
  CONSTRAINT "subcateg" FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id")
);
