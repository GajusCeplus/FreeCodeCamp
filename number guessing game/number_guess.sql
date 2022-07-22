--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    moves integer NOT NULL,
    username_id integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: usernames; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.usernames (
    username_id integer NOT NULL,
    username character varying(50) NOT NULL
);


ALTER TABLE public.usernames OWNER TO freecodecamp;

--
-- Name: usernames_username_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.usernames_username_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usernames_username_id_seq OWNER TO freecodecamp;

--
-- Name: usernames_username_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.usernames_username_id_seq OWNED BY public.usernames.username_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: usernames username_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames ALTER COLUMN username_id SET DEFAULT nextval('public.usernames_username_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (6, 10, 9);
INSERT INTO public.games VALUES (7, 7, 9);
INSERT INTO public.games VALUES (8, 10, 9);
INSERT INTO public.games VALUES (9, 10, 10);
INSERT INTO public.games VALUES (10, 5, 10);
INSERT INTO public.games VALUES (11, 7, 9);
INSERT INTO public.games VALUES (12, 12, 9);
INSERT INTO public.games VALUES (13, 383, 26);
INSERT INTO public.games VALUES (14, 986, 26);
INSERT INTO public.games VALUES (15, 609, 27);
INSERT INTO public.games VALUES (16, 231, 27);
INSERT INTO public.games VALUES (17, 159, 26);
INSERT INTO public.games VALUES (18, 908, 26);
INSERT INTO public.games VALUES (19, 413, 26);
INSERT INTO public.games VALUES (20, 868, 28);
INSERT INTO public.games VALUES (21, 725, 28);
INSERT INTO public.games VALUES (22, 324, 29);
INSERT INTO public.games VALUES (23, 588, 29);
INSERT INTO public.games VALUES (24, 710, 28);
INSERT INTO public.games VALUES (25, 207, 28);
INSERT INTO public.games VALUES (26, 846, 28);
INSERT INTO public.games VALUES (27, 539, 30);
INSERT INTO public.games VALUES (28, 747, 30);
INSERT INTO public.games VALUES (29, 34, 31);
INSERT INTO public.games VALUES (30, 637, 31);
INSERT INTO public.games VALUES (31, 176, 30);
INSERT INTO public.games VALUES (32, 406, 30);
INSERT INTO public.games VALUES (33, 870, 30);


--
-- Data for Name: usernames; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.usernames VALUES (9, 'TESTTESTTESTTESTTESTTEST');
INSERT INTO public.usernames VALUES (10, 'user_Michal_Pawlak_2022');
INSERT INTO public.usernames VALUES (26, 'user_1658513547936');
INSERT INTO public.usernames VALUES (27, 'user_1658513547935');
INSERT INTO public.usernames VALUES (28, 'user_1658513976896');
INSERT INTO public.usernames VALUES (29, 'user_1658513976895');
INSERT INTO public.usernames VALUES (30, 'user_1658513986539');
INSERT INTO public.usernames VALUES (31, 'user_1658513986538');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 33, true);


--
-- Name: usernames_username_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.usernames_username_id_seq', 31, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: usernames usernames_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames
    ADD CONSTRAINT usernames_pkey PRIMARY KEY (username_id);


--
-- Name: usernames usernames_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames
    ADD CONSTRAINT usernames_username_key UNIQUE (username);


--
-- Name: games games_username_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_username_id_fkey FOREIGN KEY (username_id) REFERENCES public.usernames(username_id);


--
-- PostgreSQL database dump complete
--

