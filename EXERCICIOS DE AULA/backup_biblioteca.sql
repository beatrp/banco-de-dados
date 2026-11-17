--
-- PostgreSQL database dump
--

\restrict lTGjTcWPOcvopinr43gftTkzbYmD7urREzdSrltleJ2eP14Hw3OIxMiK4V7pcP1

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-11-17 08:32:58

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 234 (class 1259 OID 16600)
-- Name: associado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associado (
    codigo integer NOT NULL,
    nome character varying(100) NOT NULL,
    endereco character varying(100) NOT NULL,
    telefone character varying(15) NOT NULL,
    email character varying(100) NOT NULL
);


ALTER TABLE public.associado OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16599)
-- Name: associado_codigo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.associado_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.associado_codigo_seq OWNER TO postgres;

--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 233
-- Name: associado_codigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.associado_codigo_seq OWNED BY public.associado.codigo;


--
-- TOC entry 222 (class 1259 OID 16543)
-- Name: autor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autor (
    id integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.autor OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16542)
-- Name: autor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.autor_id_seq OWNER TO postgres;

--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 221
-- Name: autor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autor_id_seq OWNED BY public.autor.id;


--
-- TOC entry 240 (class 1259 OID 16676)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id integer NOT NULL,
    descricao character varying(150) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16675)
-- Name: categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_id_seq OWNER TO postgres;

--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 239
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_seq OWNED BY public.categoria.id;


--
-- TOC entry 220 (class 1259 OID 16534)
-- Name: editora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.editora (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100),
    telefone character varying(20)
);


ALTER TABLE public.editora OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16533)
-- Name: editora_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.editora_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.editora_id_seq OWNER TO postgres;

--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 219
-- Name: editora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.editora_id_seq OWNED BY public.editora.id;


--
-- TOC entry 236 (class 1259 OID 16612)
-- Name: emprestimo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emprestimo (
    id integer NOT NULL,
    data_emprestimo date CONSTRAINT emprestimo_data_not_null NOT NULL,
    id_associado integer NOT NULL,
    id_funcionario integer NOT NULL,
    data_devolucao date
);


ALTER TABLE public.emprestimo OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16611)
-- Name: emprestimo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emprestimo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.emprestimo_id_seq OWNER TO postgres;

--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 235
-- Name: emprestimo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emprestimo_id_seq OWNED BY public.emprestimo.id;


--
-- TOC entry 230 (class 1259 OID 16580)
-- Name: exemplar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exemplar (
    numero integer NOT NULL,
    id_livro integer,
    data_aquisicao date,
    status character varying(20)
);


ALTER TABLE public.exemplar OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16579)
-- Name: exemplar_numero_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exemplar_numero_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exemplar_numero_seq OWNER TO postgres;

--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 229
-- Name: exemplar_numero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exemplar_numero_seq OWNED BY public.exemplar.numero;


--
-- TOC entry 238 (class 1259 OID 16623)
-- Name: exemplares_emprestimo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exemplares_emprestimo (
    id integer NOT NULL,
    num_exemplar integer,
    num_emprest integer
);


ALTER TABLE public.exemplares_emprestimo OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16622)
-- Name: exemplares_emprestimo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exemplares_emprestimo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exemplares_emprestimo_id_seq OWNER TO postgres;

--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 237
-- Name: exemplares_emprestimo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exemplares_emprestimo_id_seq OWNED BY public.exemplares_emprestimo.id;


--
-- TOC entry 232 (class 1259 OID 16588)
-- Name: funcionario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funcionario (
    matricula integer NOT NULL,
    nome character varying(100) NOT NULL,
    endereco character varying(100) NOT NULL,
    cpf character varying(14) NOT NULL,
    telefone character varying(15) NOT NULL
);


ALTER TABLE public.funcionario OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16587)
-- Name: funcionario_matricula_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.funcionario_matricula_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.funcionario_matricula_seq OWNER TO postgres;

--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 231
-- Name: funcionario_matricula_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.funcionario_matricula_seq OWNED BY public.funcionario.matricula;


--
-- TOC entry 224 (class 1259 OID 16552)
-- Name: livros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.livros (
    id integer NOT NULL,
    titulo character varying(100) NOT NULL,
    isbn character varying(20) NOT NULL,
    local_edicao character varying(20) NOT NULL,
    id_editora integer,
    ano_publicacao integer,
    numero_paginas integer,
    id_categoria integer
);


ALTER TABLE public.livros OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16563)
-- Name: livros_autor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.livros_autor (
    cod integer NOT NULL,
    id_livro integer,
    id_autor integer
);


ALTER TABLE public.livros_autor OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16562)
-- Name: livros_autor_cod_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.livros_autor_cod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.livros_autor_cod_seq OWNER TO postgres;

--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 225
-- Name: livros_autor_cod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livros_autor_cod_seq OWNED BY public.livros_autor.cod;


--
-- TOC entry 223 (class 1259 OID 16551)
-- Name: livros_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.livros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.livros_id_seq OWNER TO postgres;

--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 223
-- Name: livros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livros_id_seq OWNED BY public.livros.id;


--
-- TOC entry 228 (class 1259 OID 16571)
-- Name: palavras_chave; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.palavras_chave (
    id integer NOT NULL,
    palavra character varying(30) NOT NULL,
    id_livro integer
);


ALTER TABLE public.palavras_chave OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16570)
-- Name: palavras_chave_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.palavras_chave_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.palavras_chave_id_seq OWNER TO postgres;

--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 227
-- Name: palavras_chave_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.palavras_chave_id_seq OWNED BY public.palavras_chave.id;


--
-- TOC entry 242 (class 1259 OID 16694)
-- Name: v_emprestimo_detalhes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_emprestimo_detalhes AS
 SELECT emp.id,
    emp.data_emprestimo,
    emp.id_associado,
    emp.id_funcionario,
    emp.data_devolucao,
    a.nome AS nome_associado,
    f.nome AS nome_funcionario
   FROM ((public.emprestimo emp
     JOIN public.associado a ON ((emp.id_associado = a.codigo)))
     JOIN public.funcionario f ON ((emp.id_funcionario = f.matricula)));


ALTER VIEW public.v_emprestimo_detalhes OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16689)
-- Name: v_relatorio_emprestimos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_relatorio_emprestimos AS
 SELECT emp.id AS numero_emprestimo,
    emp.data_emprestimo,
    a.nome AS nome_associado,
    f.nome AS nome_funcionario,
    ex.numero AS numero_exemplar,
    l.titulo AS titulo_livro
   FROM (((((public.emprestimo emp
     JOIN public.associado a ON ((emp.id_associado = a.codigo)))
     JOIN public.funcionario f ON ((emp.id_funcionario = f.matricula)))
     JOIN public.exemplares_emprestimo ee ON ((emp.id = ee.num_emprest)))
     JOIN public.exemplar ex ON ((ee.num_exemplar = ex.numero)))
     JOIN public.livros l ON ((ex.id_livro = l.id)));


ALTER VIEW public.v_relatorio_emprestimos OWNER TO postgres;

--
-- TOC entry 4820 (class 2604 OID 16603)
-- Name: associado codigo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associado ALTER COLUMN codigo SET DEFAULT nextval('public.associado_codigo_seq'::regclass);


--
-- TOC entry 4814 (class 2604 OID 16546)
-- Name: autor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autor ALTER COLUMN id SET DEFAULT nextval('public.autor_id_seq'::regclass);


--
-- TOC entry 4823 (class 2604 OID 16679)
-- Name: categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id SET DEFAULT nextval('public.categoria_id_seq'::regclass);


--
-- TOC entry 4813 (class 2604 OID 16537)
-- Name: editora id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editora ALTER COLUMN id SET DEFAULT nextval('public.editora_id_seq'::regclass);


--
-- TOC entry 4821 (class 2604 OID 16615)
-- Name: emprestimo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprestimo ALTER COLUMN id SET DEFAULT nextval('public.emprestimo_id_seq'::regclass);


--
-- TOC entry 4818 (class 2604 OID 16583)
-- Name: exemplar numero; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplar ALTER COLUMN numero SET DEFAULT nextval('public.exemplar_numero_seq'::regclass);


--
-- TOC entry 4822 (class 2604 OID 16626)
-- Name: exemplares_emprestimo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplares_emprestimo ALTER COLUMN id SET DEFAULT nextval('public.exemplares_emprestimo_id_seq'::regclass);


--
-- TOC entry 4819 (class 2604 OID 16591)
-- Name: funcionario matricula; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionario ALTER COLUMN matricula SET DEFAULT nextval('public.funcionario_matricula_seq'::regclass);


--
-- TOC entry 4815 (class 2604 OID 16555)
-- Name: livros id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livros ALTER COLUMN id SET DEFAULT nextval('public.livros_id_seq'::regclass);


--
-- TOC entry 4816 (class 2604 OID 16566)
-- Name: livros_autor cod; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livros_autor ALTER COLUMN cod SET DEFAULT nextval('public.livros_autor_cod_seq'::regclass);


--
-- TOC entry 4817 (class 2604 OID 16574)
-- Name: palavras_chave id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.palavras_chave ALTER COLUMN id SET DEFAULT nextval('public.palavras_chave_id_seq'::regclass);


--
-- TOC entry 5020 (class 0 OID 16600)
-- Dependencies: 234
-- Data for Name: associado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associado (codigo, nome, endereco, telefone, email) FROM stdin;
1	José da Silva	Rua XV de\nnovembro – 1234	(15)3453-4545	silva01@gmail.com
2	Maria Cristina da Silva	Rua\nXV de novembro – 154	(15)3453-4045	mariasilva01@gmail.com
3	André da Silva Cruz	Rua V\nde novembro – 1234	(15)3466-4545	andresilva01@hotmail.com
4	Kely Maria Braga	Rua\nprimo moras – 34	(15)3453-4545	kelym01@gmail.com
5	José da Silva Moraes	Rua\nXV de novembro – 700	(19)3453-4545	josesilva01@gmail.com
6	Bruna Mendes	Rua Azul,\n111	(11)91111-1111	bruna@gmail.com
7	Thiago Silva	Rua\nAmarela, 222	(11)92222-2222	thiago@gmail.com
8	Isabela Martins	Rua\nVerde, 333	(11)93333-3333	isabela@gmail.com
9	Lucas Pereira	Rua Cinza,\n444	(11)94444-4444	lucas@gmail.com
10	Renata Souza	Rua\nVermelha, 555	(11)95555-5555	renata@gmail.com
\.


--
-- TOC entry 5008 (class 0 OID 16543)
-- Dependencies: 222
-- Data for Name: autor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autor (id, nome) FROM stdin;
1	João da Silva Nunes
2	José Silberchatz
3	Maria Fernanda Dias
4	Elias Nielsen
5	Simone Barbosa
6	José Antonio Soares
7	Eliana Martins
8	Maria Fernanda Ascencio
9	Matheus Solano Cruz
10	André Santana
11	Aline Rodrigues
12	Carlos Drummond de Andrade
13	Clarice Lispector
14	Paulo Coelho
15	Cecília Meireles
16	Machado de Assis
\.


--
-- TOC entry 5026 (class 0 OID 16676)
-- Dependencies: 240
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (id, descricao) FROM stdin;
1	Tecnologia
2	Literatura
3	Administração
4	Ciências Exatas
5	História
\.


--
-- TOC entry 5006 (class 0 OID 16534)
-- Dependencies: 220
-- Data for Name: editora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.editora (id, nome, email, telefone) FROM stdin;
2	Pearson	\N	\N
3	Atlas	\N	\N
4	Cruzeiro do Sul	\N	\N
5	Cultura	\N	\N
6	Globo	\N	\N
7	Rocco	\N	\N
8	Saraiva	\N	\N
9	Moderna	\N	\N
10	Leya	\N	\N
11	Companhia das Letras	\N	\N
12	Record	\N	\N
13	FTD	\N	\N
14	Scipione	\N	\N
1	Érica	contato@atlas.com	1199999999
\.


--
-- TOC entry 5022 (class 0 OID 16612)
-- Dependencies: 236
-- Data for Name: emprestimo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emprestimo (id, data_emprestimo, id_associado, id_funcionario, data_devolucao) FROM stdin;
2	2021-08-11	1	1	\N
3	2021-08-12	2	2	\N
4	2021-08-13	1	2	\N
5	2021-08-20	1	2	\N
6	2021-08-22	1	2	\N
7	2021-08-22	3	2	\N
8	2021-08-24	3	2	\N
9	2021-08-30	4	2	\N
10	2021-08-25	2	1	\N
11	2021-09-01	1	2	\N
12	2021-09-01	3	2	\N
13	2021-09-05	4	2	\N
14	2021-09-06	5	2	\N
15	2021-09-05	2	2	\N
16	2022-09-05	2	3	\N
17	2023-07-05	1	4	\N
18	2023-06-10	3	4	\N
19	2023-08-01	6	5	\N
20	2023-08-03	7	6	\N
21	2023-08-05	8	7	\N
22	2023-08-10	9	8	\N
23	2023-08-15	10	9	\N
24	2023-08-20	6	6	\N
25	2023-08-25	7	7	\N
26	2023-08-28	8	8	\N
27	2023-09-01	9	9	\N
28	2023-09-03	10	5	\N
1	2021-08-10	1	2	2023-11-20
\.


--
-- TOC entry 5016 (class 0 OID 16580)
-- Dependencies: 230
-- Data for Name: exemplar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exemplar (numero, id_livro, data_aquisicao, status) FROM stdin;
2	1	\N	\N
3	1	\N	\N
4	1	\N	\N
5	2	\N	\N
6	2	\N	\N
7	3	\N	\N
8	3	\N	\N
9	3	\N	\N
10	3	\N	\N
11	3	\N	\N
12	4	\N	\N
13	4	\N	\N
14	4	\N	\N
15	5	\N	\N
16	5	\N	\N
17	5	\N	\N
18	5	\N	\N
19	5	\N	\N
20	5	\N	\N
21	6	\N	\N
22	6	\N	\N
23	6	\N	\N
24	6	\N	\N
25	7	\N	\N
26	7	\N	\N
27	8	\N	\N
28	9	\N	\N
29	9	\N	\N
30	10	\N	\N
31	11	\N	\N
32	11	\N	\N
33	11	\N	\N
34	12	\N	\N
35	13	\N	\N
36	14	\N	\N
37	15	\N	\N
38	16	\N	\N
1	1	2023-01-15	disponível
\.


--
-- TOC entry 5024 (class 0 OID 16623)
-- Dependencies: 238
-- Data for Name: exemplares_emprestimo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exemplares_emprestimo (id, num_exemplar, num_emprest) FROM stdin;
1	1	2
2	2	2
3	1	1
4	1	3
5	4	3
6	4	5
7	5	1
8	5	5
9	6	1
10	2	1
11	7	2
12	8	4
13	9	4
14	10	5
15	10	5
16	11	4
17	11	3
18	12	5
19	12	2
20	34	18
21	35	19
22	36	20
23	37	21
24	38	22
25	5	23
26	6	20
27	8	15
28	12	16
29	14	20
\.


--
-- TOC entry 5018 (class 0 OID 16588)
-- Dependencies: 232
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funcionario (matricula, nome, endereco, cpf, telefone) FROM stdin;
1	Andreia	Rua 14 novembro\n– 300	14689836801	(15)99720-3434
2	Kelly Maria	Avenida\nSoares Hungria	13889836801	(15)99820-3413
3	Aline Cristina	Avenida\nBrasil – 330	13689836801	(15)99833-3413
4	Mateus Andrada	Rua 7 de\nsetembro – 20	13689836801	(19)99833-3555
5	Bruno Castro	Rua das\nFlores, 111	15588812234	(11)91234-5678
6	Fernanda Lima	Av.\nPaulista, 2020	15588812235	(11)92345-6789
7	Luciano Gomes	Rua\nCentral, 45	15588812236	(11)93456-7890
8	Amanda Rocha	Rua das\nLaranjeiras, 77	15588812237	(11)94567-8901
9	Ricardo Ramos	Av. Brasil,\n80	15588812238	(11)95678-9012
\.


--
-- TOC entry 5010 (class 0 OID 16552)
-- Dependencies: 224
-- Data for Name: livros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livros (id, titulo, isbn, local_edicao, id_editora, ano_publicacao, numero_paginas, id_categoria) FROM stdin;
2	Introdução a Programação\nJava	’KDFG009444	São Paulo	3	\N	\N	\N
3	Introdução a\nLógica	MADF878441	Rio de Janeiro	2	\N	\N	\N
4	Introdução a Banco de\nDados	PUQASC00326	São Paulo	2	\N	\N	\N
5	Banco de Dados\nNoSQL	ASC007442	São Paulo	4	\N	\N	\N
6	Banco de Dados\nPostgreSQL	LASC007442	Rio de Janeiro	1	\N	\N	\N
7	Front End -\nCSS	XVDC007442	São Paulo	4	\N	\N	\N
8	Front End – CSSavançado	FFSS009981	Rio de Janeiro	5	\N	\N	\N
9	NoSQL –\nIntrodução	FSBSS009981	São Paulo	6	\N	\N	\N
10	NoSQL –\nMongoDB	MGBSS009952	São Paulo	7	\N	\N	\N
11	NoSQL –\nCassandra	CABD0019952	Curitiba	8	\N	\N	\N
12	Dom Casmurro	DC000199	Rio de Janeiro	13	\N	\N	\N
13	Veronika Decide Morrer	VDM200299	São Paulo	14	\N	\N	\N
14	A Hora da Estrela	AHE300399	Recife	12	\N	\N	\N
15	O Pequeno Príncipe	OPP400499	Curitiba	2	\N	\N	\N
16	Capitães da Areia	CDA500599	Salvador	11	\N	\N	\N
1	Introdução a Linguagem de\nProgramação	ASC009444	São Paulo	2	2021	350	\N
\.


--
-- TOC entry 5012 (class 0 OID 16563)
-- Dependencies: 226
-- Data for Name: livros_autor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livros_autor (cod, id_livro, id_autor) FROM stdin;
1	1	2
2	1	3
3	1	4
4	2	5
5	2	1
6	3	2
7	3	4
8	4	1
9	5	3
10	5	4
11	6	1
12	6	5
13	6	7
14	7	1
15	7	2
16	8	6
17	6	8
18	6	9
19	7	5
20	7	8
21	8	2
22	8	5
23	8	7
24	9	1
25	9	5
26	10	6
27	10	7
28	10	9
29	12	15
30	13	12
31	14	12
32	15	13
33	16	14
\.


--
-- TOC entry 5014 (class 0 OID 16571)
-- Dependencies: 228
-- Data for Name: palavras_chave; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.palavras_chave (id, palavra, id_livro) FROM stdin;
1	Lógica	1
2	programação	1
3	Lógica	1
4	Lógica	1
5	SQL	4
6	SQL	5
7	SQL	6
8	Literatura	12
9	Romance	13
10	Drama	14
11	Infantil	15
12	Juvenil	16
\.


--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 233
-- Name: associado_codigo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.associado_codigo_seq', 10, true);


--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 221
-- Name: autor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autor_id_seq', 16, true);


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 239
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_seq', 5, true);


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 219
-- Name: editora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.editora_id_seq', 14, true);


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 235
-- Name: emprestimo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emprestimo_id_seq', 28, true);


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 229
-- Name: exemplar_numero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exemplar_numero_seq', 38, true);


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 237
-- Name: exemplares_emprestimo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exemplares_emprestimo_id_seq', 29, true);


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 231
-- Name: funcionario_matricula_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.funcionario_matricula_seq', 9, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 225
-- Name: livros_autor_cod_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livros_autor_cod_seq', 33, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 223
-- Name: livros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livros_id_seq', 16, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 227
-- Name: palavras_chave_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.palavras_chave_id_seq', 12, true);


--
-- TOC entry 4839 (class 2606 OID 16610)
-- Name: associado associado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associado
    ADD CONSTRAINT associado_pkey PRIMARY KEY (codigo);


--
-- TOC entry 4827 (class 2606 OID 16550)
-- Name: autor autor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (id);


--
-- TOC entry 4845 (class 2606 OID 16683)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id);


--
-- TOC entry 4825 (class 2606 OID 16541)
-- Name: editora editora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editora
    ADD CONSTRAINT editora_pkey PRIMARY KEY (id);


--
-- TOC entry 4841 (class 2606 OID 16621)
-- Name: emprestimo emprestimo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprestimo
    ADD CONSTRAINT emprestimo_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 16586)
-- Name: exemplar exemplar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplar
    ADD CONSTRAINT exemplar_pkey PRIMARY KEY (numero);


--
-- TOC entry 4843 (class 2606 OID 16629)
-- Name: exemplares_emprestimo exemplares_emprestimo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplares_emprestimo
    ADD CONSTRAINT exemplares_emprestimo_pkey PRIMARY KEY (id);


--
-- TOC entry 4837 (class 2606 OID 16598)
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (matricula);


--
-- TOC entry 4831 (class 2606 OID 16569)
-- Name: livros_autor livros_autor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livros_autor
    ADD CONSTRAINT livros_autor_pkey PRIMARY KEY (cod);


--
-- TOC entry 4829 (class 2606 OID 16561)
-- Name: livros livros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livros
    ADD CONSTRAINT livros_pkey PRIMARY KEY (id);


--
-- TOC entry 4833 (class 2606 OID 16578)
-- Name: palavras_chave palavras_chave_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.palavras_chave
    ADD CONSTRAINT palavras_chave_pkey PRIMARY KEY (id);


--
-- TOC entry 4848 (class 2606 OID 16635)
-- Name: livros_autor autor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livros_autor
    ADD CONSTRAINT autor_fk FOREIGN KEY (id_autor) REFERENCES public.autor(id);


--
-- TOC entry 4852 (class 2606 OID 16660)
-- Name: emprestimo emprestimo_assoc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprestimo
    ADD CONSTRAINT emprestimo_assoc_fk FOREIGN KEY (id_associado) REFERENCES public.associado(codigo);


--
-- TOC entry 4853 (class 2606 OID 16655)
-- Name: emprestimo emprestimo_func_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emprestimo
    ADD CONSTRAINT emprestimo_func_fk FOREIGN KEY (id_funcionario) REFERENCES public.funcionario(matricula);


--
-- TOC entry 4851 (class 2606 OID 16650)
-- Name: exemplar exemplar_livro_livro_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplar
    ADD CONSTRAINT exemplar_livro_livro_fk FOREIGN KEY (id_livro) REFERENCES public.livros(id);


--
-- TOC entry 4854 (class 2606 OID 16670)
-- Name: exemplares_emprestimo exemplares_emprest_empr_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplares_emprestimo
    ADD CONSTRAINT exemplares_emprest_empr_fk FOREIGN KEY (num_emprest) REFERENCES public.emprestimo(id);


--
-- TOC entry 4855 (class 2606 OID 16665)
-- Name: exemplares_emprestimo exemplares_emprest_exem_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exemplares_emprestimo
    ADD CONSTRAINT exemplares_emprest_exem_fk FOREIGN KEY (num_exemplar) REFERENCES public.exemplar(numero);


--
-- TOC entry 4846 (class 2606 OID 16684)
-- Name: livros fk_livros_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livros
    ADD CONSTRAINT fk_livros_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id);


--
-- TOC entry 4849 (class 2606 OID 16640)
-- Name: livros_autor livro_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livros_autor
    ADD CONSTRAINT livro_fk FOREIGN KEY (id_livro) REFERENCES public.livros(id);


--
-- TOC entry 4847 (class 2606 OID 16630)
-- Name: livros livros_editora_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livros
    ADD CONSTRAINT livros_editora_fk FOREIGN KEY (id_editora) REFERENCES public.editora(id);


--
-- TOC entry 4850 (class 2606 OID 16645)
-- Name: palavras_chave palavras_chave_livro_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.palavras_chave
    ADD CONSTRAINT palavras_chave_livro_fk FOREIGN KEY (id_livro) REFERENCES public.livros(id);


-- Completed on 2026-11-17 08:32:58

--
-- PostgreSQL database dump complete
--

\unrestrict lTGjTcWPOcvopinr43gftTkzbYmD7urREzdSrltleJ2eP14Hw3OIxMiK4V7pcP1

