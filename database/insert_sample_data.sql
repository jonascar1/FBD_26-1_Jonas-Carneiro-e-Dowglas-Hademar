INSERT INTO PERSON
(CPF, NAME, ROLE, SALARY, TYPE, PRIMARY_OCCUPANT, PERSON_TYPE)
VALUES
('39053344705', 'José Ricardo Albuquerque Nogueira', NULL, NULL, 'Owner', TRUE, 'Resident'),
('52998224725', 'Mariana Beatriz Carvalho Nogueira', NULL, NULL, 'Tenant', FALSE, 'Resident'),
('11144477735', 'Francisco Antônio Pereira de Souza', NULL, NULL, 'Owner', TRUE, 'Resident'),
('74682489084', 'Paulo Henrique Medeiros Menezes', 'Síndico Administrativo', 5000.00, NULL, FALSE, 'Employee'),
('98765432100', 'Ana Cláudia Batista Rodrigues', 'Porteira Noturna', 2500.00, NULL, FALSE, 'Employee');

INSERT INTO PERSON_PHONE
(PERSON_ID, PHONE)
VALUES
(1, '83998145623'),
(2, '83996274185'),
(3, '87999723146'),
(4, '87998857301'),
(5, '83991462859');

INSERT INTO DEPENDENT
(PERSON_ID, NAME, RELATIONSHIP)
VALUES
(1, 'Lucas Gabriel Albuquerque Nogueira', 'Son'),
(1, 'Sofia Helena Albuquerque Nogueira', 'Daughter'),
(3, 'Maria Clara Pereira de Souza', 'Daughter'),
(3, 'João Victor Pereira de Souza', 'Son'),
(4, 'Helena Beatriz Medeiros Menezes', 'Daughter');

INSERT INTO CONDOMINIUM
(CNPJ, NAME, NUMBER, CEP, COMPLEMENT, NEIGHBORHOOD, START_TIME, END_TIME, WORKPLACE)
VALUES
('45723174000110', 'Residencial Serra Verde', 120, '58995000', 'Bloco A', 'Centro', '08:00:00', '18:00:00', 'Portaria'),
('31584220000129', 'Condomínio Alto das Acácias', 85, '56850000', 'Bloco B', 'Centro', '08:00:00', '18:00:00', 'Administração'),
('27651804000107', 'Residencial Vila Bela', 340, '56900000', 'Bloco C', 'Bom Jesus', '08:00:00', '18:00:00', 'Portaria'),
('54178332000196', 'Condomínio Monte das Flores', 210, '56850000', 'Bloco D', 'Centro', '08:00:00', '18:00:00', 'Administração'),
('13824790000141', 'Residencial Bela Vista', 150, '58995000', 'Bloco E', 'Centro', '08:00:00', '18:00:00', 'Portaria');

INSERT INTO APARTMENT
(NUMBER, CONDOMINIUM_ID, CONDO_FEE)
VALUES
(101, 1, 450.00),
(102, 1, 450.00),
(201, 2, 480.00),
(202, 3, 500.00),
(301, 4, 420.00);

INSERT INTO LIVES_PERSON_CONDOMINIUM_APARTMENT
(FK_NUMBER, FK_PERSON_ID, FK_CONDOMINIUM_ID, AMOUNT, PAYMENT_STATUS,
REFERENCE_DATE, PAYMENT_DATE, DUE_DATE, LATE_FEE)
VALUES
(101, 1, 1, 450.00, 'PAID', '2025-06-01', '2025-06-05', '2025-06-10', 0.00),
(101, 2, 1, 450.00, 'PAID', '2025-06-01', '2025-06-06', '2025-06-10', 0.00),
(201, 3, 2, 480.00, 'OVERDUE', '2025-06-01', NULL, '2025-06-10', 30.00),
(202, 4, 3, 500.00, 'PAID', '2025-06-01', '2025-06-08', '2025-06-10', 0.00),
(301, 5, 4, 420.00, 'PENDING', '2025-06-01', NULL, '2025-06-10', 0.00);