-- 7. В подключенном MySQL репозитонии создать базу данных 'Друзья человека'

CREATE DATABASE friends_of_human;

-- 8. Создать таблицы с иерархией из диаграммы в БД

USE friends_of human;

CREATE TABLE
    animal_classes (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        Class_name VARCHAR(20)
    );

INSERT INTO
    animal_classes (Class_name)
VALUES ('вьючные'), ('домашние');

CREATE TABLE
    packed_animals (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        Genus_name VARCHAR (20),
        Class_id INT,
        FOREIGN KEY (Class_id) REFERENCES animal_classes (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO
    packed_animals (Genus_name, Class_id)
VALUES ('Лошади', 1), ('Ослы', 1), ('Верблюды', 1);

CREATE TABLE
    home_animals (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        Genus_name VARCHAR (20),
        Class_id INT,
        FOREIGN KEY (Class_id) REFERENCES animal_classes (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO
    home_animals (Genus_name, Class_id)
VALUES ('Кошки', 2), ('Собаки', 2), ('Хомяки', 2);

CREATE TABLE
    cats (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(20),
        birthdate DATE,
        command VARCHAR(50),
        genus_id int,
        Foreign KEY (genus_id) REFERENCES home_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );

-- 9. Заполнить низкоуровневые таблицы именами(животных), командами которые они выполняют и датами рождения

INSERT INTO
    cats (
        name,
        birthdate,
        command,
        genus_id
    )
VALUES (
        'Пуся',
        '2022-01-01',
        'кушать',
        1
    ), (
        'Киса',
        '2018-01-01',
        "сюда!",
        1
    ), ('Мурзик', '2017-01-01', NULL, 1);

CREATE TABLE
    dogs (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(20),
        birthday DATE,
        command VARCHAR(50),
        genus_id int,
        Foreign KEY (genus_id) REFERENCES home_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO
    dogs (
        name,
        birthday,
        command,
        genus_id
    )
VALUES (
        'Мухтар',
        '2015-01-01',
        'ко мне, лежать, лапу, голос',
        2
    ), (
        'Тишка',
        '2021-06-12',
        "сидеть, лежать, лапу",
        2
    ), (
        'Шарик',
        '2018-05-01',
        "сидеть, лежать, лапу, след, фас",
        2
    ), (
        'Богатырь',
        '2021-05-10',
        "сидеть, лежать, фу, место",
        2
    );

CREATE TABLE
    hamsters (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(20),
        birthday DATE,
        command VARCHAR(40),
        genus_id int,
        Foreign KEY (genus_id) REFERENCES home_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO
    hamsters (
        name,
        birthday,
        command,
        genus_id
    )
VALUES ('Хома', '2021-10-12', NULL, 3), (
        'Здоровяк',
        '2021-03-12',
        NULL,
        3
    ), ('Рыжик', '2022-07-11', NULL, 3), ('Бурый', '2023-05-10', NULL, 3);

CREATE TABLE
    horses (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(20),
        birthday DATE,
        command VARCHAR(40),
        genus_id int,
        Foreign KEY (genus_id) REFERENCES packed_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO
    horses (
        name,
        birthday,
        command,
        genus_id
    )
VALUES (
        'Гром',
        '2020-01-10',
        'бегом, шагом',
        1
    ), (
        'Молния',
        '2017-03-11',
        "бегом, шагом, хоп",
        1
    ), (
        'Буран',
        '2016-07-04',
        "бегом, шагом, хоп, рысь",
        1
    ), (
        'Гранит',
        '2020-11-10',
        "бегом, шагом, тише",
        1
    );

CREATE TABLE
    donkeys (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(20),
        birthday DATE,
        command VARCHAR(40),
        genus_id int,
        Foreign KEY (genus_id) REFERENCES packed_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO
    donkeys (
        name,
        birthday,
        command,
        genus_id
    )
VALUES ('Тарзан', '2019-04-10', NULL, 2), ('Боря', '2020-03-12', NULL, 2), ('Брут', '2021-07-12', NULL, 2), ('Макак', '2022-12-10', NULL, 2);

CREATE TABLE
    camels (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(20),
        birthday DATE,
        command VARCHAR(40),
        genus_id int,
        Foreign KEY (genus_id) REFERENCES packed_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO
    camels (
        name,
        birthday,
        command,
        genus_id
    )
VALUES (
        'Жетем',
        '2022-04-10',
        'гит, дурр, каш',
        3
    ), (
        'Лила',
        '2019-03-12',
        "гит, дурр",
        3
    ), ('Омлет', '2015-07-12', "каш", 3), (
        'Стиф',
        '2022-12-10',
        "гит, каш",
        3
    );

-- 10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.

DELETE FROM camels;

SELECT
    name,
    birthdate,
    command
FROM horses
UNION
SELECT
    name,
    bitthdate,
    command
FROM donkeys;

-- 11. Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце
-- с точностью до месяца подсчитать возраст животных в новой таблице

CREATE TABLE
    young_animals (
        Id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(20),
        birthdate DATE,
        command VARCHAR(40),
        age_months int
    );

INSERT INTO
    young_animals (
        id,
        name,
        bithdate,
        command,
        age_months 
    )
SELECT
    id,
    name,
    birthdate,
    command,
    TIMESTAMPDIFF(MONTH, birthdate, NOW()) AS age_months
FROM animals
WHERE
    TIMESTAMPDIFF(YEAR, birthdate, NOW()) > 1
    AND TIMESTAMPDIFF(YEAR, birthdate, NOW()) < 3;

-- 12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.

SELECT
    id,
    name,
    birthdate,
    command,
    'cats' AS table_type,
    'cat' AS animal_type
FROM cats
UNION
SELECT
    id,
    name,
    birhdate,
    command,
    'dogs' AS table_type,
    'dog' AS animal_type
FROM dogs
UNION
SELECT
    id,
    name,
    birthdate,
    command,
    'hamsters' AS table_type,
    'hamster' AS animal_type
FROM hamsters
UNION
SELECT
    id,
    name,
    birthdate,
    command,
    'horses' AS table_type,
    'horse' AS animal_type
FROM horses
UNION
SELECT
    id,
    name,
    birthdate,
    command,
    'donkeys' AS table_type,
    'donkey' AS animal_type
FROM donkeys
UNION
SELECT
    id,
    name,
    birthdate,
    command,
    'camels' AS table_type,
    'camel' AS animal_type
FROM camels