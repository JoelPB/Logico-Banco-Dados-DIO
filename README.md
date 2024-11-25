## Desafio de projeto da DIO [Construindo seu Primeiro Projeto Lógico de Banco de Dados](https://web.dio.me/lab/construindo-seu-primeiro-projeto-logico-de-banco-de-dados/learning/30ffb3b9-3e87-4471-b256-71f733a32ae7?back=/play)

---

Este projeto consiste na criação e manipulação de um banco de dados relacional para gerenciar informações de um sistema de comércio. Ele abrange funcionalidades relacionadas a clientes, pedidos, pagamentos, entregas, produtos, fornecedores, vendedores e estoque. Com base no diagrama relacional foi escrito o script SQL para gerar o banco, as tabalas, inserir dados e consultar dados.

## Estrutura do Banco de Dados
1. Tabelas Criadas
* Client: Armazena informações de clientes (pessoa física ou jurídica).
* Payments: Detalha os métodos de pagamento dos clientes.
* Orders: Contém informações sobre os pedidos realizados.
* Deliveries: Gerencia o status de entrega dos pedidos.
* Product: Lista os produtos disponíveis.
* ProductStorage: Controla o estoque de produtos.
* Supplier: Registra fornecedores e seus dados de contato.
* ProductSupplier: Relaciona produtos e fornecedores.
* Seller: Cadastra os vendedores e suas informações.
2. Regras de Integridade
* Restrições de chave estrangeira para relacionar as tabelas.
* Restrições de unicidade para evitar duplicatas (CPF, CNPJ).
* Checks para garantir consistência de dados, como validar CPF/CNPJ para pessoas físicas e jurídicas.

---

## Consultas Realizadas
1. Contagem de pedidos por cliente:
Identifica quantos pedidos cada cliente realizou.
2. Verificar se vendedores também são fornecedores:
Determina se há vendedores que atuam simultaneamente como fornecedores.
3. Relação entre produtos, fornecedores e estoque:
Mostra fornecedores e produtos fornecidos, com informações de estoque.
4. Nomes de fornecedores e produtos fornecidos:
Lista os fornecedores e os produtos que eles oferecem.
5. Clientes com pedidos cancelados:
Identifica clientes que tiveram pedidos com status "Cancelado".
6. Produtos com baixa quantidade no estoque (< 50 unidades):
Monitora produtos que precisam de reposição.
7. Entregas pendentes ou em trânsito:
Fornece uma visão do status logístico das entregas.
8. Produtos mais vendidos:
Lista produtos mais vendidos com base na quantidade fornecida.
9. Cliente com maior gasto em pedidos:
Identifica o cliente que gastou mais dinheiro.
10. Lista de vendedores com contato e localização:
Exibe informações básicas dos vendedores.

---

## Tecnologias Utilizadas
* MySQL Workbench: Gerenciador de banco de dados relacional.
* SQL: Linguagem utilizada para definição, manipulação e consulta de dados.


