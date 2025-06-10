-- Active: 1748246424675@@localhost@3306@dicemeet

DROP TABLE IF EXISTS user_traits;

DROP TABLE IF EXISTS favorite_game;

DROP TABLE IF EXISTS game_place;

DROP TABLE IF EXISTS meetup_user;

DROP TABLE IF EXISTS trait;

DROP TABLE IF EXISTS availability;

DROP TABLE IF EXISTS favorite_place;

DROP TABLE IF EXISTS rating;

DROP TABLE IF EXISTS message;

DROP TABLE IF EXISTS user;

DROP TABLE IF EXISTS meetup;

DROP TABLE IF EXISTS place;

DROP TABLE IF EXISTS city;

DROP TABLE IF EXISTS country;

DROP TABLE IF EXISTS game;

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

INSERT INTO
    user_traits (user_id, traits_id)
VALUES (1, 3),
    (2, 1),
    (3, 2);

CREATE TABLE availability (
    id INT PRIMARY KEY AUTO_INCREMENT,
    day_of_week SMALLINT NOT NULL,
    start_time TIME,
    end_time TIME,
    user_id INT NOT NULL,
    Foreign Key (user_id) REFERENCES user (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    availability (
        day_of_week,
        start_time,
        end_time,
        user_id
    )
VALUES (6, "19:30:00", NULL, 2),
    (2, NULL, NULL, 2),
    (1, "17:00:00", "21:30:00", 3);

CREATE TABLE place (
    id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(80) NOT NULL,
    street_number INT NOT NULL,
    capacity SMALLINT NOT NULL,
    google_id VARCHAR(150) NOT NULL,
    city_id INT NOT NULL,
    Foreign Key (city_id) REFERENCES city (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    place (
        street,
        street_number,
        capacity,
        google_id,
        city_id
    )
VALUES (
        "Rue des chartreux",
        41,
        60,
        "16648484946464",
        2
    ),
    (
        "Rue des alpes",
        10,
        NULL,
        "16648956323232",
        6
    ),
    (
        "Rue de la paix",
        1,
        2000,
        "00252026566565",
        2
    );

CREATE TABLE favorite_place (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    place_id INT NOT NULL,
    Foreign Key (user_id) REFERENCES user (id),
    Foreign Key (place_id) REFERENCES place (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    favorite_place (user_id, place_id)
VALUES (2, 3),
    (2, 2),
    (1, 1);

CREATE TABLE game (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) UNIQUE NOT NULL,
    min_player SMALLINT NOT NULL,
    max_player SMALLINT NOT NULL,
    description TEXT,
    img_url VARCHAR(150),
    difficulty CHAR(2)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    game (
        name,
        min_player,
        max_player,
        description,
        img_url,
        difficulty
    )
VALUES (
        "Terraforming Mars",
        1,
        5,
        "Le meilleur jeu du monde",
        "/assets/img-terraformingmars",
        "5D"
    ),
    (
        "Catan",
        2,
        8,
        "Un bon jeu",
        "/assets/img-catan",
        "2B"
    ),
    (
        "Agricola",
        2,
        4,
        NULL,
        "/assets/img-agricola",
        "3D"
    );

CREATE TABLE favorite_game (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    Foreign Key (user_id) REFERENCES user (id),
    Foreign Key (game_id) REFERENCES game (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    favorite_game (user_id, game_id)
VALUES (1, 3),
    (2, 3),
    (1, 1);

CREATE TABLE game_place (
    id INT PRIMARY KEY AUTO_INCREMENT,
    place_id INT NOT NULL,
    game_id INT NOT NULL,
    Foreign Key (place_id) REFERENCES place (id),
    Foreign Key (game_id) REFERENCES game (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    game_place (place_id, game_id)
VALUES (1, 2),
    (2, 3),
    (3, 1);

CREATE TABLE meetup (
    id INT PRIMARY KEY AUTO_INCREMENT,
    time DATETIME NOT NULL,
    capacity SMALLINT NOT NULL,
    place_id INT NOT NULL,
    game_id INT NOT NULL,
    Foreign Key (place_id) REFERENCES place (id),
    Foreign Key (game_id) REFERENCES game (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    meetup (
        time,
        capacity,
        place_id,
        game_id
    )
VALUES (
        "2025-06-18 16:30:00",
        4,
        2,
        3
    ),
    (
        "2025-07-28 16:30:00",
        2,
        1,
        2
    ),
    (
        "2023-06-18 20:30:00",
        8,
        1,
        3
    );

CREATE TABLE meetup_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    meetup_id INT NOT NULL,
    Foreign Key (user_id) REFERENCES user (id),
    Foreign Key (meetup_id) REFERENCES meetup (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    meetup_user (user_id, meetup_id)
VALUES (1, 2),
    (2, 3),
    (3, 1);

CREATE TABLE rating (
    id INT PRIMARY KEY AUTO_INCREMENT,
    value SMALLINT NOT NULL,
    time DATETIME NOT NULL,
    comment TEXT,
    user_rated INT NOT NULL,
    rated_by_user INT NOT NULL,
    meetup_id INT NOT NULL,
    Foreign Key (user_rated) REFERENCES user (id),
    Foreign Key (rated_by_user) REFERENCES user (id),
    Foreign Key (meetup_id) REFERENCES meetup (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    rating (
        value,
        time,
        comment,
        user_rated,
        rated_by_user,
        meetup_id
    )
VALUES (
        4,
        "2025-06-18 16:30:00",
        "Super joueur très sympa",
        1,
        2,
        2
    ),
    (
        1,
        "2025-06-02 11:30:00",
        "Gros blaireau",
        1,
        1,
        3
    ),
    (
        5,
        "2025-06-02 11:30:00",
        "Top",
        1,
        2,
        1
    );

CREATE TABLE message (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user1_id INT NOT NULL,
    user2_id INT,
    content TEXT,
    meetup_id INT,
    time DATETIME NOT NULL,
    is_read BOOLEAN NOT NULL,
    meetup_invitation_id INT UNIQUE,
    Foreign Key (user1_id) REFERENCES user (id),
    Foreign Key (user2_id) REFERENCES user (id),
    Foreign Key (meetup_id) REFERENCES meetup (id),
    Foreign Key (meetup_invitation_id) REFERENCES meetup (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

INSERT INTO
    message (
        user1_id,
        user2_id,
        content,
        meetup_id,
        time,
        is_read,
        meetup_invitation_id
    )
VALUES (
        1,
        2,
        "coucou toi",
        NULL,
        "2025-06-02 11:30:00",
        FALSE,
        NULL
    ),
    (
        1,
        NULL,
        "Qui pour venir jouer",
        2,
        "2025-11-22 18:30:00",
        FALSE,
        2
    ),
    (
        1,
        3,
        "coucou toi t gentil ct bien la game",
        2,
        "2025-06-02 18:30:00",
        TRUE,
        NULL
    );