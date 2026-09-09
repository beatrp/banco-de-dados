# Resumo de Aula: Modelo Conceitual — Parte 2

**Disciplina:** Modelos de Banco de Dados  
**Docente:** Profa. Dra. Andréia Rodrigues Casare  

---

## 1. Tipos de Entidades: Fortes vs. Fracas

### 1.1 Entidade Forte
- Existe por si só e independentemente de outras entidades no domínio.
- Possui um atributo chave (identificador único) próprio.
- **Exemplos:** `Aluno`, `Curso`, `Professor`, `Disciplina`, `Cliente`, `Funcionário`.

### 1.2 Entidade Fraca
- Depende da existência de uma **entidade dominante (forte)** para existir ou ser identificada.
- Não possui chave primária completa por si só; sua identificação é feita pela junção da **Chave Primária da Entidade Forte + Atributo Discriminante (Chave Parcial)**.
- **Regra de Integridade:** Se a entidade forte (dominante) for removida, todas as suas entidades fracas associadas também devem ser removidas.
- **Exemplos:**
  - `Dependente` (depende de `Funcionário`).
  - `Item_Pedido` (depende de `Pedido`).
  - `Tamanho_Produto` (depende de `Produto`).

---

## 2. Especialização e Generalização (Herança)

Permitem estruturar hierarquias entre tipos de entidades (superclasses e subclasses) para compartilhar ou detalhar atributos e relacionamentos.

```
       [ Entidade Genérica / Superclasse ]
                     ▲   │
       Generaliza    │   │ Especializa
       (Abstrai)     │   ▼ (Detalha)
       [ Entidades Específicas / Subclasses ]
```

### 2.1 Especialização
- **Processo *Top-Down* (do geral para o específico):** Criação de subclasses a partir de uma entidade de nível superior (superclasse).
- **Motivação:** Quando determinados atributos ou relacionamentos aplicam-se apenas a um subgrupo específico de ocorrências.
- **Exemplo:** A entidade `Conta` (Número, Agência) pode ser especializada em:
  - `Conta Corrente`: atributos adicionais `Operações`, `Valor_Limite`.
  - `Conta Poupança`: atributos adicionais `Taxa_Juros`, `Variação`.

### 2.2 Generalização
- **Processo *Bottom-Up* (do específico para o geral):** Unificação de dois ou mais conjuntos de entidades afins em uma entidade genérica mais abstrata.
- **Exemplo:** Unir `Pessoa Física` e `Pessoa Jurídica` na entidade genérica `Cliente`.

### 2.3 Tipos de Restrição / Cobertura
1. **Total:** Toda ocorrência da entidade genérica pertence **obrigatoriamente** a pelo menos uma entidade especializada.
   - *Exemplo:* Todo `Cliente` tem que ser `Pessoa Física` OU `Pessoa Jurídica`.
2. **Parcial:** Existem ocorrências na entidade genérica que **não pertencem** a nenhuma das entidades especializadas.
   - *Exemplo:* Nem todo `Funcionário` precisa ser `Motorista` ou `Secretária`.
3. **Especialização Definida por Atributo:** A subclasse é determinada pelo valor de um atributo específico na superclasse (ex: atributo `Tipo_Empregado`).

---

## 3. Entidade Associativa

- **Definição:** Técnica de abstração utilizada quando é necessário **associar um relacionamento a outra entidade ou relacionamento**.
- **Limitação do DER:** No modelo E-R tradicional não é permitido ligar uma linha de relacionamento diretamente a outro relacionamento.
- **Solução:** O relacionamento é promovido / encapsulado com o status de **Entidade Associativa**, permitindo que ele possua seus próprios relacionamentos e atributos de forma organizada e flexível.

---

## 4. Autorrelacionamento (Relacionamento Recursivo)

- **Definição:** Ocorre quando instâncias de uma mesma entidade se relacionam entre si.
- **Aplicação:** Utilizado para representar **hierarquias**, **subordinações** ou **dependências internas**.
- **Exemplos Clássicos:**
  1. **Gerenciamento de Funcionários:** `Funcionário (1,1) — gerencia — (0,N) Funcionário` (Um funcionário é gerenciado por outro funcionário).
  2. **Hierarquia de Cargos:** `Cargo (1,1) — é subordinado — (1,N) Cargo` (Um cargo pode ser subordinado a um cargo superior).

---

## 5. Estudo de Casos e Exercícios de Fixação

### Exercício 1: Companhia e Departamentos
- **Regras de Negócio:**
  - `DEPARTAMENTO`: Possui Nome, Número. Controla múltiplos `PROJETO`s ($1:N$).
  - `PROJETO`: Possui Código, Nome, Período. Desenvolvido por apenas 1 Departamento.
  - `FUNCIONÁRIO`: Especialização (Pesquisador, Secretário, Limpeza). Pertence a 1 Departamento.
    - *Pesquisador:* Horas/projeto ($N:M$ com Projeto), Salário, Área de atuação.
    - *Secretário:* Grau de escolaridade.
    - *Limpeza:* Cargo, Jornada. Possui **Autorrelacionamento de Gerência** entre cargos de limpeza.
  - `DEPENDENTE`: **Entidade Fraca** associada a `Funcionário` para fins de ajuda de custo.

### Exercício 2: Sistema Universitário
- **Regras de Negócio:**
  - `DEPARTAMENTO`: Sigla, Nome, Chefe. Responsável por várias `DISCIPLINA`s.
  - `DISCIPLINA`: Código, Nome, Ementa, Bibliografia. Possui $0$ a $N$ `TURMA`s.
  - `TURMA`: Turno, ID. Toda turma pertence a uma disciplina e possui no mínimo 1 `ALUNO`.
  - `ALUNO`: RA, CPF, Nome, Contatos. Pode estar matriculado em várias turmas ($N:M$).
  - `FUNCIONÁRIO`: Especialização (Bibliotecário, Limpeza, Administrativo, Professor).

### Exercício 3: Academia de Ginástica
- **Regras de Negócio:**
  - `ALUNO`: Código, Nome, Matrícula, Dados Físicos (Peso, Altura). Pode estar em múltiplas `TURMA`s.
  - `TURMA`: Horário, Duração, Datas, Quantidade de alunos. Associada a um `TIPO_ATIVIDADE`.
  - `INSTRUTOR`: RG, Nome, Titulação, Telefones (Multivalorado). Orienta várias Turmas ($1:N$).
  - `MATRÍCULA / FREQUÊNCIA`: Atributo de controle de ausências do aluno na turma.

---

## 6. Referências Bibliográficas
- **DATE, C. J.** *Introdução a Sistemas de Bancos de Dados*. 7. ed. Rio de Janeiro: Campus, 2000.
- **SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S.** *Sistema de Banco de Dados*. 3. ed. São Paulo: Pearson Education do Brasil, 2004.
