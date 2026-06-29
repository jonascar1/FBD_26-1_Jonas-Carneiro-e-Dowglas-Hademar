# Relational Data Dictionary With SQl

## PERSON

Strong entity. Stores core data shared by all people in the system. CPF is enforced as unique system-wide.

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| ID | INTEGER | — | PK | R1 | Auto-incremented |
| CPF | VARCHAR(11) | — | NOT NULL, UNIQUE | R1 | Uniqueness enforced system-wide |
| name | VARCHAR(100) | — | NOT NULL | R1 | — |

```sql
CREATE TABLE PERSON (
    
    ID   INTEGER      AUTO_INCREMENT PRIMARY KEY,
    CPF  VARCHAR(11)  NOT NULL UNIQUE,
    NAME VARCHAR(100) NOT NULL
);
```

---

## EMPLOYEE

Specialization of PERSON (R1 + R3). Stores employee-specific attributes. The Work relationship attributes are incorporated here since every employee works at exactly one condominium — cardinality (1,1) on the employee side — making EMPLOYEE the N-side of the 1:N relationship with CONDOMINIUM (R4).

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| person_ID | INTEGER | — | PK, FK → PERSON(ID) | R1 + R3 | — |
| salary | DECIMAL(15,2) | 0.00 | — | R1 + R3 | — |
| role | VARCHAR(50) | NULL | — | R1 + R3 | — |
| condominium_ID | INTEGER | — | NOT NULL, FK → CONDOMINIUM(ID) | R4 | Work relationship FK |
| workplace | VARCHAR(100) | NULL | — | R4 | Work relationship attribute |
| start_time | TIME | — | NOT NULL | R4 | Work relationship attribute |
| end_time | TIME | — | NOT NULL | R4 | Work relationship attribute |

```sql
CREATE TABLE EMPLOYEE (

    PERSON_ID      INTEGER,
    SALARY         DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    ROLE           VARCHAR(50)   NOT NULL,
    CONDOMINIUM_ID INTEGER       NOT NULL,
    WORKPLACE      VARCHAR(100)  DEFAULT NULL,
    START_TIME     TIME          NOT NULL,
    END_TIME       TIME          NOT NULL,

    PRIMARY KEY (PERSON_ID),

    FOREIGN KEY (PERSON_ID) REFERENCES PERSON(ID)
    ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (CONDOMINIUM_ID) REFERENCES CONDOMINIUM(ID)
    ON DELETE RESTRICT ON UPDATE CASCADE
);
```

---

## RESIDENT

Specialization of PERSON (R1 + R3). Stores resident-specific attributes. A resident may be linked to apartments through OCCUPANCY and may have DEPENDENTS.

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| person_ID | INTEGER | — | PK, FK → PERSON(ID) | R1 + R3 | — |
| type | VARCHAR(50) | NULL | — | R1 + R3 | e.g. Owner, Tenant |
| primary_occupant | BOOLEAN | FALSE | — | R1 + R3 | — |

```sql
CREATE TABLE RESIDENT (

    PERSON_ID        INTEGER,
    TYPE             VARCHAR(50) NOT NULL,
    PRIMARY_OCCUPANT BOOLEAN     NOT NULL DEFAULT FALSE,

    PRIMARY KEY (PERSON_ID),

    FOREIGN KEY (PERSON_ID) REFERENCES PERSON(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
```

---

## PERSON_PHONE

Created to represent the multivalued `phone` attribute of PERSON (R6). A person may have multiple phone numbers. The composite PK `(person_id, phone)` ensures no duplicate number is registered for the same person.

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| person_ID | INTEGER | — | PK, FK → PERSON(ID) | R6 | — |
| phone | VARCHAR(20) | — | PK | R6 | — |

```sql
CREATE TABLE PERSON_PHONE (

    PERSON_ID INTEGER,
    PHONE     VARCHAR(20),

    PRIMARY KEY (PERSON_ID, PHONE),

    FOREIGN KEY (PERSON_ID) REFERENCES PERSON(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
```

---

## DEPENDENT

Weak entity dependent on RESIDENT (R2). Cannot exist without an associated resident. The PK is composite: `(person_id, name, birth_date)`, where `name` and `birth_date` is the partial key anchored to its owner.

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| person_ID | INTEGER | — | PK, FK → RESIDENT(person_ID) | R2 | — |
| name | VARCHAR(100) | — | PK | R2 | Partial key |
| birth_date | DATE | — | PK, NOT NULL | R2 | Partial key |
| relationship | VARCHAR(50) | — | NOT NULL | R2 | — |

```sql
CREATE TABLE DEPENDENT (

    PERSON_ID    INTEGER,
    NAME         VARCHAR(100),
    BIRTH_DATE   DATE         NOT NULL,
    RELATIONSHIP VARCHAR(50)  NOT NULL,

    PRIMARY KEY (PERSON_ID, NAME, BIRTH_DATE),

    FOREIGN KEY (PERSON_ID) REFERENCES RESIDENT(PERSON_ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
```

---

## CONDOMINIUM

Strong entity (R1). The composite `address` attribute from the conceptual model was decomposed into its simple subattributes: `number`, `cep`, `complement` and `neighborhood`. CNPJ is enforced as unique system-wide.

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| ID | INTEGER | — | PK | R1 | Auto-incremented |
| CNPJ | VARCHAR(14) | — | NOT NULL, UNIQUE | R1 | Uniqueness enforced system-wide |
| name | VARCHAR(100) | — | NOT NULL | R1 | — |
| number | INTEGER | — | NOT NULL | R1 | Subattribute of address |
| CEP | VARCHAR(8) | — | NOT NULL | R1 | Subattribute of address |
| complement | VARCHAR(100) | NULL | — | R1 | Subattribute of address — optional |
| neighborhood | VARCHAR(100) | — | NOT NULL | R1 | Subattribute of address |

```sql
CREATE TABLE CONDOMINIUM (
    
    ID           INTEGER      AUTO_INCREMENT PRIMARY KEY,
    CNPJ         VARCHAR(14)  NOT NULL UNIQUE,
    NAME         VARCHAR(100) NOT NULL,
    NUMBER       INTEGER      NOT NULL,
    CEP          VARCHAR(8)   NOT NULL,
    COMPLEMENT   VARCHAR(100) DEFAULT NULL,
    NEIGHBORHOOD VARCHAR(100) NOT NULL
);
```

---

## APARTMENT

Weak entity dependent on CONDOMINIUM (R2). A residential unit cannot exist without belonging to a condominium. The PK is composite: `(number, condominium_id)`, since the apartment number is only unique within the scope of its condominium.

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| number | INTEGER | — | PK | R2 | Partial key — unique per condominium |
| condominium_ID | INTEGER | — | PK, FK → CONDOMINIUM(ID) | R2 | — |
| floor | INTEGER | NULL | — | R2 | — |
| status | VARCHAR(30) | NULL | — | R2 | e.g. Occupied, Vacant, Under renovation |

```sql
CREATE TABLE APARTMENT (

    NUMBER         INTEGER,
    CONDOMINIUM_ID INTEGER,
    FLOOR          INTEGER       DEFAULT NULL,
    STATUS         VARCHAR(30)   NOT NULL,

    PRIMARY KEY (NUMBER, CONDOMINIUM_ID),

    FOREIGN KEY (CONDOMINIUM_ID) REFERENCES CONDOMINIUM(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
```



---

## CONDOMINIUM_FEE

Strong entity (R1) introduced during the review to separate financial control from the occupancy relationship. Stores all billing records for monthly condominium fees, allowing independent tracking of charges, payments, late fees and statuses per billing cycle.

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| ID | INTEGER | — | PK | R1 | Auto-incremented |
| reference_month | DATE | — | NOT NULL | R1 | Month/year of the charge |
| due_date | DATE | — | NOT NULL | R1 | — |
| payment_date | DATE | NULL | — | R1 | Null if not yet paid |
| amount | DECIMAL(15,2) | 0.00 | NOT NULL | R1 | — |
| late_fee | DECIMAL(15,2) | 0.00 | — | R1 | Null if paid on time |
| status | VARCHAR(20) | 'Pending' | NOT NULL | R1 | e.g. Pending, Paid, Overdue |

```sql
CREATE TABLE CONDOMINIUM_FEE (
    
    ID              INTEGER       AUTO_INCREMENT PRIMARY KEY,
    REFERENCE_MONTH DATE          NOT NULL,
    DUE_DATE        DATE          NOT NULL,
    PAYMENT_DATE    DATE          DEFAULT NULL,
    AMOUNT          DECIMAL(15,2) DEFAULT 0.00 NOT NULL,
    LATE_FEE        DECIMAL(15,2) DEFAULT 0.00,
    STATUS          VARCHAR(20)   DEFAULT 'Pending' NOT NULL
);
```


---

## OCCUPANCY

Ternary associative relation (R7) recording the full history of residency between RESIDENT, APARTMENT and CONDOMINIUM. The composite PK is formed by the three participating FKs. Since APARTMENT is a weak entity with a composite PK, two columns are needed to reference it: `apt_number` and `apt_condominium_id`.

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| resident_ID | INTEGER | — | PK, FK → RESIDENT(person_ID) | R7 | — |
| apt_number | INTEGER | — | PK, FK → APARTMENT(number, condominium_id) | R7 | — |
| apt_condominium_ID | INTEGER | — | PK, FK → APARTMENT(number, condominium_id) | R7 | — |
| start_date | DATE | — | NOT NULL | R7 | — |
| end_date | DATE | NULL | — | R7 | Null if currently residing |

```sql
CREATE TABLE OCCUPANCY (

    RESIDENT_ID        INTEGER,
    APT_NUMBER         INTEGER,
    APT_CONDOMINIUM_ID INTEGER,
    START_DATE         DATE NOT NULL,
    END_DATE           DATE DEFAULT NULL,

    PRIMARY KEY (RESIDENT_ID, APT_NUMBER, APT_CONDOMINIUM_ID),

    FOREIGN KEY (RESIDENT_ID) REFERENCES RESIDENT(PERSON_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (APT_NUMBER, APT_CONDOMINIUM_ID) REFERENCES APARTMENT(NUMBER, CONDOMINIUM_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
```
---

## CHARGES

Ternary associative relation (R7) linking a RESIDENT and an APARTMENT to a CONDOMINIUM_FEE record, establishing who is financially responsible for which unit in each billing cycle.

| Attribute | Data Type | Default | Constraints | Rule | Notes |
|---|---|---|---|---|---|
| resident_ID | INTEGER | — | PK, FK → RESIDENT(person_ID) | R7 | — |
| apt_number | INTEGER | — | PK, FK → APARTMENT(number, condominium_id) | R7 | — |
| apt_condominium_ID | INTEGER | — | PK, FK → APARTMENT(number, condominium_id) | R7 | — |
| condominium_fee_ID | INTEGER | — | PK, FK → CONDOMINIUM_FEE(ID) | R7 | — |

```sql
CREATE TABLE CHARGES (

    RESIDENT_ID        INTEGER,
    APT_NUMBER         INTEGER,
    APT_CONDOMINIUM_ID INTEGER,
    CONDOMINIUM_FEE_ID INTEGER,
    
    PRIMARY KEY (RESIDENT_ID, APT_NUMBER, APT_CONDOMINIUM_ID, CONDOMINIUM_FEE_ID),

    FOREIGN KEY (RESIDENT_ID) REFERENCES RESIDENT(PERSON_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (APT_NUMBER, APT_CONDOMINIUM_ID) REFERENCES APARTMENT(NUMBER, CONDOMINIUM_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (CONDOMINIUM_FEE_ID) REFERENCES CONDOMINIUM_FEE(ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
```



## Modeling Explanation

### Specialization — Person → Employee / Resident

- **Decision:** separate tables (R1 + R3)
- **Approach:** PERSON holds only shared attributes; EMPLOYEE and RESIDENT each have their own table with `person_id` as PK/FK referencing PERSON
- **Why:** preserves the disjoint nature of the specialization cleanly, avoids nullable columns for attributes that do not apply to both subtypes, and keeps each table semantically focused

---

### Work relationship — Employee × Condominium

- **Decision:** attributes incorporated into EMPLOYEE (R4)
- **Approach:** `condominium_id`, `workplace`, `start_time` and `end_time` are columns of EMPLOYEE, not a separate table
- **Why:** the cardinality on the employee side is (1,1) — every employee works at exactly one condominium. In a 1:N relationship, the FK and relationship attributes go on the N-side, which is EMPLOYEE (many employees per condominium)

---

### Occupancy and Financial Control — OCCUPANCY + CHARGES + CONDOMINIUM_FEE

- **Decision:** residency history and financial billing are modeled as distinct relations (R7 + R1)
- **Approach:** `OCCUPANCY` records who lives in which apartment and condominium, along with move-in and move-out dates; `CONDOMINIUM_FEE` is a standalone strong entity storing all billing attributes per cycle; `CHARGES` is a ternary associative table linking a resident and an apartment to a fee record
- **Why:** residency and financial responsibility are independent concerns — a resident may be registered in an apartment without an active charge, and a fee record carries its own lifecycle (reference month, due date, payment date, status) that does not belong to the occupancy history

---

### Summary Table

| Relation | Origin | Rule |
|---|---|---|
| PERSON | Strong entity | R1 |
| EMPLOYEE | Specialization of Person + Work (1:N) | R1 + R3 + R4 |
| RESIDENT | Specialization of Person | R1 + R3 |
| CONDOMINIUM | Strong entity | R1 |
| CONDOMINIUM_FEE | Strong entity | R1 |
| APARTMENT | Weak entity of Condominium | R2 |
| DEPENDENT | Weak entity of Resident | R2 |
| PERSON_PHONE | Multivalued attribute of Person | R6 |
| OCCUPANCY | Ternary — Resident × Apartment × Condominium | R7 |
| CHARGES | Ternary — Resident × Apartment × Condominium_Fee | R7 |

---

> **Legend:** `PK` = Primary Key — `FK` = Foreign Key — `UNIQUE` = Uniqueness constraint