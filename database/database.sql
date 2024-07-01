--
-- PostgreSQL database cluster dump
--

-- Started on 2024-07-01 16:06:40

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE admin;
ALTER ROLE admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:1B3O3GjCLOl4kMGSkjTJkQ==$5ImJL8Nyg9sR1TK7B+ehT2S/4sCwICd4NC6xKLGIuj0=:5AtBkvFts1gpB/VuoDaslWFM8P0g4xWlE7V9GQR/JkA=';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:dNyGnpmYf2nJfIccRpBsuw==$C6VtXgrbRiVXWkcaFZA/F2X1bYqXRLNoNtwzPPFbA9U=:jCnH/Wlkr9mxL69DxJLXzJkvw92BS2ZLY0G8kgAB0yg=';
CREATE ROLE reader;
ALTER ROLE reader WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:XU+jxhoNwBKSX4d8NT5lcQ==$8xQdkZwDk10pxak0TIQcuh1bq4oBWFhHIt88jfLlP+k=:QqV9nbWoThhHxZdDD9KL0yVHw9z2bvc3KmSryQ8teNo=';
CREATE ROLE student;
ALTER ROLE student WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:zb2kH+5bJGaNwy1XWYOknQ==$0EX+fy4SxQtPEt82V1XNcMIi+ho3gyA0iFwCDNEJBh0=:5MXA6xND0fsF03tCgBR+5zLVKcuqvcg9ce0PTALbA4g=';
CREATE ROLE teacher;
ALTER ROLE teacher WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:C44pznmJZsyBew6eOw7+dA==$w7IRYnC/SPWuDvNbafNpFxcjfyKl6oSNuqaeucgp/gY=:kkxCTQM3Y2srgeUEkg0qat3ar5c38v8Z00SzaRJzj7Y=';
CREATE ROLE username;
ALTER ROLE username WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:pSHpvZHo1WP0eDVffVFWjQ==$TJM9AYRaHSnCPCxcRtLbS/R5z4anQSV/BvOl6MFhOSE=:2NdRH2xKb0zDQqglN4I5Ie+s+Q3DvIITgJpBETHZgpM=';

--
-- User Configurations
--


--
-- Role memberships
--

GRANT pg_read_all_data TO reader WITH INHERIT TRUE GRANTED BY postgres;






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16rc1
-- Dumped by pg_dump version 16rc1

-- Started on 2024-07-01 16:06:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2024-07-01 16:06:41

--
-- PostgreSQL database dump complete
--

--
-- Database "tester" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16rc1
-- Dumped by pg_dump version 16rc1

-- Started on 2024-07-01 16:06:41

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4868 (class 1262 OID 17662)
-- Name: tester; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE tester WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE tester OWNER TO postgres;

\connect tester

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4869 (class 0 OID 0)
-- Name: tester; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER ROLE reader IN DATABASE tester SET role TO 'pg_read_all_data';


\connect tester

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: tester; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA tester;


ALTER SCHEMA tester OWNER TO pg_database_owner;

--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA tester; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA tester IS 'standard public schema';


--
-- TOC entry 231 (class 1255 OID 17927)
-- Name: getclosedtestsforstudent(integer); Type: FUNCTION; Schema: tester; Owner: postgres
--

CREATE FUNCTION tester.getclosedtestsforstudent(student integer) RETURNS TABLE(testid integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select
        gt.testid
    from
        student s
	join
		grouptest gt
	on
		s.groupid = gt.groupid
	join
		test tst
	on
		tst.testid = gt.testid
    where
         s.studentid = student and tst.endtime < current_timestamp;
end;
$$;


ALTER FUNCTION tester.getclosedtestsforstudent(student integer) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 17929)
-- Name: getdonetestsforstudent(integer); Type: FUNCTION; Schema: tester; Owner: postgres
--

CREATE FUNCTION tester.getdonetestsforstudent(student integer) RETURNS TABLE(testid integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select distinct 
        q.testid
    from
        student s
	join
		answer ans
	on
		ans.studentid = s.studentid
	join 
		question q
	on
		ans.questionid = q.questionid
    where
         s.studentid = student;
end;
$$;


ALTER FUNCTION tester.getdonetestsforstudent(student integer) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 17928)
-- Name: getopentestsforstudent(integer); Type: FUNCTION; Schema: tester; Owner: postgres
--

CREATE FUNCTION tester.getopentestsforstudent(student integer) RETURNS TABLE(testid integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select
        gt.testid
    from
        student s
	join
		grouptest gt
	on
		s.groupid = gt.groupid
	join
		test tst
	on
		tst.testid = gt.testid
    where
         s.studentid = student and tst.endtime > current_timestamp;
end;
$$;


ALTER FUNCTION tester.getopentestsforstudent(student integer) OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 17926)
-- Name: setanswers(integer, jsonb); Type: FUNCTION; Schema: tester; Owner: postgres
--

CREATE FUNCTION tester.setanswers(student integer, answers jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
    answerItem JSONB;
begin
   	for i in 0 .. jsonb_array_length(answers) - 1
    loop
        answerItem := answers -> i;
	declare
            questionID INT := (answerItem->>'questionID')::INT;
            answerText TEXT := answerItem->>'answerText';
        begin
            insert into asnwer (studentid, questionid, answer)
            values (student, questionID, answerText);
        exception
            when others then
                rollback;
                raise;
        end;
    end loop;
end;
$$;


ALTER FUNCTION tester.setanswers(student integer, answers jsonb) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 17911)
-- Name: answer; Type: TABLE; Schema: tester; Owner: postgres
--

CREATE TABLE tester.answer (
    answer_id integer NOT NULL,
    student_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_content character varying(400) NOT NULL
);


ALTER TABLE tester.answer OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17910)
-- Name: answer_answer_id_seq; Type: SEQUENCE; Schema: tester; Owner: postgres
--

ALTER TABLE tester.answer ALTER COLUMN answer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester.answer_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 17900)
-- Name: answervariant; Type: TABLE; Schema: tester; Owner: postgres
--

CREATE TABLE tester.answervariant (
    answervariant_id integer NOT NULL,
    answer_content character varying(400),
    question_id integer NOT NULL
);


ALTER TABLE tester.answervariant OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17899)
-- Name: answervariant_answervariant_id_seq; Type: SEQUENCE; Schema: tester; Owner: postgres
--

ALTER TABLE tester.answervariant ALTER COLUMN answervariant_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester.answervariant_answervariant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 17872)
-- Name: grouptest; Type: TABLE; Schema: tester; Owner: postgres
--

CREATE TABLE tester.grouptest (
    group_test_id integer NOT NULL,
    group_id integer NOT NULL,
    test_id integer NOT NULL
);


ALTER TABLE tester.grouptest OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17871)
-- Name: grouptest_group_test_id_seq; Type: SEQUENCE; Schema: tester; Owner: postgres
--

ALTER TABLE tester.grouptest ALTER COLUMN group_test_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester.grouptest_group_test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 17888)
-- Name: question; Type: TABLE; Schema: tester; Owner: postgres
--

CREATE TABLE tester.question (
    question_id integer NOT NULL,
    question_content character varying(400) NOT NULL,
    right_answer character varying(40) NOT NULL,
    score integer DEFAULT 1,
    test_id integer NOT NULL
);


ALTER TABLE tester.question OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17887)
-- Name: question_question_id_seq; Type: SEQUENCE; Schema: tester; Owner: postgres
--

ALTER TABLE tester.question ALTER COLUMN question_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester.question_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 17846)
-- Name: student; Type: TABLE; Schema: tester; Owner: postgres
--

CREATE TABLE tester.student (
    student_id integer NOT NULL,
    second_name character varying(40) NOT NULL,
    first_name character varying(40) NOT NULL,
    third_name character varying(40),
    login character varying(15) NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE tester.student OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17845)
-- Name: student_student_id_seq; Type: SEQUENCE; Schema: tester; Owner: postgres
--

ALTER TABLE tester.student ALTER COLUMN student_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester.student_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 17840)
-- Name: studygroup; Type: TABLE; Schema: tester; Owner: postgres
--

CREATE TABLE tester.studygroup (
    group_id integer NOT NULL,
    group_name character varying(15) NOT NULL
);


ALTER TABLE tester.studygroup OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17839)
-- Name: studygroup_group_id_seq; Type: SEQUENCE; Schema: tester; Owner: postgres
--

ALTER TABLE tester.studygroup ALTER COLUMN group_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester.studygroup_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 17832)
-- Name: teacher; Type: TABLE; Schema: tester; Owner: postgres
--

CREATE TABLE tester.teacher (
    teacher_id integer NOT NULL,
    second_name character varying(40) NOT NULL,
    first_name character varying(40) NOT NULL,
    third_name character varying(40),
    login character varying(40) NOT NULL
);


ALTER TABLE tester.teacher OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17831)
-- Name: teacher_teacher_id_seq; Type: SEQUENCE; Schema: tester; Owner: postgres
--

ALTER TABLE tester.teacher ALTER COLUMN teacher_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester.teacher_teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 17859)
-- Name: test; Type: TABLE; Schema: tester; Owner: postgres
--

CREATE TABLE tester.test (
    test_id integer NOT NULL,
    test_name character varying(40) NOT NULL,
    discipline character varying(40) NOT NULL,
    start_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    end_time timestamp without time zone NOT NULL,
    minimum_score integer DEFAULT 0,
    teacher_id integer NOT NULL
);


ALTER TABLE tester.test OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17858)
-- Name: test_test_id_seq; Type: SEQUENCE; Schema: tester; Owner: postgres
--

ALTER TABLE tester.test ALTER COLUMN test_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester.test_test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4862 (class 0 OID 17911)
-- Dependencies: 230
-- Data for Name: answer; Type: TABLE DATA; Schema: tester; Owner: postgres
--

COPY tester.answer (answer_id, student_id, question_id, answer_content) FROM stdin;
1	1	1	2
2	1	2	4
3	1	3	12
4	1	4	1
5	1	5	2
6	3	6	12
7	3	7	3
8	3	8	124
9	4	6	2
10	4	7	3
11	4	8	124
33	6	1	4
34	6	2	1
35	6	3	123
36	6	4	123
37	6	5	123
40	6	6	2
41	6	7	3
42	6	8	124
\.


--
-- TOC entry 4860 (class 0 OID 17900)
-- Dependencies: 228
-- Data for Name: answervariant; Type: TABLE DATA; Schema: tester; Owner: postgres
--

COPY tester.answervariant (answervariant_id, answer_content, question_id) FROM stdin;
17	Это сладкий десертный пирог, состоящий, из нескольких выпеченных коржей и крема в качестве прослойки и украшения	6
18	Это ложь	6
19	Не знаю	6
20	Рассказать анекдот про медведя	7
21	Изобразить дурачка/дурочку	7
22	Рассказать о своих планах	7
23	Да	8
24	Да	8
25	Нет	8
26	Да	8
15	4	5
1	3	1
2	4	1
3	5	1
4	3	2
5	4	2
6	8	2
7	6	2
8	-2	3
9	2	3
10	4	3
11	3	4
12	4	4
13	5	4
14	3	5
16	5	5
\.


--
-- TOC entry 4856 (class 0 OID 17872)
-- Dependencies: 224
-- Data for Name: grouptest; Type: TABLE DATA; Schema: tester; Owner: postgres
--

COPY tester.grouptest (group_test_id, group_id, test_id) FROM stdin;
1	1	1
2	2	1
3	2	2
\.


--
-- TOC entry 4858 (class 0 OID 17888)
-- Dependencies: 226
-- Data for Name: question; Type: TABLE DATA; Schema: tester; Owner: postgres
--

COPY tester.question (question_id, question_content, right_answer, score, test_id) FROM stdin;
1	2+2=	2	1	1
2	2+2*2=	4	1	1
3	Чему равен x? x^2 = 4	12	1	1
4	2+2=	2	1	1
5	2+2=	3	1	1
6	Что такое торт?	12	1	2
7	Как рассмешить Бога?	3	2	2
8	Изи 2 балла просто выбери все да	124	2	2
\.


--
-- TOC entry 4852 (class 0 OID 17846)
-- Dependencies: 220
-- Data for Name: student; Type: TABLE DATA; Schema: tester; Owner: postgres
--

COPY tester.student (student_id, second_name, first_name, third_name, login, group_id) FROM stdin;
1	Соловьев	Александр	Юрьевич	solovievAYs	1
2	Егорова	Аделина	Мироновна	egorovaAMs	1
3	Тимофеева	Анастасия	Кирилловна	timofeevaAKs	2
4	Жуков	Артём	Максимович	zhukovAMs	2
5	Столбов	Михаил	Евгеньевич	stolbovMEs	1
6	Тестов	Тест	Тестович	tests	2
\.


--
-- TOC entry 4850 (class 0 OID 17840)
-- Dependencies: 218
-- Data for Name: studygroup; Type: TABLE DATA; Schema: tester; Owner: postgres
--

COPY tester.studygroup (group_id, group_name) FROM stdin;
1	ЦИСБ-34
2	ЦСИИ-35
\.


--
-- TOC entry 4848 (class 0 OID 17832)
-- Dependencies: 216
-- Data for Name: teacher; Type: TABLE DATA; Schema: tester; Owner: postgres
--

COPY tester.teacher (teacher_id, second_name, first_name, third_name, login) FROM stdin;
1	Петров	Валерий	Анатольевич	petrovVAt
2	Балашова	Наталья	Николевна	balashovaNNt
3	Тестовый	Преподаватель	Тест	teacht
\.


--
-- TOC entry 4854 (class 0 OID 17859)
-- Dependencies: 222
-- Data for Name: test; Type: TABLE DATA; Schema: tester; Owner: postgres
--

COPY tester.test (test_id, test_name, discipline, start_time, end_time, minimum_score, teacher_id) FROM stdin;
2	Тестовый тест 2	Интеллект	2023-10-08 15:30:00	2023-12-27 15:30:00	2	2
1	Тестовый тест 1	Математика	2023-10-23 10:57:00	2023-12-08 15:30:00	2	1
\.


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 229
-- Name: answer_answer_id_seq; Type: SEQUENCE SET; Schema: tester; Owner: postgres
--

SELECT pg_catalog.setval('tester.answer_answer_id_seq', 46, true);


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 227
-- Name: answervariant_answervariant_id_seq; Type: SEQUENCE SET; Schema: tester; Owner: postgres
--

SELECT pg_catalog.setval('tester.answervariant_answervariant_id_seq', 304, true);


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 223
-- Name: grouptest_group_test_id_seq; Type: SEQUENCE SET; Schema: tester; Owner: postgres
--

SELECT pg_catalog.setval('tester.grouptest_group_test_id_seq', 28, true);


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 225
-- Name: question_question_id_seq; Type: SEQUENCE SET; Schema: tester; Owner: postgres
--

SELECT pg_catalog.setval('tester.question_question_id_seq', 103, true);


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 219
-- Name: student_student_id_seq; Type: SEQUENCE SET; Schema: tester; Owner: postgres
--

SELECT pg_catalog.setval('tester.student_student_id_seq', 6, true);


--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 217
-- Name: studygroup_group_id_seq; Type: SEQUENCE SET; Schema: tester; Owner: postgres
--

SELECT pg_catalog.setval('tester.studygroup_group_id_seq', 2, true);


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 215
-- Name: teacher_teacher_id_seq; Type: SEQUENCE SET; Schema: tester; Owner: postgres
--

SELECT pg_catalog.setval('tester.teacher_teacher_id_seq', 3, true);


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 221
-- Name: test_test_id_seq; Type: SEQUENCE SET; Schema: tester; Owner: postgres
--

SELECT pg_catalog.setval('tester.test_test_id_seq', 33, true);


--
-- TOC entry 4695 (class 2606 OID 17915)
-- Name: answer answer_pkey; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (answer_id);


--
-- TOC entry 4693 (class 2606 OID 17904)
-- Name: answervariant answervariant_pkey; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.answervariant
    ADD CONSTRAINT answervariant_pkey PRIMARY KEY (answervariant_id);


--
-- TOC entry 4689 (class 2606 OID 17876)
-- Name: grouptest grouptest_pkey; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.grouptest
    ADD CONSTRAINT grouptest_pkey PRIMARY KEY (group_test_id);


--
-- TOC entry 4691 (class 2606 OID 17893)
-- Name: question question_pkey; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (question_id);


--
-- TOC entry 4683 (class 2606 OID 17852)
-- Name: student student_login_key; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.student
    ADD CONSTRAINT student_login_key UNIQUE (login);


--
-- TOC entry 4685 (class 2606 OID 17850)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- TOC entry 4681 (class 2606 OID 17844)
-- Name: studygroup studygroup_pkey; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.studygroup
    ADD CONSTRAINT studygroup_pkey PRIMARY KEY (group_id);


--
-- TOC entry 4677 (class 2606 OID 17985)
-- Name: teacher teacher_login_key; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.teacher
    ADD CONSTRAINT teacher_login_key UNIQUE (login);


--
-- TOC entry 4679 (class 2606 OID 17836)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (teacher_id);


--
-- TOC entry 4687 (class 2606 OID 17865)
-- Name: test test_pkey; Type: CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (test_id);


--
-- TOC entry 4702 (class 2606 OID 17921)
-- Name: answer answer_question_id_fkey; Type: FK CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.answer
    ADD CONSTRAINT answer_question_id_fkey FOREIGN KEY (question_id) REFERENCES tester.question(question_id) ON DELETE CASCADE;


--
-- TOC entry 4703 (class 2606 OID 17916)
-- Name: answer answer_student_id_fkey; Type: FK CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.answer
    ADD CONSTRAINT answer_student_id_fkey FOREIGN KEY (student_id) REFERENCES tester.student(student_id) ON DELETE CASCADE;


--
-- TOC entry 4701 (class 2606 OID 17905)
-- Name: answervariant answervariant_question_id_fkey; Type: FK CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.answervariant
    ADD CONSTRAINT answervariant_question_id_fkey FOREIGN KEY (question_id) REFERENCES tester.question(question_id) ON DELETE CASCADE;


--
-- TOC entry 4698 (class 2606 OID 17877)
-- Name: grouptest grouptest_group_id_fkey; Type: FK CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.grouptest
    ADD CONSTRAINT grouptest_group_id_fkey FOREIGN KEY (group_id) REFERENCES tester.studygroup(group_id) ON DELETE CASCADE;


--
-- TOC entry 4699 (class 2606 OID 17882)
-- Name: grouptest grouptest_test_id_fkey; Type: FK CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.grouptest
    ADD CONSTRAINT grouptest_test_id_fkey FOREIGN KEY (test_id) REFERENCES tester.test(test_id) ON DELETE CASCADE;


--
-- TOC entry 4700 (class 2606 OID 17894)
-- Name: question question_test_id_fkey; Type: FK CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.question
    ADD CONSTRAINT question_test_id_fkey FOREIGN KEY (test_id) REFERENCES tester.test(test_id) ON DELETE CASCADE;


--
-- TOC entry 4696 (class 2606 OID 17853)
-- Name: student student_group_id_fkey; Type: FK CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.student
    ADD CONSTRAINT student_group_id_fkey FOREIGN KEY (group_id) REFERENCES tester.studygroup(group_id) ON DELETE CASCADE;


--
-- TOC entry 4697 (class 2606 OID 17866)
-- Name: test test_teacher_id_fkey; Type: FK CONSTRAINT; Schema: tester; Owner: postgres
--

ALTER TABLE ONLY tester.test
    ADD CONSTRAINT test_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES tester.teacher(teacher_id) ON DELETE CASCADE;


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 231
-- Name: FUNCTION getclosedtestsforstudent(student integer); Type: ACL; Schema: tester; Owner: postgres
--

GRANT ALL ON FUNCTION tester.getclosedtestsforstudent(student integer) TO reader;


--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 232
-- Name: FUNCTION getdonetestsforstudent(student integer); Type: ACL; Schema: tester; Owner: postgres
--

GRANT ALL ON FUNCTION tester.getdonetestsforstudent(student integer) TO reader;


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 233
-- Name: FUNCTION getopentestsforstudent(student integer); Type: ACL; Schema: tester; Owner: postgres
--

GRANT ALL ON FUNCTION tester.getopentestsforstudent(student integer) TO reader;


--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 234
-- Name: FUNCTION setanswers(student integer, answers jsonb); Type: ACL; Schema: tester; Owner: postgres
--

GRANT ALL ON FUNCTION tester.setanswers(student integer, answers jsonb) TO reader;


--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE answer; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT ON TABLE tester.answer TO reader;
GRANT SELECT,INSERT ON TABLE tester.answer TO student;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tester.answer TO admin;


--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 229
-- Name: SEQUENCE answer_answer_id_seq; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester.answer_answer_id_seq TO reader;


--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE answervariant; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT ON TABLE tester.answervariant TO reader;
GRANT SELECT,INSERT ON TABLE tester.answervariant TO teacher;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tester.answervariant TO admin;


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 227
-- Name: SEQUENCE answervariant_answervariant_id_seq; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester.answervariant_answervariant_id_seq TO reader;


--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE grouptest; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT ON TABLE tester.grouptest TO reader;
GRANT SELECT,INSERT ON TABLE tester.grouptest TO teacher;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tester.grouptest TO admin;


--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 223
-- Name: SEQUENCE grouptest_group_test_id_seq; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester.grouptest_group_test_id_seq TO reader;


--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE question; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT ON TABLE tester.question TO reader;
GRANT SELECT ON TABLE tester.question TO student;
GRANT SELECT,INSERT ON TABLE tester.question TO teacher;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tester.question TO admin;


--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 225
-- Name: SEQUENCE question_question_id_seq; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester.question_question_id_seq TO reader;


--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE student; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT ON TABLE tester.student TO reader;


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 219
-- Name: SEQUENCE student_student_id_seq; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester.student_student_id_seq TO reader;


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE studygroup; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT ON TABLE tester.studygroup TO reader;


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 217
-- Name: SEQUENCE studygroup_group_id_seq; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester.studygroup_group_id_seq TO reader;


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE teacher; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT ON TABLE tester.teacher TO reader;


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 215
-- Name: SEQUENCE teacher_teacher_id_seq; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester.teacher_teacher_id_seq TO reader;


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE test; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT ON TABLE tester.test TO reader;
GRANT SELECT ON TABLE tester.test TO student;
GRANT SELECT,INSERT ON TABLE tester.test TO teacher;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tester.test TO admin;


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 221
-- Name: SEQUENCE test_test_id_seq; Type: ACL; Schema: tester; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester.test_test_id_seq TO reader;


-- Completed on 2024-07-01 16:06:42

--
-- PostgreSQL database dump complete
--

--
-- Database "testerUsers" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16rc1
-- Dumped by pg_dump version 16rc1

-- Started on 2024-07-01 16:06:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4798 (class 1262 OID 18536)
-- Name: testerUsers; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "testerUsers" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "testerUsers" OWNER TO postgres;

\connect "testerUsers"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 18537)
-- Name: tester_users; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tester_users;


ALTER SCHEMA tester_users OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 18538)
-- Name: roles; Type: TABLE; Schema: tester_users; Owner: postgres
--

CREATE TABLE tester_users.roles (
    role_id integer NOT NULL,
    role_name character varying(40) NOT NULL,
    role_sys_name character varying(40) NOT NULL
);


ALTER TABLE tester_users.roles OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18541)
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: tester_users; Owner: postgres
--

ALTER TABLE tester_users.roles ALTER COLUMN role_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester_users.roles_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 18542)
-- Name: users; Type: TABLE; Schema: tester_users; Owner: postgres
--

CREATE TABLE tester_users.users (
    user_id integer NOT NULL,
    user_login character varying(40) NOT NULL,
    user_password character varying(500) NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE tester_users.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18547)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: tester_users; Owner: postgres
--

ALTER TABLE tester_users.users ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME tester_users.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4789 (class 0 OID 18538)
-- Dependencies: 216
-- Data for Name: roles; Type: TABLE DATA; Schema: tester_users; Owner: postgres
--

COPY tester_users.roles (role_id, role_name, role_sys_name) FROM stdin;
1	Администратор	admin
3	Студент	student
2	Преподаватель	teacher
\.


--
-- TOC entry 4791 (class 0 OID 18542)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: tester_users; Owner: postgres
--

COPY tester_users.users (user_id, user_login, user_password, role_id) FROM stdin;
10	tests	e3JFJd9SxdnOlsja$ca27d9df113faca10529940f08bd3cb58ca82585c6c80864972f84a460d7d8e8	3
3	stolbovMEs	kzgpjFefR5TUyRT6$7bf33c8b4e2a6e7431b70a8442285c4bf53bc7d0ac09c92ac45cfa94d1f42f51	3
4	petrovVAt	jYKePvTnYB1WNhr2$4e627afef18fcc0ecf0c45e7375bfa71bc5e63dd4d308b63d7ccc4ade2ba007b	2
5	balashovaNNt	SRflNg2s0KGMiEP5$d06ede7013af3c102fd8944bd0b0056fe25ea2998021d0579151c1f985becffb	2
6	zhukovAMs	JnTmKgqLzOCiZMb6$57a607914f43e80d4094fe2e465e2939f1edf5ede4f14d4aad11d5c5f264725b	3
7	timofeevaAKs	T34zWEUrZzNd4gfs$887255a50ac12fc1a287adc1ca8f02920548591d14e2846e766ec7427495e2e9	3
8	egorovaAMs	spO8l4nnSWFDsc7z$90360a6d1ec2cfee4ac723d99ad187555b69892d507d3b41cf2eebd3c5c12733	3
9	solovievAYs	BhwxjF1tAkJ9PUKO$80e6d2276636b9ee4fcd0efa3ca84a93d1f6742d1b400687b45ecd858f796b94	3
2	teacht	M3Y2qTK4tNM54voE$932d2bff086b0c2c6f8af1d1a90957d08b02d41d556809248180406eefcedded	2
1	admina	YOs9twotVMMhd6DT$2171294505f5fe11354f6cf590126f4108eeb56aab1402f03a935adab05b18c9	1
\.


--
-- TOC entry 4803 (class 0 OID 0)
-- Dependencies: 217
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: tester_users; Owner: postgres
--

SELECT pg_catalog.setval('tester_users.roles_role_id_seq', 3, true);


--
-- TOC entry 4804 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: tester_users; Owner: postgres
--

SELECT pg_catalog.setval('tester_users.users_user_id_seq', 10, true);


--
-- TOC entry 4642 (class 2606 OID 18549)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: tester_users; Owner: postgres
--

ALTER TABLE ONLY tester_users.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- TOC entry 4644 (class 2606 OID 18551)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: tester_users; Owner: postgres
--

ALTER TABLE ONLY tester_users.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4645 (class 2606 OID 18552)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: tester_users; Owner: postgres
--

ALTER TABLE ONLY tester_users.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES tester_users.roles(role_id);


--
-- TOC entry 4799 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE roles; Type: ACL; Schema: tester_users; Owner: postgres
--

GRANT SELECT,UPDATE ON TABLE tester_users.roles TO reader;


--
-- TOC entry 4800 (class 0 OID 0)
-- Dependencies: 217
-- Name: SEQUENCE roles_role_id_seq; Type: ACL; Schema: tester_users; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester_users.roles_role_id_seq TO reader;


--
-- TOC entry 4801 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE users; Type: ACL; Schema: tester_users; Owner: postgres
--

GRANT SELECT,UPDATE ON TABLE tester_users.users TO reader;


--
-- TOC entry 4802 (class 0 OID 0)
-- Dependencies: 219
-- Name: SEQUENCE users_user_id_seq; Type: ACL; Schema: tester_users; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tester_users.users_user_id_seq TO reader;


--
-- TOC entry 2044 (class 826 OID 18557)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: tester_users; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA tester_users GRANT SELECT ON TABLES TO reader;


-- Completed on 2024-07-01 16:06:42

--
-- PostgreSQL database dump complete
--

-- Completed on 2024-07-01 16:06:42

--
-- PostgreSQL database cluster dump complete
--

