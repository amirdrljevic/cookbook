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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    category_name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingredients (
    id bigint NOT NULL,
    recipe_id bigint NOT NULL,
    ingredient_name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    searchable tsvector GENERATED ALWAYS AS (setweight(to_tsvector('english'::regconfig, (COALESCE(ingredient_name, ''::character varying))::text), 'A'::"char")) STORED
);


--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ingredients_id_seq OWNED BY public.ingredients.id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipes (
    id bigint NOT NULL,
    title character varying,
    author character varying,
    cook_time integer,
    prep_time integer,
    ratings double precision,
    image character varying,
    category_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: ingredients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN id SET DEFAULT nextval('public.ingredients_id_seq'::regclass);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_categories_on_category_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_categories_on_category_name ON public.categories USING btree (category_name);


--
-- Name: index_ingredients_on_ingredient_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ingredients_on_ingredient_name ON public.ingredients USING btree (ingredient_name);


--
-- Name: index_ingredients_on_recipe_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ingredients_on_recipe_id ON public.ingredients USING btree (recipe_id);


--
-- Name: index_ingredients_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ingredients_on_searchable ON public.ingredients USING gin (searchable);


--
-- Name: index_recipes_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_category_id ON public.recipes USING btree (category_id);


--
-- Name: recipes fk_rails_22f4e84158; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT fk_rails_22f4e84158 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: ingredients fk_rails_3ee351e1cd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT fk_rails_3ee351e1cd FOREIGN KEY (recipe_id) REFERENCES public.recipes(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20220303203733'),
('20220303204419'),
('20220303204927'),
('20220303210022'),
('20220303210238'),
('20220405105517'),
('20220405110052');


