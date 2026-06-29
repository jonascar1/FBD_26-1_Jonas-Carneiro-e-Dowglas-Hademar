INSERT INTO CONDOMINIUM
    (CNPJ, NAME, NUMBER, CEP, COMPLEMENT, NEIGHBORHOOD)
VALUES
    ('45723174000110', 'Residencial Serra Verde',          120, '58995000', 'Bloco A', 'Centro'),
    ('31584220000129', 'Condomínio Alto das Acácias',       85, '56850000', 'Bloco B', 'Centro'),
    ('27651804000107', 'Residencial Vila Bela',            340, '56900000', 'Bloco C', 'Bom Jesus'),
    ('54178332000196', 'Condomínio Monte das Flores',      210, '56850000', 'Bloco D', 'Centro'),
    ('13824790000141', 'Residencial Bela Vista',           150, '58995000', 'Bloco E', 'Centro');


INSERT INTO PERSON
    (CPF, NAME)
VALUES
    ('39053344705', 'José Ricardo Albuquerque Nogueira'),
    ('52998224725', 'Mariana Beatriz Carvalho Nogueira'),
    ('11144477735', 'Francisco Antônio Pereira de Souza'),
    ('74682489084', 'Victor Astrobaldo Stradivarius'),
    ('98765432100', 'Ana Cláudia Batista Rodrigues'),
    ('12345678901', 'Carlos Eduardo Figueiredo Lima'),
    ('23456789012', 'Fernanda Cristina Oliveira Barros'),
    ('34567890123', 'Marina Alves Dumont Diniz'); 


INSERT INTO EMPLOYEE
    (PERSON_ID, SALARY, ROLE, CONDOMINIUM_ID, WORKPLACE, START_TIME, END_TIME)
VALUES
    (4, 5000.00, 'Síndico Administrativo', 1, 'Administração', '08:00:00', '18:00:00'),
    (5, 2500.00, 'Porteira Noturna',        1, 'Portaria',      '18:00:00', '06:00:00'),
    (6, 3200.00, 'Zelador',                 2, 'Portaria',      '07:00:00', '17:00:00'),
    (7, 2800.00, 'Auxiliar Administrativo', 3, 'Administração', '08:00:00', '17:00:00'),
    (8, 2800.00, 'Recepcionista',           5, 'Portaria',      '06:00:00', '14:00:00');


INSERT INTO RESIDENT
    (PERSON_ID, TYPE, PRIMARY_OCCUPANT)
VALUES
    (1, 'Owner',  TRUE),
    (2, 'Tenant', FALSE),
    (3, 'Owner',  TRUE),
    (6, 'Tenant', FALSE),
    (7, 'Owner',  TRUE);

INSERT INTO PERSON_PHONE
    (PERSON_ID, PHONE)
VALUES
    (1, '83998145623'),
    (2, '83996274185'),
    (3, '87999723146'),
    (4, '87998857301'),
    (5, '83991462859'),
    (1, '83993012784'),
    (3, '87991234567');



INSERT INTO DEPENDENT
    (PERSON_ID, NAME, BIRTH_DATE, RELATIONSHIP)
VALUES
    (1, 'Lucas Gabriel Albuquerque Nogueira', '2010-03-15', 'Son'),
    (1, 'Sofia Helena Albuquerque Nogueira',  '2013-07-22', 'Daughter'),
    (3, 'Maria Clara Pereira de Souza',       '2008-11-05', 'Daughter'),
    (3, 'João Victor Pereira de Souza',       '2011-04-18', 'Son'),
    (2, 'Lucas Silva Silva',                  '2012-06-10', 'Son'),
    (2, 'Pedro Augusto Carvalho Nogueira',    '2015-09-30', 'Son');



INSERT INTO APARTMENT
    (NUMBER, CONDOMINIUM_ID, FLOOR, STATUS)
VALUES
    (101, 1, 1, 'Occupied'),
    (102, 1, 1, 'Vacant'),
    (201, 2, 2, 'Occupied'),
    (202, 3, 2, 'Occupied'),
    (301, 4, 3, 'Occupied'),
    (103, 1, 1, 'Under renovation'),
    (301, 2, 3, 'Vacant');


INSERT INTO CONDOMINIUM_FEE
    (REFERENCE_MONTH, DUE_DATE, PAYMENT_DATE, AMOUNT, LATE_FEE, STATUS)
VALUES
    ('2025-06-01', '2025-06-10', '2025-06-05', 450.00,  0.00, 'Paid'),
    ('2025-06-01', '2025-06-10', '2025-06-06', 450.00,  0.00, 'Paid'),
    ('2025-06-01', '2025-06-10', NULL,          480.00, 30.00, 'Overdue'),
    ('2025-06-01', '2025-06-10', '2025-06-08', 500.00,  0.00, 'Paid'),
    ('2025-06-01', '2025-06-10', NULL,          420.00,  0.00, 'Pending'),
    ('2025-07-01', '2025-07-10', NULL,          450.00,  0.00, 'Pending'),
    ('2025-07-01', '2025-07-10', NULL,          480.00,  0.00, 'Pending');


INSERT INTO OCCUPANCY
    (RESIDENT_ID, APT_NUMBER, APT_CONDOMINIUM_ID, START_DATE, END_DATE)
VALUES
    (1, 101, 1, '2024-01-01', NULL),
    (2, 101, 1, '2023-05-01', '2024-01-01'),
    (3, 201, 2, '2023-08-15', NULL),
    (1, 102, 1, '2022-01-01', '2023-12-31'),
    (2, 301, 2, '2024-02-01', NULL);



INSERT INTO CHARGES
    (RESIDENT_ID, APT_NUMBER, APT_CONDOMINIUM_ID, CONDOMINIUM_FEE_ID)
VALUES
    (1, 101, 1, 1),
    (2, 101, 1, 2),
    (3, 201, 2, 3),
    (1, 101, 1, 6),
    (3, 201, 2, 7);
