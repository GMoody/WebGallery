--select * from pg_trigger -- dlja poiska triggerov esli zabil nazvanie
CREATE SCHEMA webgallery AUTHORIZATION t131568

------------------------------------------------------------------------------------------------------
-- Table stores pictures categories.

CREATE TABLE webgallery.t_category(
	id_category SERIAL PRIMARY KEY,
	category VARCHAR(30) NOT NULL
);

------------------------------------------------------------------------------------------------------
-- Table stores users positions.

CREATE TABLE webgallery.t_position(
	id_position SERIAL PRIMARY KEY,
	position VARCHAR(30) NOT NULL
);

------------------------------------------------------------------------------------------------------
-- Table stores user information.

CREATE TABLE webgallery.t_user(
	id_user SERIAL PRIMARY KEY,
	id_position INTEGER NOT NULL references webgallery.t_position(id_position),
	user_name VARCHAR(20) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	password text NOT NULL,
	avatar TEXT NULL
);

------------------------------------------------------------------------------------------------------
-- Table stores picture information.

CREATE TABLE webgallery.t_picture(
	id_picture SERIAL PRIMARY KEY,
	id_category INTEGER NOT NULL references webgallery.t_category(id_category),
	upl_user_id INTEGER NOT NULL references webgallery.t_user(id_user),
	upl_date DATE NOT NULL,                                                        -- Will be function that automatically puts upl_date in the field.
	description VARCHAR(150) NULL,
	picture_url text NOT NULL
);

------------------------------------------------------------------------------------------------------
-- Table stores comment information.

CREATE TABLE webgallery.t_comment(
	id_comment SERIAL PRIMARY KEY,
	id_picture INTEGER NOT NULL references webgallery.t_picture(id_picture),
	id_user INTEGER NOT NULL references webgallery.t_user(id_user),
	add_date DATE NOT NULL,                                                        -- Will be function that automatically puts add_date in the field.
	comment text NOT NULL
);

------------------------------------------------------------------------------------------------------
-- Table stores user statistics information.

CREATE TABLE webgallery.t_user_statistics(
	id_user_statistics SERIAL PRIMARY KEY,
	id_user INTEGER NOT NULL references webgallery.t_user(id_user),
	total_voted INTEGER NOT NULL DEFAULT 0
	                                         
);

------------------------------------------------------------------------------------------------------
-- Table stores picture statistics information.

CREATE TABLE webgallery.t_picture_statistics(
	id_picture_statistics SERIAL PRIMARY KEY,
	id_picture INTEGER NOT NULL references webgallery.t_picture(id_picture),
	total_voted INTEGER NOT NULL DEFAULT 0,
	total_downloads INTEGER NOT NULL DEFAULT 0,
	picture_rating REAL NOT NULL DEFAULT 0                                         -- Type REAL takes up less space than DOUBLE PRECISION
);

------------------------------------------------------------------------------------------------------
 CREATE TABLE webgallery.t_Like(

id_like serial PRIMARY KEY,
id_user int NOT NULL references webgallery.t_user(id_user),
id_picture int NOT NULL references webgallery.t_picture(id_picture),
unique (id_user, id_picture)
 
)

----------------------------------------------------------------------------------------------------

-- Table t_category INSERTS.

INSERT INTO webgallery.t_category (category) VALUES ('3D-Graphics');
INSERT INTO webgallery.t_category (category) VALUES ('Buildings and structures');
INSERT INTO webgallery.t_category (category) VALUES ('Games');
INSERT INTO webgallery.t_category (category) VALUES ('Men');
INSERT INTO webgallery.t_category (category) VALUES ('Women');
INSERT INTO webgallery.t_category (category) VALUES ('Celebrities');
INSERT INTO webgallery.t_category (category) VALUES ('Weapons');
INSERT INTO webgallery.t_category (category) VALUES ('Movies');
INSERT INTO webgallery.t_category (category) VALUES ('Series');
INSERT INTO webgallery.t_category (category) VALUES ('Abstraction');
INSERT INTO webgallery.t_category (category) VALUES ('Interior');
INSERT INTO webgallery.t_category (category) VALUES ('Love');
INSERT INTO webgallery.t_category (category) VALUES ('Music');
INSERT INTO webgallery.t_category (category) VALUES ('Holidays');
INSERT INTO webgallery.t_category (category) VALUES ('Animals');
INSERT INTO webgallery.t_category (category) VALUES ('Nature');
INSERT INTO webgallery.t_category (category) VALUES ('Sport');
INSERT INTO webgallery.t_category (category) VALUES ('Cartoons');
INSERT INTO webgallery.t_category (category) VALUES ('Computers');
INSERT INTO webgallery.t_category (category) VALUES ('Macro');
INSERT INTO webgallery.t_category (category) VALUES ('Food');
INSERT INTO webgallery.t_category (category) VALUES ('Aviation');
INSERT INTO webgallery.t_category (category) VALUES ('Cars');
INSERT INTO webgallery.t_category (category) VALUES ('Space');
INSERT INTO webgallery.t_category (category) VALUES ('Minimalism');
INSERT INTO webgallery.t_category (category) VALUES ('Anime');
INSERT INTO webgallery.t_category (category) VALUES ('Motorcycles');
INSERT INTO webgallery.t_category (category) VALUES ('Textures');
INSERT INTO webgallery.t_category (category) VALUES ('Other');

------------------------------------------------------------------------------------------------------
-- Table t_position INSERTS.

INSERT INTO webgallery.t_position (position) VALUES ('User');
INSERT INTO webgallery.t_position (position) VALUES ('Moderator');
INSERT INTO webgallery.t_position (position) VALUES ('Administrator');

------------------------------------------------------------------------------------------------------
-- Table t_user INSERTS.

INSERT INTO webgallery.t_user (id_position, user_name, first_name, last_name, email, password) VALUES (3, 'Griwanja', 'Grigory', 'Tureev', 'g.tureev@gmail.com', 'needToChange');
INSERT INTO webgallery.t_user (id_position, user_name, first_name, last_name, email, password) VALUES (3, 'r3dz', 'Deniss', 'Kulakov', 'deniss.kulakov@hotmail.com', 'needToChange');

------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------

-- Создаем два запроса по типу SELECT которые выводят список админов и список юзеров
SELECT xmlelement(NAME ADMINS,xmlattributes ('Users list' as "Title", COUNT(U.id_user) as "Total_admins"),
                  xmlagg(xmlelement(NAME ADMIN,XMLATTRIBUTES(U.id_user as id, PO.position as Position,
                                    U.password as password, U.user_name as username, U.email as email),U.first_name,' ',U.last_name))
	         )
FROM webgallery.t_user as U
JOIN webgallery.t_position as PO ON U.id_position = PO.id_position
WHERE PO.position = 'Administrator'
UNION ALL
(
SELECT xmlelement( NAME USERS, XMLATTRIBUTES ('Users list' AS "Title", COUNT(U.id_user) AS "Total_users"),
xmlagg(xmlelement( NAME USER, XMLATTRIBUTES (U.id_user AS id, PO.position AS POSITION,
U.password AS PASSWORD, U.user_name AS username, U.email AS email), U.first_name, ' ', U.last_name))
)
FROM webgallery.t_user AS U
JOIN webgallery.t_position AS PO ON U.id_position = PO.id_position
WHERE PO.position = 'User'
)

-------------------------------------------------------------------------------------------------------------------

CREATE TABLE webgallery.t_picture_audit
(
  username VARCHAR(20) NOT NULL,
  date_change TIMESTAMP NOT NULL,
  operation VARCHAR(20) NOT NULL
)INHERITS(webgallery.t_picutre);

CREATE OR REPLACE FUNCTION webgallery.process_t_picture_audit()
  RETURNS "trigger" AS
  $$
    BEGIN
      IF (TG_OP = 'DELETE') THEN
        INSERT INTO webgallery.t_picture_audit VALUES (OLD.*, user, now(), 'PICTURE WAS DELETED');
        RETURN NULL;
      ELSEIF (TG_OP = 'UPDATE') THEN
        INSERT INTO webgallery.t_picture_audit VALUES (NEW.*, user, now(), 'PICTURE WAS UPDATED');
        RETURN NULL;
      ELSEIF (TG_OP = 'INSERT') THEN
        INSERT INTO webgallery.t_picture_audit VALUES (NEW.*, user, now(), 'PICTURE WAS ADDED');
        RETURN NULL;
      END IF;
      RETURN NULL;
END;
  $$
  LANGUAGE 'plpgsql' VOLATILE;

 CREATE TRIGGER trigger_t_picture_audit
  BEFORE INSERT OR UPDATE  OR DELETE
  ON webgallery.t_picutre
  FOR EACH ROW
  EXECUTE PROCEDURE webgallery.t_picture_audit();

  ---------------------------------------------------------------------------------------------------------------------
  
  
  CREATE FUNCTION webgallery.process_t_user_data_insert_update_check()
Returns trigger AS
$$
BEGIN
       IF (TG_OP = 'INSERT') THEN
            IF(select exists(select user_name from webgallery.t_user where t_user.user_name=NEW.user_name or t_user.email=NEW.email))
            THEN RAISE EXCEPTION 'DANNIY EMAIL ILI IMJA POLZOVATELJA UZE ZANETO!';
            END IF;

       END IF;
       IF (TG_OP = 'UPDATE') THEN
            IF(select exists(select user_name from webgallery.t_user where t_user.user_name!=NEW.user_name and t_user.email=NEW.email))
            THEN RAISE EXCEPTION 'DANNIY EMAIL ILI IMJA POLZOVATELJA UZE ZANETO!';
            END IF;

       END IF;
       RETURN NEW;
END

$$
Language 'plpgsql';

CREATE TRIGGER trigger_t_user_data_insert_update_check
BEFORE INSERT OR UPDATE
ON webgallery.t_user
FOR EACH ROW EXECUTE PROCEDURE webgallery.process_t_user_data_insert_update_check();

-----------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION webgallery.process_t_picture_image_url_check()
Returns trigger AS
$$
BEGIN
       IF (TG_OP = 'INSERT') THEN
            IF(select exists(select picture_url from webgallery.t_picture where t_picture.picture_url=NEW.picture_url))
            THEN RAISE EXCEPTION 'DANNIY URL UZE PRISUTSTVUET V BAZE DANNIH';
            END IF;

       END IF;
       IF (TG_OP = 'UPDATE') THEN
            IF(select exists(select picture_url from webgallery.t_picture where t_picture.picture_url=NEW.picture_url and t_picture.upl_user_id!=NEW.upl_user_id))
            THEN RAISE EXCEPTION 'DANNIY URL UZE PRISUTSTVUET V BAZE DANNIH';
            END IF;

       END IF;
       RETURN NEW;
END

$$
Language 'plpgsql';

  CREATE TRIGGER trigger_t_picture_image_url_check
  BEFORE INSERT OR UPDATE
  ON webgallery.t_picture
  FOR EACH ROW EXECUTE PROCEDURE webgallery.process_t_picture_image_url_check();
  
-----------------------------------------------------------------------------------------------------------------------

ALTER TABLE webgallery.t_picture
ADD CONSTRAINT chk_url CHECK (picture_url SIMILAR TO ('htt(p|ps)://%.(png|jpg|jpeg|gif|tiff|svg|bmp|dib|jpe|tif|jfif)'));

ALTER TABLE webgallery.t_user
ADD CONSTRAINT chk_firstname CHECK (first_name SIMILAR TO('[A-Za-z]{3,50}'));

ALTER TABLE webgallery.t_user
ADD CONSTRAINT chk_lastname CHECK (last_name SIMILAR TO('[A-Za-z]{3,50}'));

ALTER TABLE webgallery.t_user
ADD CONSTRAINT chk_email CHECK (email SIMILAR TO ('[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,3}'));

ALTER TABLE webgallery.t_user
ADD CONSTRAINT chk_username CHECK (user_name SIMILAR TO ('[A-Za-z0-9_-]{3,20}'));

ALTER TABLE webgallery.t_user_statistics
ADD CONSTRAINT chk_user_total_voted CHECK (total_voted >= 0);

ALTER TABLE webgallery.t_picture_statistics
ADD CONSTRAINT chk_picture_voted CHECK (total_voted >= 0);

ALTER TABLE webgallery.t_picture_statistics
ADD CONSTRAINT chk_picture_downloads CHECK (total_downloads >= 0);

CREATE INDEX user_name_index ON webgallery.t_user (user_name);
CREATE INDEX user_email_index ON webgallery.t_user (email);
CREATE INDEX picture_id_index ON webgallery.t_picture (id_picture);

-----------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW webgallery.top_10_pics AS
SELECT category as Category, picture_url as Picture, SUM(total_voted)+SUM(total_downloads) as Rating, user_name as Username, upl_date as Uploaded
FROM webgallery.t_picture AS P
JOIN webgallery.t_picture_statistics as PS ON P.id_picture = PS.id_picture
JOIN webgallery.t_category AS C ON C.id_category = P.id_category
JOIN webgallery.t_user as U ON P.upl_user_id = U.id_user
GROUP BY Category, Picture,Username, Uploaded
ORDER BY 3 DESC
LIMIT 10

----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW webgallery.top_1_by_genre AS 
SELECT category, picture, Rating, username, uploaded from
  (SELECT
     rank() OVER (PARTITION BY C.category ORDER BY SUM(total_voted)+SUM(total_downloads) DESC) AS rank,
     category as Category, picture_url as Picture, user_name as Username, upl_date as Uploaded, SUM(total_voted)+SUM(total_downloads) as Rating
FROM webgallery.t_picture AS P
JOIN webgallery.t_picture_statistics as PS ON P.id_picture = PS.id_picture
JOIN webgallery.t_category AS C ON C.id_category = P.id_category
JOIN webgallery.t_user as U ON P.upl_user_id = U.id_user
GROUP BY Category, Picture,Username, Uploaded
 ) sq
WHERE rank=1

-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW webgallery.last_added_by_genre AS 
SELECT category, picture, username, uploaded from
  (SELECT
     rank() OVER (PARTITION BY C.category ORDER BY upl_date DESC) AS rank,
     category as Category, picture_url as Picture, user_name as Username, upl_date as Uploaded
FROM webgallery.t_picture AS P
JOIN webgallery.t_picture_statistics as PS ON P.id_picture = PS.id_picture
JOIN webgallery.t_category AS C ON C.id_category = P.id_category
JOIN webgallery.t_user as U ON P.upl_user_id = U.id_user
GROUP BY Category, Picture,Username, Uploaded
 ) sq
WHERE rank=1

----------------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE VIEW webgallery.top_3_last_added AS
SELECT picture_url as Picture, category as Category, user_name as Username, upl_date as Uploaded
FROM webgallery.t_picture AS P
JOIN webgallery.t_picture_statistics as PS ON P.id_picture = PS.id_picture
JOIN webgallery.t_user as U ON P.upl_user_id = U.id_user
JOIN webgallery.t_category AS C ON C.id_category = P.id_category
ORDER BY 4 DESC
LIMIT 3

-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW webgallery.users_and_statistics AS
SELECT user_name as username, P.position as status, first_name as firstname, last_name as lastname, email as email, U.password as hashed_password, avatar as avatar, total_voted as Likes, COUNT (PI.id_picture) as TotalPictures
FROM webgallery.t_user as U
JOIN webgallery.t_user_statistics as US ON U.id_user = US.id_user
JOIN webgallery.t_position AS P ON U.id_position = P.id_position
LEFT JOIN webgallery.t_picture AS PI ON U.id_user = PI.upl_user_id
GROUP BY 1,2,3,4,5,6,7,8
ORDER BY status ASC

-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW webgallery.picture_and_statistics AS
SELECT picture_url as Picture, category as category, user_name as username, upl_date as uploaded, total_voted as Likes, total_downloads as Downloads
FROM webgallery.t_picture AS P
JOIN webgallery.t_picture_statistics as PS ON P.id_picture = PS.id_picture
JOIN webgallery.t_user as U ON P.upl_user_id = U.id_user
JOIN webgallery.t_category AS C ON C.id_category = P.id_category
ORDER BY username ASC

-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW webgallery.top_5_most_rated_users AS
SELECT user_name as username, avatar as avatar, P.position as status, total_voted as Likes, COUNT (PI.id_picture) as TotalPictures
FROM webgallery.t_user as U
JOIN webgallery.t_user_statistics as US ON U.id_user = US.id_user
JOIN webgallery.t_position AS P ON U.id_position = P.id_position
LEFT JOIN webgallery.t_picture AS PI ON U.id_user = PI.upl_user_id
GROUP BY 1,2,3,4
ORDER BY Likes DESC
LIMIT 5

-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW webgallery.most_discussed_images AS
SELECT picture_url as Picture, category as category, upl_date as Uploaded, user_name as username, COUNT(comment) as TotalComments
FROM webgallery.t_picture AS P
JOIN webgallery.t_picture_statistics as PS ON P.id_picture = PS.id_picture
JOIN webgallery.t_comment as CO ON CO.id_picture = P.id_picture
JOIN webgallery.t_category AS C ON C.id_category = P.id_category
JOIN webgallery.t_user AS U ON P.upl_user_id = U.id_user
GROUP BY 1,2,3,4
HAVING COUNT(comment) = (
SELECT MAX(TotalComments) as MaxCommets
FROM
(
SELECT picture_url as Picture, COUNT(comment) as TotalComments
FROM webgallery.t_picture AS P
JOIN webgallery.t_comment as CO ON CO.id_picture = P.id_picture
GROUP BY 1
) as t
)

---------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW webgallery.genre_amount AS
SELECT category as categories, COUNT(id_picture) as TotalPics
FROM webgallery.t_category as C
LEFT JOIN webgallery.t_Picture as P ON C.id_category = P.id_category
GROUP BY 1
ORDER BY 2 DESC

--------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW webgallery.web_gallery_statistics AS
SELECT 'Total users:' as Statistic_criteria, COUNT(id_user) as Statistic_number
FROM webgallery.t_user
UNION ALL
SELECT 'Administrators:', COUNT(id_user)
FROM webgallery.t_user
WHERE t_user.id_position = 2
UNION ALL
SELECT 'Registered Users:', COUNT(id_user)
FROM webgallery.t_user
WHERE t_user.id_position = 1
UNION ALL
SELECT 'Total Pictures:', COUNT(id_picture)
FROM webgallery.t_picture
UNION ALL
SELECT 'Total Picture Comments:', COUNT(id_comment)
FROM webgallery.t_comment
UNION ALL
SELECT 'Total Picture Categories:', COUNT (id_category)
FROM webgallery.t_category
UNION ALL
SELECT 'Total Image Downloads:', SUM(total_downloads)
FROM webgallery.t_picture_statistics
UNION ALL
SELECT 'Total Image Likes:', SUM(total_voted)
FROM webgallery.t_picture_statistics


------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION webgallery.function_user_statistics (login varchar(20)) RETURNS TABLE(username varchar(20), user_position varchar(20),total_voted integer, total_images bigint) AS
$$

BEGIN

RETURN QUERY
SELECT U.user_name as Username, PO.position as user_type, US.total_voted as Rating, COUNT(P.picture_url) as TotalImages
FROM webgallery.t_user_statistics AS US
JOIN webgallery.t_user AS U ON U.id_user = US.id_user
JOIN webgallery.t_picture as P ON U.id_user = P.upl_user_id
JOIN webgallery.t_position as PO ON U.id_position = PO.id_position
WHERE U.user_name = login
GROUP BY Username, Rating, PO.position;

END;

$$
Language 'plpgsql';

SELECT * FROM webgallery.function_user_statistics('JohnDoe');

-------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION webgallery.function_user_data (login varchar(20)) RETURNS TABLE(username varchar(20),status varchar(30),firstname varchar(50),lastname varchar(50),user_email varchar(50),user_password text ,user_avatar text ) AS
$$

BEGIN

RETURN QUERY
SELECT user_name as username, PO.position as status, first_name as firstname, last_name as lastname, email as email, U.password as hashed_password, avatar as avatarlink
FROM webgallery.t_user as U
JOIN webgallery.t_position as PO ON U.id_position = PO.id_position
WHERE U.user_name = login;

END;

$$
Language 'plpgsql';

SELECT * FROM webgallery.function_user_data ('JohnDoe');


-------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION webgallery.function_get_sorted_images_by_category (user_category varchar(20)) RETURNS TABLE(picture text, uploaded date, username varchar(20),user_rating bigint ) AS
$$

BEGIN

RETURN QUERY
SELECT picture_url as picture, upl_date as uploaded, user_name as username, SUM(total_voted) + SUM(total_downloads) as Rating
FROM webgallery.t_picture as P
JOIN webgallery.t_category as C ON P.id_category = C.id_category
JOIN webgallery.t_user as U ON P.upl_user_id = U.id_user
JOIN webgallery.t_picture_statistics as PS ON P.id_picture = PS.id_picture
WHERE C.category = user_category
GROUP BY 1,2,3
ORDER BY 4 DESC;

END;

$$
Language 'plpgsql';

SELECT * FROM webgallery.function_get_sorted_images_by_category ('Nature');

-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION webgallery.function_get_user_images (login varchar(20)) RETURNS TABLE(picture text, user_uploaded date,user_category varchar(30),user_totalvoted integer, user_totaldownloads integer) AS
$$

BEGIN

RETURN QUERY
SELECT picture_url as picture, upl_date as uploaded, category as category, total_voted, total_downloads
FROM webgallery.t_picture as P
JOIN webgallery.t_category as C ON P.id_category = C.id_category
JOIN webgallery.t_user as U ON P.upl_user_id = U.id_user
JOIN webgallery.t_picture_statistics as PS ON P.id_picture = PS.id_picture
WHERE U.user_name = login;
END;

$$
Language 'plpgsql';

SELECT * FROM webgallery.function_get_user_images ('JohnDoe');

-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION webgallery.function_get_picture_comments (picture_id integer) RETURNS TABLE(commentar text, commentar_date date, username varchar(20)) AS
$$

BEGIN
RETURN QUERY
SELECT C.comment as commentary, add_date as comment_date, user_name as added_user
FROM webgallery.t_comment as C
JOIN webgallery.t_picture as P ON C.id_picture = P.id_picture
JOIN webgallery.t_user as U ON C.id_user = U.id_user
WHERE C.id_picture = picture_id;
END;

$$
Language 'plpgsql';

SELECT * FROM webgallery.function_get_picture_comments (1);

-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION webgallery.function_get_picture_info (picture_id integer) RETURNS TABLE(picture text, pic_category varchar(30),totalvoted integer, totaldownloads integer, added date, username varchar(20)) AS
$$

BEGIN
RETURN QUERY

SELECT picture_url as picture,category as category, total_voted as totalvoted, total_downloads as totaldownloads, upl_date as uploaded, user_name as username
FROM webgallery.t_picture as P 
JOIN webgallery.t_user as U ON P.upl_user_id = U.id_user
JOIN webgallery.t_picture_statistics AS PS ON PS.id_picture = P.id_picture
JOIN webgallery.t_category as C ON C.id_category = P.id_category
WHERE P.id_picture = picture_id;
END;

$$
Language 'plpgsql';

SELECT * FROM webgallery.function_get_picture_info (1);

-------------------------------------------------------------------------------------------------------------------------------------------------------



