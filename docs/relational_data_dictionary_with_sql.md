## PERSON

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| ID | INTEGER | - | NOT NULL, UNIQUE | Rule 1 | - |
| CPF | VARCHAR(11) | - | PK | Rule 1 | - |
| Name | VARCHAR(100) | - | NOT NULL | Rule 1 | - |
| Role | VARCHAR(50) | NULL | - | Rule 1 | - |
| Salary | DECIMAL(12) | 0.00 | - | Rule 1 | - |
| Type | VARCHAR(50) | NULL | - | Rule 1 | - |
| primary_occupant | BOOLEAN | FALSE | - | Rule 1 | - |
| person_type | VARCHAR(30) | - | NOT NULL | Rule 1 | - |

---

## PERSON_PHONE

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| person_ID | INTEGER | - | PK, FK → PERSON(ID) | Rule 6 | - |
| phone | VARCHAR(20) | - | PK | Rule 6 | - |

---

## DEPENDENT

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| person_ID | INTEGER | - | PK, FK → PERSON(ID) | Rule 2 | - |
| Name | VARCHAR(100) | - | PK | Rule 2 | - |
| Relationship | VARCHAR(50) | - | NOT NULL | Rule 2 | - |

---

## CONDOMINIUM

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| ID | INTEGER | - | PK | Rule 1 | - |
| CNPJ | VARCHAR(14) | - | NOT NULL, UNIQUE | Rule 1 | - |
| Name | VARCHAR(100) | - | NOT NULL | Rule 1 | - |
| Number | INTEGER | - | NOT NULL | Rule 1 | - |
| CEP | VARCHAR(8) | - | NOT NULL | Rule 1 | - |
| Complement | VARCHAR(100) | NULL | - | Rule 1 | - |
| Neighborhood | VARCHAR(100) | - | NOT NULL | Rule 1 | - |
| Start_time | TIME | - | NOT NULL | Rule 1 | - |
| End_time | TIME | - | NOT NULL | Rule 1 | - |
| Workplace | VARCHAR(100) | NULL | - | Rule 1 | - |

---

## APARTMENT

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| Number | INTEGER | - | PK | Rule 2 | - |
| condominium_ID | INTEGER | - | PK, FK → CONDOMINIUM(ID) | Rule 2 | - |
| condo_fee | DECIMAL(10,2) | 0.00 | NOT NULL | Rule 2 | - |

---

## LIVES_PERSON_CONDOMINIUM_APARTMENT

| ATTRIBUTE | DATA TYPE | DEFAULT | CONSTRAINTS | CHECK | NOTES |
|------------|------------|------------|------------|------------|------------|
| fk_number | INTEGER | - | PK, FK → APARTMENT(Number) | Rule 7 | - |
| fk_Person_ID | INTEGER | - | PK, FK → PERSON(ID) | Rule 7 | - |
| fk_Condominium_ID | INTEGER | - | PK, FK → CONDOMINIUM(ID) | Rule 7 | - |
| Amount | DECIMAL(10,2) | 0.00 | NOT NULL | Rule 7 | - |
| Status | VARCHAR(20) | Pending | NOT NULL | Rule 7 | - |
| Reference_date | DATE | - | NOT NULL | Rule 7 | - |
| Payment_date | DATE | NULL | - | Rule 7 | - |
| Due_date | DATE | - | NOT NULL | Rule 7 | - |
| Late_fee | DECIMAL(10,2) | 0.00 | - | Rule 7 | - |