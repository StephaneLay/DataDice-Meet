-- Active: 1748246424675@@localhost@3306@dicemeet

DROP TABLE IF EXISTS trait;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS user_traits;
DROP TABLE IF EXISTS availability;

CREATE TABLE trait (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL UNIQUE
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    trait (name)
VALUES ("calme"),
    ("bavard"),
    ("aime le risque");

CREATE TABLE country (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL UNIQUE
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    country (name)
VALUES ("France"),
    ("Belgique"),
    ("Suisse");

CREATE TABLE city (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL,
    country_id INT NOT NULL,
    Foreign Key (country_id) REFERENCES country (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    city (name, country_id)
VALUES ("Lyon", 1),
    ("Paris", 1),
    ("Marseille", 1),
    ("Bruxelles", 2),
    ("Liège", 2),
    ("Bruges", 2),
    ("Genève", 3),
    ("Zurich", 3),
    ("Lausanne", 3);

CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    mail VARCHAR(80) NOT NULL,
    password VARCHAR(30) NOT NULL,
    bio TEXT,
    creation_date DATE NOT NULL,
    city_id INT NOT NULL,
    Foreign Key (city_id) REFERENCES city (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    user (
        mail,
        password,
        bio,
        creation_date,
        city_id
    )
VALUES (
        "stephane.lay@hotmail.fr",
        "utsythedog",
        "Bonjour je suis Stf l'admin du site",
        NOW(),
        1
    ),
    (
        "jeanmichel@hotmail.fr",
        "Password",
        "Bonjour je suis jeanmichel",
        NOW(),
        5
    ),
    (
        "luna.lay@hotmail.fr",
        "lunahotdog",
        "Bonjour je suis Luna la chienchoute",
        NOW(),
        1
    )

CREATE TABLE user_traits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    traits_id INT NOT NULL,
    Foreign Key (user_id) REFERENCES user (id),
    Foreign Key (traits_id) REFERENCES trait (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO user_traits  (user_id,traits_id) VALUES (1,3),(2,1),(3,2);