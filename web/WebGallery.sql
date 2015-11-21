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
	avatar bytea NULL
);

------------------------------------------------------------------------------------------------------
-- Table stores picture information.

CREATE TABLE webgallery.t_picture(
	id_picture SERIAL PRIMARY KEY,
	id_category INTEGER NOT NULL references webgallery.t_category(id_category),
	upl_user_id INTEGER NOT NULL references webgallery.t_user(id_user),
	upl_date DATE NOT NULL,                                                        -- Will be function that automatically puts upl_date in the field.
	description VARCHAR(150) NULL,
	picture bytea NOT NULL
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
	total_voted INTEGER NOT NULL DEFAULT 0,
	user_rating REAL NOT NULL DEFAULT 0                                            -- Type REAL takes up less space than DOUBLE PRECISION
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

------------------------------------------------------------------------------------------------------
-- Table t_position INSERTS.

INSERT INTO webgallery.t_position (position) VALUES ('User');
INSERT INTO webgallery.t_position (position) VALUES ('Moderator');
INSERT INTO webgallery.t_position (position) VALUES ('Administrator');

------------------------------------------------------------------------------------------------------