# Conceptual Data Dictionary

## 1. Entities


### 1.1 Person

Stores data about all people in the system. A person may be specialized as an Employee or a Resident. CPF is enforced as a unique constraint across the entire system.

| Attribute | Description | Semantic Type | Required | Notes |
|-----------|-------------|---------------|----------|-------|
| <u>id</u> | Unique person identifier | Simple | Yes | Candidate key |
| name | Full name of the person | Simple | Yes | — |
| <u>cpf</u> | Brazilian individual tax number | Simple | Yes | Candidate key (unique) |
| phone | Set of phone numbers for the person | Multivalued | Yes | — |

---

### 1.2 Employee

Specialization of Person. Stores employee-specific attributes. An employee is linked to exactly one Condominium through the Work relationship.

| Attribute | Description | Semantic Type | Required | Notes |
|-----------|-------------|---------------|----------|-------|
| salary | Monthly gross salary | Simple | Yes | — |
| role | Function performed by the employee | Simple | Yes | — |

---

### 1.3 Resident

Specialization of Person. Stores resident-specific attributes. A resident may be linked to apartments through Occupancy and may have Dependents.

| Attribute | Description | Semantic Type | Required | Notes |
|-----------|-------------|---------------|----------|-------|
| type | Classifies the resident as owner or tenant | Simple | Yes | — |
| primary_occupant | Indicates whether the resident is the main unit responsible | Simple | Yes | — |

---

### 1.4 Dependent *(Weak Entity)*

Weak entity dependent on Resident. Cannot exist without an associated Resident. A potential partial key is composed of `name + birth_date`, since name alone is not sufficient to uniquely identify a dependent within a resident.

| Attribute | Description | Semantic Type | Required | Notes |
|-----------|-------------|---------------|----------|-------|
| <u>name</u> | Dependent's full name | Simple | Yes | Candidate key |
| <u>birth_date</u> | Date of birth of the dependent | Simple | Yes | Candidate key  |
| relationship | Degree of kinship relative to the resident | Simple | Yes | — |

---

### 1.5 Apartment *(Weak Entity)*

Weak entity dependent on Condominium. Represents a residential unit within a condominium. The candidato key `number` is only unique within the scope of its Condominium — this uniqueness constraint is enforced per condominium.

| Attribute | Description | Semantic Type | Required | Notes |
|-----------|-------------|---------------|----------|-------|
| <u>number</u> | Unit number — unique within the condominium | Simple | Yes | Candidate key (unique per condominium) |
| floor | Floor on which the apartment is located | Simple | No | — |
| status | Current occupation status of the unit | Simple | Yes | e.g. Occupied, Vacant, Under renovation |

---

### 1.6 Condominium

Stores general information about the condominium. CNPJ is enforced as a unique constraint system-wide. The `address` attribute is composite, decomposed into subattributes.

| Attribute | Description | Semantic Type | Required | Notes |
|-----------|-------------|---------------|----------|-------|
| <u>id</u> | Unique condominium identifier | Simple | Yes | Candidate key|
| name | Official name of the condominium | Simple | Yes | — |
| <u>cnpj</u> | Brazilian corporate tax number | Simple | Yes | Candidate key (unique) |
| address | Full address of the condominium | Composite | Yes | Decomposed into subattributes below |
| &nbsp;&nbsp;number | Street number | Simple | Yes | Subattribute of address |
| &nbsp;&nbsp;cep | Brazilian postal code | Simple | Yes | Subattribute of address |
| &nbsp;&nbsp;complement | Additional address detail (apt, block, etc.) | Simple | No | Subattribute of address — optional |
| &nbsp;&nbsp;neighborhood | Neighborhood name | Simple | Yes | Subattribute of address |

---

### 1.7 Condominium_Fee

Stores all financial records related to monthly condominium fee billing. Separated from the occupancy relationship to allow independent tracking of charges, payments, late fees and statuses per billing cycle. Each record is linked to an apartment and a responsible resident through the ternary relationship **Charges**, and to a condominium through the ternary relationship **Belongs**.

| Attribute | Description | Semantic Type | Required | Notes |
|-----------|-------------|---------------|----------|-------|
| <u>id</u> | Unique fee record identifier | Simple | Yes | Candidate key|
| reference_month | Month and year to which the charge refers | Simple | Yes | — |
| due_date | Payment due date | Simple | Yes | — |
| payment_date | Actual date of payment | Simple | No | — |
| amount | Charge value for the period | Simple | Yes | — |
| late_fee | Fine applied in case of late payment | Simple | No | — |
| status | Current billing status | Simple | Yes | e.g. Pending, Paid, Overdue |

---

## 2. Relationships

---

### 2.1 Specialization — Person → Employee / Resident

Person is the supertype. Employee and Resident are disjoint specializations — a person may be one or the other, not both simultaneously.

| Relationship | Entities Involved | Cardinality | Type | Description |
|---|---|---|---|---|
| Person → Employee | Person, Employee | Person (0,1) — Employee (1,1) | Specialization (1:1) | Each employee is exactly one person; a person may or may not be an employee. |
| Person → Resident | Person, Resident | Person (0,1) — Resident (1,1) | Specialization (1:1) | Each resident is exactly one person; a person may or may not be a resident. |

---

### 2.2 Has — Resident × Dependent

A resident may have zero or more dependents. Each dependent belongs to exactly one resident and cannot exist without them (weak entity).

| Relationship | Entities Involved | Cardinality | Type | Description |
|---|---|---|---|---|
| Has | Resident, Dependent | Resident (0,n) — Dependent (1,1) | Binary 1:N | A resident has zero or more dependents; each dependent is linked to exactly one resident. |

---

### 2.3 Occupancy — Resident × Apartment × Condominium *(Ternary)*

Ternary relationship that records the history of residency. Allows tracking past and current occupancies, supporting vacant apartments and residents not yet assigned to a unit.

| Relationship | Entities Involved | Cardinality | Type | Description |
|---|---|---|---|---|
| Occupancy | Resident, Apartment, Condominium | Resident (0,n) / Apartment (0,n) / Condominium (1,n) | Ternary N:N:N | A resident can occupy zero or more apartments over time; an apartment can have zero or more residents over time; a condominium participates in one or more occupancies. |

**Attributes of Occupancy:**

| Attribute | Description | Semantic Type | Required | Notes |
|-----------|-------------|---------------|----------|-------|
| start_date | Date the resident moved into the apartment | Simple | Yes | — |
| end_date | Date the resident vacated the apartment | Simple | No | Null if currently residing |

---

### 2.4 Charges — Resident × Apartment × Condominium_Fee *(Ternary)*

Ternary relationship linking a resident and an apartment to a fee record, establishing who is financially responsible for which unit in a given billing cycle.

| Relationship | Entities Involved | Cardinality | Type | Description |
|---|---|---|---|---|
| Charges | Resident, Apartment, Condominium_Fee | Resident (0,n) / Apartment (0,n) / Condominium_Fee (1,1) | Ternary | A resident is responsible for zero or more fee records; an apartment generates one or more fee records; each fee record is tied to exactly one resident–apartment pair. |

---

### 2.5 Work — Employee × Condominium

Relates an employee to the condominium where they work. Each employee works at exactly one condominium; a condominium may have one or more employees.

| Relationship | Entities Involved | Cardinality | Type | Description |
|---|---|---|---|---|
| Work | Employee, Condominium | Employee (1,1) — Condominium (1,n) | Binary 1:N | Each employee is assigned to exactly one condominium; each condominium has one or more employees. |

**Attributes of Work:**

| Attribute | Description | Semantic Type | Required | Notes |
|-----------|-------------|---------------|----------|-------|
| workplace | Physical location or sector within the condominium | Simple | Yes | — |
| start_time | Daily shift start time | Simple | Yes | — |
| end_time | Daily shift end time | Simple | Yes | — |

---

## 3. Uniqueness Constraints

The following fields carry uniqueness constraints beyond their candidate keys, as required by business rules:

| Entity | Attribute | Constraint | Rule |
|--------|-----------|------------|------|
| Person | cpf | UNIQUE | No two people may share the same CPF in the system. |
| Condominium | cnpj | UNIQUE | No two condominiums may share the same CNPJ. |
| Apartment | number | UNIQUE per Condominium | The apartment number must be unique within each condominium (candidate key of weak entity). |
| Dependent | name + birth_date | UNIQUE per Resident | The combination of name and birth date must be unique within each resident's dependents. |
---
Next: [Relational Mapping](https://github.com/jonascar1/FBD_26-1_Jonas-Carneiro-e-Dowglas-Hademar/blob/task/2vasubmission/docs/relational_mapping.md)
See Also: [ER Diagram](https://github.com/jonascar1/FBD_26-1_Jonas-Carneiro-e-Dowglas-Hademar/blob/task/2vasubmission/media/er_diagram.png)
