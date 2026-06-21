## PERSON

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| ID | INTEGER | - |  PK | Rule 1 | - |
| CPF | VARCHAR(11) | - | NOT NULL, UNIQUE | Rule 1 | - |
| name | VARCHAR(100) | - | NOT NULL | Rule 1 | - |
| role | VARCHAR(50) | NULL | - | Rule 1 | - |
| salary | DECIMAL(15,2) | 1621.00 | - | Rule 1 | - |
| type | VARCHAR(50) | NULL | - | Rule 1 | - |
| primary_occupant | BOOLEAN | FALSE | - | Rule 1 | - |
| person_type | VARCHAR(30) | - | NOT NULL | Rule 1 | - |
---

 **SQL CODE:**
```sql
CREATE TABLE PERSON(
ID INTEGER PRIMARY KEY,
CPF VARCHAR(11) NOT NULL UNIQUE,
NAME VARCHAR(100) NOT NULL,
ROLE VARCHAR(50) DEFAULT NULL,
SALARY DECIMAL (15,2) DEFAULT 0.00,
TYPE VARCHAR(50) DEFAULT NULL,
PRIMARY_OCCUPANT BOOLEAN DEFAULT FALSE,
PERSON_TYPE VARCHAR(12) NOT NULL
);
```
---

## PERSON_PHONE

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| person_ID | INTEGER | - | PK, FK → PERSON(ID) | Rule 6 | - |
| phone | VARCHAR(20) | - | PK | Rule 6 | - |
---
**SQL CODE:**
```sql
CREATE TABLE PERSON_PHONE(
PERSON_ID INTEGER,
PHONE VARCHAR(20),
PRIMARY KEY (PERSON_ID, PHONE),
FOREIGN KEY (PERSON_ID) REFERENCES PERSON(ID)
);
```
---

## DEPENDENT

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| person_ID | INTEGER | - | PK, FK → PERSON(ID) | Rule 2 | - |
| name | VARCHAR(100) | - | PK | Rule 2 | - |
| relationship | VARCHAR(50) | - | NOT NULL | Rule 2 | - |
**SQL CODE:**

```sql
CREATE TABLE DEPENDENT(
PERSON_ID INTEGER,
NAME VARCHAR(100),
RELATIONSHIP VARCHAR(50) NOT NULL,
PRIMARY KEY (PERSON_ID, NAME),
FOREIGN KEY (PERSON_ID) REFERENCES PERSON(ID)
);
```
---

## CONDOMINIUM

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| ID | INTEGER | - | PK | Rule 1 | - |
| CNPJ | VARCHAR(14) | - | NOT NULL, UNIQUE | Rule 1 | - |
| name | VARCHAR(100) | - | NOT NULL | Rule 1 | - |
| number | INTEGER | - | NOT NULL | Rule 1 | - |
| CEP | VARCHAR(8) | - | NOT NULL | Rule 1 | - |
| complement | VARCHAR(100) | NULL | - | Rule 1 | - |
| neighborhood | VARCHAR(100) | - | NOT NULL | Rule 1 | - |
| start_time | TIME | - | NOT NULL | Rule 1 | - |
| end_time | TIME | - | NOT NULL | Rule 1 | - |
| Workplace | VARCHAR(100) | NULL | - | Rule 1 | - |
---
**SQL CODE**:
```sql
CREATE TABLE CONDOMINIUM(
ID INTEGER PRIMARY KEY,
CNPJ VARCHAR(14) NOT NULL UNIQUE,
NAME VARCHAR(100) NOT NULL,
NUMBER INTEGER NOT NULL,
CEP VARCHAR(8) NOT NULL,
COMPLEMENT VARCHAR(100) DEFAULT NULL,
NEIGHBORHOOD VARCHAR(100),
START_TIME TIME NOT NULL,
END_TIME TIME NOT NULL,
WORKPLACE VARCHAR(100) DEFAULT NULL
);
```

---

## APARTMENT

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| number | INTEGER | - | PK | Rule 2 | - |
| condominium_ID | INTEGER | - | PK, FK → CONDOMINIUM(ID) | Rule 2 | - |
| condo_fee | DECIMAL(15,2) | 0.00 | NOT NULL | Rule 2 | - |
---
**SQL CODE:**
```sql
CREATE TABLE APARTMENT(
NUMBER INTEGER,
CONDOMINIUM_ID INTEGER,
CONDO_FEE DECIMAL(15,2) DEFAULT 0.00 NOT NULL,
PRIMARY KEY (NUMBER, CONDOMINIUM_ID),
FOREIGN KEY(CONDOMINIUM_ID) REFERENCES CONDOMINIUM(ID)
);
```
---

## LIVES_PERSON_CONDOMINIUM_APARTMENT

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| fk_number | INTEGER | - | PK, FK → APARTMENT(Number) | Rule 7 | - |
| fk_Person_ID | INTEGER | - | PK, FK → PERSON(ID) | Rule 7 | - |
| fk_Condominium_ID | INTEGER | - | PK, FK → CONDOMINIUM(ID) | Rule 7 | - |
| amount | DECIMAL(15,2) | 0.00 | NOT NULL | Rule 7 | - |
| payment_status | VARCHAR(20) | Pending | NOT NULL | Rule 7 | - |
| reference_date | DATE | - | NOT NULL | Rule 7 | - |
| payment_date | DATE | NULL | - | Rule 7 | - |
| due_date | DATE | - | NOT NULL | Rule 7 | - |
| late_fee | DECIMAL(15,2) | 0.00 | - | Rule 7 | - |
---
**SQL CODE:**
```sql

CREATE TABLE LIVES_PERSON_CONDOMINIUM_APARTMENT(
FK_NUMBER INTEGER,
FK_PERSON_ID INTEGER,
FK_CONDOMINIUM_ID INTEGER,
AMOUNT DECIMAL(15,2) NOT NULL, 
PAYMENT_STATUS VARCHAR(20) DEFAULT 'PENDING' NOT NULL,
REFERENCE_DATE DATE NOT NULL,
PAYMENT_DATE DATE,
DUE_DATE DATE NOT NULL,
LATE_FEE DECIMAL(15,2),

FOREIGN KEY (FK_NUMBER, FK_CONDOMINIUM_ID) REFERENCES APARTMENT(NUMBER, CONDOMINIUM_ID),
FOREIGN KEY(FK_PERSON_ID) REFERENCES PERSON(ID),
PRIMARY KEY (FK_NUMBER,FK_PERSON_ID,FK_CONDOMINIUM_ID)
);

```
---