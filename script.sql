-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS Commerce;
USE Commerce;

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS Client (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    FName VARCHAR(10),
    Minit CHAR(3),
    LName VARCHAR(20),
    CPF CHAR(11),
    CNPJ CHAR(15),
    ClientType ENUM('PF', 'PJ') NOT NULL,
    Address VARCHAR(100),
    CONSTRAINT chk_client_type CHECK ((ClientType = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL) OR 
                                      (ClientType = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL)),
    CONSTRAINT unique_cpf_client UNIQUE (CPF),
    CONSTRAINT unique_cnpj_client UNIQUE (CNPJ)
);

-- Tabela Pagamento
CREATE TABLE IF NOT EXISTS Payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT NOT NULL,
    typePayment ENUM('Boleto', 'Cartão', 'Dois cartões', 'PIX') NOT NULL,
    CONSTRAINT fk_payment_client FOREIGN KEY (idClient) REFERENCES Client(idClient)
);

-- Tabela Pedido
CREATE TABLE IF NOT EXISTS Orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT NOT NULL,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_order_client FOREIGN KEY (idOrderClient) REFERENCES Client(idClient)
);

-- Tabela Entrega
CREATE TABLE IF NOT EXISTS Deliveries (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT NOT NULL,
    trackingCode VARCHAR(30) NOT NULL,
    deliveryStatus ENUM('Pendente', 'Em trânsito', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    deliveryAddress VARCHAR(255),
    CONSTRAINT fk_delivery_order FOREIGN KEY (idOrder) REFERENCES Orders(idOrder)
);

-- Tabela Produto
CREATE TABLE IF NOT EXISTS Product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    PName VARCHAR(30) NOT NULL,
    Classification_kids BOOL DEFAULT FALSE,
    Category ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis', 'Outros') NOT NULL,
    Avaliacao FLOAT DEFAULT 0,
    Size VARCHAR(10)
);

-- Tabela Produto Estoque
CREATE TABLE IF NOT EXISTS ProductStorage (
    idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
    StorageLocation VARCHAR(255),
    Quantity INT DEFAULT 0
);

-- Tabela Fornecedor
CREATE TABLE IF NOT EXISTS Supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    Contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

-- Tabela Produto Fornecedor
CREATE TABLE IF NOT EXISTS ProductSupplier (
    idPSSupplier INT NOT NULL,
    idPSProduct INT NOT NULL,
    quatity INT NOT NULL,
    PRIMARY KEY (idPSSupplier, idPSProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPSSupplier) REFERENCES Supplier (idSupplier),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPSProduct) REFERENCES Product (idProduct)
);

-- Tabela Vendedor
CREATE TABLE IF NOT EXISTS Seller (
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    Location VARCHAR(255),
    CNPJ CHAR(15),
    CPF CHAR(9),
    Contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);


-- Inserção de dadospara teste

-- Inserindo dados na tabela Client
INSERT INTO Client (FName, Minit, LName, CPF, CNPJ, ClientType, Address)
VALUES 
    ('Maria', 'J', 'Silva', '12345678901', NULL, 'PF', 'Rua das Flores, 123'),
    ('Empresa', NULL, 'X Ltda', NULL, '12345678000199', 'PJ', 'Av. das Empresas, 500'),
    ('João', 'A', 'Oliveira', '98765432100', NULL, 'PF', 'Rua Principal, 50');

-- Inserindo dados na tabela Payments
INSERT INTO Payments (idClient, typePayment)
VALUES 
    (1, 'Cartão'),
    (2, 'PIX'),
    (3, 'Boleto');

-- Inserindo dados na tabela Orders
INSERT INTO Orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
VALUES 
    (1, 'Confirmado', 'Pedido de eletrônicos', 15.00, FALSE),
    (2, 'Em processamento', 'Pedido de móveis', 30.00, TRUE),
    (3, 'Cancelado', 'Pedido de alimentos', 10.00, FALSE);

-- Inserindo dados na tabela Deliveries
INSERT INTO Deliveries (idOrder, trackingCode, deliveryStatus, deliveryAddress)
VALUES 
    (1, 'TRACK123456', 'Em trânsito', 'Rua das Flores, 123'),
    (2, 'TRACK789012', 'Pendente', 'Av. das Empresas, 500'),
    (3, 'TRACK345678', 'Cancelado', 'Rua Principal, 50');

-- Inserindo dados na tabela Product
INSERT INTO Product (PName, Classification_kids, Category, Avaliacao, Size)
VALUES 
    ('Notebook', FALSE, 'Eletrônico', 4.5, 'Médio'),
    ('Camiseta Infantil', TRUE, 'Vestimenta', 4.0, 'P'),
    ('Carrinho de Brinquedo', TRUE, 'Brinquedos', 5.0, 'Pequeno');

-- Inserindo dados na tabela ProductStorage
INSERT INTO ProductStorage (StorageLocation, Quantity)
VALUES 
    ('Galpão A - Setor 1', 100),
    ('Galpão B - Setor 2', 50),
    ('Galpão C - Setor 3', 200);

-- Inserindo dados na tabela Supplier
INSERT INTO Supplier (SocialName, CNPJ, Contact)
VALUES 
    ('Fornecedor ABC', '11222333000144', '11987654321'),
    ('Fornecedor XYZ', '22333444000155', '21987654322'),
    ('Fornecedor LMN', '33444555000166', '31987654323');

-- Inserindo dados na tabela ProductSupplier
INSERT INTO ProductSupplier (idPSSupplier, idPSProduct, quatity)
VALUES 
    (1, 1, 50),
    (2, 2, 30),
    (3, 3, 20);

-- Inserindo dados na tabela Seller
INSERT INTO Seller (SocialName, AbstName, Location, CNPJ, CPF, Contact)
VALUES 
    ('Loja Eletrônicos', 'Eletro Shop', 'Centro Comercial', '44555666000177', NULL, '21987654324'),
    ('Vendedor Móveis', 'Moveis Top', 'Av. Principal', NULL, '123456789', '31987654325'),
    ('Loja Infantil', 'Kids Store', 'Shopping ABC', '55666777000188', NULL, '11987654326');
    


-- Cosultas

-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT 
    c.idClient,
    CONCAT(c.FName, ' ', c.LName) AS ClientName,
    COUNT(o.idOrder) AS TotalOrders
FROM 
    Client c
LEFT JOIN 
    Orders o ON c.idClient = o.idOrderClient
GROUP BY 
    c.idClient, c.FName, c.LName
ORDER BY 
    TotalOrders DESC;

-- 2. Algum vendedor também é fornecedor?
SELECT 
    s.SocialName AS SellerName,
    sup.SocialName AS SupplierName
FROM 
    Seller s
INNER JOIN 
    Supplier sup ON s.CNPJ = sup.CNPJ OR s.CPF = sup.Contact;


-- 3. Relação de produtos, fornecedores e estoques
SELECT 
    p.PName AS ProductName,
    sup.SocialName AS SupplierName,
    ps.quatity AS SuppliedQuantity,
    st.StorageLocation,
    st.Quantity AS StockQuantity
FROM 
    Product p
INNER JOIN 
    ProductSupplier ps ON p.idProduct = ps.idPSProduct
INNER JOIN 
    Supplier sup ON ps.idPSSupplier = sup.idSupplier
LEFT JOIN 
    ProductStorage st ON st.idProductStorage = p.idProduct;


-- 4. Relação de nomes dos fornecedores e nomes dos produtos
SELECT 
    sup.SocialName AS SupplierName,
    p.PName AS ProductName
FROM 
    ProductSupplier ps
INNER JOIN 
    Supplier sup ON ps.idPSSupplier = sup.idSupplier
INNER JOIN 
    Product p ON ps.idPSProduct = p.idProduct
ORDER BY 
    sup.SocialName, p.PName;
    

-- 5. Quais clientes fizeram pedidos com status "Cancelado"?
SELECT 
    c.idClient,
    CONCAT(c.FName, ' ', c.LName) AS ClientName,
    o.idOrder,
    o.orderStatus
FROM 
    Client c
INNER JOIN 
    Orders o ON c.idClient = o.idOrderClient
WHERE 
    o.orderStatus = 'Cancelado';


-- 6. Produtos disponíveis no estoque com baixa quantidade (menos de 50 unidades)
SELECT 
    p.PName AS ProductName,
    st.StorageLocation,
    st.Quantity AS StockQuantity
FROM 
    Product p
INNER JOIN 
    ProductStorage st ON p.idProduct = st.idProductStorage
WHERE 
    st.Quantity < 50;


-- 7. Listagem de entregas pendentes ou em trânsito
SELECT 
    d.idDelivery,
    d.trackingCode,
    d.deliveryStatus,
    d.deliveryAddress,
    o.orderDescription AS OrderDescription
FROM 
    Deliveries d
INNER JOIN 
    Orders o ON d.idOrder = o.idOrder
WHERE 
    d.deliveryStatus IN ('Pendente', 'Em trânsito');


-- 8. Produtos mais vendidos por quantidade
SELECT 
    p.PName AS ProductName,
    SUM(ps.quatity) AS TotalSold
FROM 
    Product p
INNER JOIN 
    ProductSupplier ps ON p.idProduct = ps.idPSProduct
GROUP BY 
    p.PName
ORDER BY 
    TotalSold DESC;


-- 9. Qual cliente gastou mais em pedidos?
SELECT 
    c.idClient,
    CONCAT(c.FName, ' ', c.LName) AS ClientName,
    SUM(o.sendValue) AS TotalSpent
FROM 
    Client c
INNER JOIN 
    Orders o ON c.idClient = o.idOrderClient
GROUP BY 
    c.idClient, c.FName, c.LName
ORDER BY 
    TotalSpent DESC
LIMIT 1;


-- 10. Lista de vendedores com contato e localização
SELECT 
    s.SocialName AS SellerName,
    s.Contact,
    s.Location
FROM 
    Seller s;

