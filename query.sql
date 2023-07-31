-- SELECT

-- 1. Selezionare tutti gli studenti nati nel 1990 (160)

SELECT * 
FROM `students`
WHERE `date_of_birth` LIKE '1990-%';

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)

SELECT * 
FROM `courses`
WHERE `cfu` > '10';

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni

SELECT * 
FROM `students`
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(`date_of_birth`) > 30;

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di
-- laurea (286)

SELECT `period` , `year` 
FROM `courses`
WHERE `period` = 'I semestre'
AND `year` = '1';

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del
-- 20/06/2020 (21)

SELECT * 
FROM `exams`
WHERE HOUR(`hour`) >= 14
AND date = '2020-06-20';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)

SELECT * 
FROM `degrees`
WHERE `name` LIKE '% Magistrale %'

-- 7. Da quanti dipartimenti è composta l'università? (12)

SELECT COUNT(`id`) 
FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)

SELECT * 
FROM `teachers`
WHERE `phone` IS NULL;


-- GROUP BY

-- 1. Contare quanti iscritti ci sono stati ogni anno

SELECT YEAR(`enrolment_date`) as `anno` , COUNT(`id`) 
FROM `students`
GROUP BY `anno`;

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT (`office_address`) , COUNT(`id`) 
FROM `teachers`
GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame

SELECT (`exam_id`) as `appello` , ROUND(AVG(`vote`),2) as `media` 
FROM `exam_student`
GROUP BY `appello`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT (`department_id`) , COUNT(`name`) 
FROM `degrees`
GROUP BY `department_id`;


-- JOIN

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT S.`registration_number` as `studenti` , D.`name` as `corso` 
FROM `degrees` AS D
JOIN `students` AS S ON D.`id` = S.`degree_id`
WHERE D.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze

SELECT DEP.`name` as `dipartimento` , DEG.`name` as `corso`
FROM `departments` as DEP
JOIN `degrees` as DEG ON DEP.`id` = DEG.`department_id`
WHERE DEP.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT T.`surname` as `insegnante`, C.`name` as `corso` 
FROM `courses` as C
JOIN `course_teacher` as CT ON C.`id` = CT.`course_id`
JOIN `teachers` as T ON T.`id` = CT.`teacher_id`
WHERE T.`id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
-- relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT S.`name`, S.`surname` , DEG.`name` as `corso` , DEG.`level` `tipologia` , DEP.`name` as `dipartimento` 
FROM `students` as S
JOIN `degrees` as DEG ON DEG.`id` = S.`degree_id`
JOIN `departments` as DEP ON DEP.`id` = DEG.`department_id`
ORDER BY S.`name` , S.`surname` ASC;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT T.`surname` as `insegnante` , D.`name` as `corso_laurea` , C.`name` as `corso` 
FROM `degrees` as D 
JOIN `courses` as C ON D.`id` = C.`degree_id`
JOIN `course_teacher` as CT ON C.`id` = CT.`course_id`
JOIN `teachers` as T ON T.`id` = CT.`teacher_id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)



-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
-- superare ciascuno dei suoi esami