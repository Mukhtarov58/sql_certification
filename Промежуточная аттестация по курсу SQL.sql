-- Промежуточная аттестация по курсу SQL
/*
1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/
DELIMITER $$
CREATE FUNCTION format_seconds(input_seconds INT) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    DECLARE seconds INT DEFAULT 0;
    DECLARE result VARCHAR(255);
    WHILE input_seconds >= 86400 DO
        SET days = days + 1;
        SET input_seconds = input_seconds - 86400;
    END WHILE;
    WHILE input_seconds >= 3600 DO
        SET hours = hours + 1;
        SET input_seconds = input_seconds - 3600;
    END WHILE;
    WHILE input_seconds >= 60 DO
        SET minutes = minutes + 1;
        SET input_seconds = input_seconds - 60;
    END WHILE;
    SET seconds = input_seconds;
    SET result = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');
    RETURN result;
END $$
DELIMITER ;

SELECT format_seconds(55555);
-- -----------------------------------------------------------------------------------------------------------------------------------
/*
2. Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10
*/

DELIMITER $$
CREATE PROCEDURE get_even_numbers()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE res VARCHAR(255) DEFAULT '';

    WHILE i < 10 DO
        IF i % 2 = 0 THEN
            IF res = '' THEN
                SET res = i;
            ELSE
                SET res = CONCAT(res, ',', i);
            END IF;
        END IF;
        SET i = i + 1;
    END WHILE;
    SELECT res AS even_numbers;
END $$
DELIMITER ;

CALL get_even_numbers();
