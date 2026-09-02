# Resumo de Aula: Modelo Conceitual e Modelagem de Banco de Dados

**Disciplina:** Modelos de Banco de Dados  
**Docente:** Profa. Dra. Andréia Rodrigues Casare  

---

## 1. Visão Geral e a Necessidade da Modelagem
Antes de criar tabelas diretamente em um Sistema Gerenciador de Banco de Dados (SGBD), é essencial planejar como os dados se relacionam no mundo real para evitar perda de informações e inconsistências.

---

## 2. O Processo de Modelagem de Dados
A modelagem é dividida em três fases principais:

| Fase | Nível de Abstração | Descrição / Características |
| :--- | :--- | :--- |
| **Modelo Conceitual** | Alto (Abstrato) | • Visão de negócio independe de tecnologia e SGBD.<br>• Responde o que armazenar e regras de negócio.<br>• Utiliza o **DER (Diagrama Entidade-Relacionamento)**. |
| **Modelo Lógico** | Médio | • Transforma entidades em tabelas e define atributos e chaves. |
| **Modelo Físico** | Baixo (Implementação) | • Implementado via SQL/SGBD com tipos de dados, índices e restrições. |

---

## 3. Vantagens do Modelo Conceitual
- **Independência tecnológica:** Não depende de detalhes de implementação do SGBD.
- **Semântica clara:** Facilita a compreensão do domínio dos dados.
- **Comunicação:** É facilmente compreendido por usuários leigos/clientes.
- **Flexibilidade:** Pode ser mapeado para qualquer modelo lógico posterior.

---

## 4. Conceitos Fundamentais do MER / DER
- **MER (Modelo Entidade-Relacionamento):** Conjunto de conceitos e elementos teóricos de modelagem.
- **DER (Diagrama Entidade-Relacionamento):** Representação gráfica concreta resultante do processo de modelagem.

### Representação Gráfica Clássica:
- **Entidade ($\mathbf{E}$):** Representada por **Retângulos**.
- **Relacionamento ($\mathbf{R}$):** Representado por **Losangos**.
- **Atributo ($\mathbf{A}$):** Representado por **Círculos/Elipses**.

---

## 5. Elementos do Modelo Conceitual

### 5.1 Entidades
Representam objetos ou conceitos do mundo real sobre os quais se deseja guardar dados.  
*Exemplos:* `CLIENTE`, `FUNCIONÁRIO`, `CONTA`, `PRODUTO`.

---

### 5.2 Atributos
Características que descrevem uma entidade. Classificam-se em:

1. **Simples:** Não pode ser dividido em partes menores (ex: `Nome`, `Data_Nascimento`).
2. **Composto:** Pode ser decomposto em subatributos (ex: `Endereço`, `Rua`, `Número`, `Bairro`, `CEP`).
3. **Multivalorado:** Pode ter múltiplos valores para a mesma entidade (ex: `Telefones`, `Emails`). *No modelo relacional, vira uma tabela separada.*
4. **Chave (Identificador):** Identifica unicamente cada registro/ocorrência. Não pode ser nulo nem repetido (ex: `CPF`, `Matrícula`, `Código`).
5. **Derivado:** Seu valor é calculado a partir de outros atributos (ex: `Idade` derivada da `Data_Nascimento`). Evita redundância de dados.

---

### 5.3 Relacionamentos e Cardinalidade
Associações entre entidades. A **cardinalidade** define a quantidade mínima e máxima de ocorrências associadas:

- **Cardinalidade Máxima ($1$ ou $N$):** Limite máximo de ocorrências associadas.
- **Cardinalidade Mínima ($0$ ou $1$):**
  - **$0$ (Zero):** Participação opcional.
  - **$1$ (Um):** Participação obrigatória.

#### Tipos Comuns de Cardinalidade (Máxima):
- **$1:1$ (Um para Um):** Ex.: `Cliente (1,1) — tem — (1,1) Endereço`
- **$1:N$ (Um para Muitos):** Ex.: `Funcionário (1,1) — possui — (0,N) Dependente`
- **$N:M$ / $N:N$ (Muitos para Muitos):** Ex.: `Cliente (0,N) — realiza — (1,N) Pedido`

---

## 6. Boas Práticas de Modelagem
1. Nomes claros e padronizados para entidades e atributos.
2. Identificação correta das regras de negócio do domínio.
3. Evitar redundância desnecessária de dados.
4. Definir cardinalidades (mínima e máxima) com precisão.
5. Validar o modelo conceitual com o cliente/usuário final.

---

## 7. Exercícios de Fixação (Enunciados do Material)

### Exercício 1: Clínica Médica
- **Entidades e Atributos:**
  - `MÉDICO`: CRM (Chave), Nome, Telefone, Email, Salário, Especialidade.
  - `ENFERMEIRO`: Matrícula (Chave), Nome, Endereço, Telefone, Celular, Email, Salário, Função.
  - `PACIENTE`: Nome, RG, CPF (Chave), Endereço, Telefone, Celular, Data_Nascimento.
- **Relacionamento:** `MÉDICO (1,N) — atende — (0,N) PACIENTE` (Atendimento por múltiplos médicos).

### Exercício 2: Loja de Produtos de Limpeza
- **Entidades e Atributos:**
  - `PRODUTO`: Código (Chave), Nome, Categoria, Qtd_Estoque, Preço.
  - `CLIENTE`: Código (Chave), Nome, Endereço, Telefone, Data_Nasc, Email, Status, Limite_Credito.
  - `PEDIDO`: Número (Chave), Data_Elaboracao, Forma_Pagamento.
- **Relacionamentos:** 
  - `CLIENTE (1,1) — realiza — (0,N) PEDIDO`
  - `PEDIDO (1,N) — envolve — (1,N) PRODUTO` (Atributo no relacionamento: `Quantidade`).

### Exercício 3: Transportadora Aérea
- **Entidades e Atributos:**
  - `AVIÃO`: Matrícula (Chave), Nome, Modelo, Num_Lugares, Autonomia.
  - `PILOTO`: Num_Licenca (Chave), Nome.
  - `DESCENDENTE`: Nome, Data_Nascimento.
  - `VÔO`: Data, Hora, Local_Partida, Local_Destino.
- **Relacionamentos:**
  - `PILOTO (0,N) — possui — (0,N) DESCENDENTE`
  - `PILOTO (1,N) — pode pilotar — (1,N) MODELO_AVIÃO`
  - `AVIÃO (1,1) — faz — (0,N) VÔO`
  - `PILOTO (1,1) — pilota — (0,N) VÔO`

### Exercício 4: Acervo de Biblioteca
- **Entidades e Atributos:**
  - `LIVRO`: ISBN (Chave), Título, Editora, Local_Edicao, Autores (Multivalorado), Palavras-Chave (Multivalorado).
  - `EXEMPLAR`: Num_Sequencial (Chave/Parcial).
  - `ASSOCIADO`: Código (Chave), Nome, Endereço, Telefone, Email.
  - `FUNCIONÁRIO`: Matrícula (Chave), Nome, CPF, Endereço, Telefone.
- **Relacionamento / Regras:**
  - `LIVRO (1,1) — possui — (1,N) EXEMPLAR`
  - Empréstimo entre `ASSOCIADO`, `EXEMPLAR` e `FUNCIONÁRIO` (Atributo: `Data_Emprestimo`, com limite máximo de 3 exemplares por associado).

---

## 8. Referências Bibliográficas
- **ELMASRI, R.; NAVATHE, S. B.** *Sistemas de Banco de Dados*. 7. ed. São Paulo: Pearson, 2019.
- **HEUSER, C. A.** *Projeto de Banco de Dados*. 6. ed. Porto Alegre: Bookman, 2009.
- **SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S.** *Sistema de Banco de Dados*. 7. ed. Rio de Janeiro: LTC, 2020.
