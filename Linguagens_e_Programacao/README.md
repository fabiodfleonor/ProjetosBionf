# Projeto de Linguagens de Programação II — Gestão de Experiências Científicas

Este projeto foi desenvolvido no âmbito da unidade curricular **Linguagens de Programação II (2024/2025)** e consiste na criação de um sistema em **Java** para gerir experiências científicas, investigadores e equipamentos laboratoriais.

## Objetivo
O objetivo principal foi aplicar conceitos de **Programação Orientada a Objetos (POO)** e **serialização** para desenvolver um sistema funcional que armazena, organiza e pesquisa dados sobre experiências científicas.

O sistema permite:
- Adicionar experiências, medições, investigadores e equipamentos
- Associar investigadores a experiências
- Efetuar pesquisas por nome, tipo, especialidade ou data
- Gerar relatórios detalhados sobre as experiências e entidades envolvidas
- Guardar e carregar os dados através de ficheiros binários utilizando serialização

## Funcionalidades principais
1. Adição e listagem de experiências científicas  
2. Gestão de medições, investigadores e equipamentos  
3. Associação de investigadores a experiências  
4. Pesquisa por nome, especialidade, data ou tipo  
5. Relatórios detalhados de experiências  
6. Serialização e recuperação automática de dados  
7. Interface via consola com menu interativo  

## Conceitos aplicados
- Programação Orientada a Objetos (POO): classes, herança, polimorfismo, interfaces e exceções  
- Manipulação de ficheiros e serialização  
- Estrutura modular e reutilizável  
- Organização de código e documentação com JavaDoc  

## Estrutura do projeto
- `Main.java` — classe principal, ponto de entrada do programa  
- `Equipamento.java`, `Investigador.java`, `Experiencia.java` — entidades principais  
- `Medicao.java` — registo de medições  
- `SistemaGestao.java` — lógica principal do sistema  
- Ficheiros `.ctxt` e `.dat` — armazenamento local de dados  
- Pasta `doc/` — documentação e relatório técnico  

## Execução
Compilar os ficheiros `.java` e executar a classe `Main`:

```bash
javac *.java
java Main

