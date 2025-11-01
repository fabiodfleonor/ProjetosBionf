# Projeto SQL — T1_G2

Base de dados para gestão de pedidos de deslocação e reembolso.  
Inclui criação de tabelas, chaves, constraints, procedures, triggers e views.

## Objetivo
Modelar e implementar um sistema que regista pedidos de deslocação, seus anexos, aprovação por superior e respetivos reembolsos.

## Modelo
O diagrama entidade-relação encontra-se no ficheiro `Modelo_ER.jpg`.

## Estrutura principal
Tabelas:  
Colaborador, Superior, Origem, Destino, Tipo_Financiamento, Tipo_Transporte, Tipo_Anexo, Anexo, Mes,  
Pedido_Deslocacao, Pedido_Reembolso

Procedures:  
SP_Submeter_Pedido_Deslocacao, SP_Aprovar_Pedido_Deslocacao, SP_Submeter_Pedido_Reembolso

Triggers:  
validação de datas, regras de financiamento, inserções automáticas de apoio

Views:  
consultas de pedidos por colaborador, por estado, e reembolsos

## Como executar
1. Abrir o `Projeto_T1_G2.sql` no SQL Server Management Studio  
2. Executar o script completo  
   - cria a base de dados `T1_G2`  
   - cria tabelas, chaves e restantes objetos  
3. Se necessário, voltar a executar apenas a secção de inserts de testes

## Notas
- O script foi escrito para SQL Server  
- Ajustes a nomes de ficheiros ou paths podem ser necessários conforme o ambiente
