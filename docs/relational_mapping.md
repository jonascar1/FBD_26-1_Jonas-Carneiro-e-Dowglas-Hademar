# Relational Mapping


## Rule 1 — Strong Entities

### PERSON

```
PERSON(**id**, name, cpf)
```

Each strong entity becomes a relation. The composite `address` attribute of Condominium is decomposed into simple subattributes. CPF is marked as a unique constraint.

> `cpf` → UNIQUE

---

### CONDOMINIUM

```
CONDOMINIUM(**id**, name, cnpj, number, cep, complement, neighborhood)
```

> `cnpj` → UNIQUE

---

### CONDOMINIUM_FEE

```
CONDOMINIUM_FEE(**id**, ref_month, due_date, pay_date, amount, late_fee, status)
```

---

## Rule 1 + Rule 3 — Specialization (1:1) — Person → Employee / Resident

The specialization Person → Employee / Resident is mapped using the **separate table approach**, where each subtype receives its own relation with the supertype's primary key as both PK and FK. This preserves the disjoint nature of the specialization.

### EMPLOYEE

```
EMPLOYEE(**person_id**, salary, role)
```

> `person_id` → FK referencing PERSON(id)

---

### RESIDENT

```
RESIDENT(**person_id**, type, primary_occupant)
```

> `person_id` → FK referencing PERSON(id)

---

## Rule 2 — Weak Entities

### APARTMENT

Weak entity dependent on CONDOMINIUM. The partial key `number` is only unique within the scope of its condominium, so the PK is composed of `number + condominium_id`.

```
APARTMENT(**number, condominium_id**, floor, status)
```

> `condominium_id` → FK referencing CONDOMINIUM(id)  
> UNIQUE constraint on `(number, condominium_id)`

---

### DEPENDENT

Weak entity dependent on RESIDENT. The partial key is composed of `name + birth_date`, since name alone is not sufficient to uniquely identify a dependent within a resident.

```
DEPENDENT(**name, birth_date, resident_id**, relationship)
```

> `resident_id` → FK referencing RESIDENT(person_id)

---

## Rule 4 — Binary 1:N Relationships

### WORK (Employee × Condominium)

Each employee works at exactly one condominium (1,1), while a condominium has one or more employees (1,n). The FK is placed on the N-side (EMPLOYEE), along with the relationship's own attributes.

```
EMPLOYEE(**person_id**, salary, role, condominium_id, workplace, start_time, end_time)
```

> `condominium_id` → FK referencing CONDOMINIUM(id)

> **Note:** The EMPLOYEE table from Rule 1+3 is updated here to incorporate the Work relationship attributes directly, since the cardinality on the employee side is (1,1) — every employee must work at exactly one condominium.

---

## Rule 6 — Multivalued Attribute

### PERSON_PHONE

The `phone` attribute of PERSON is multivalued — a person may have multiple phone numbers. A separate relation is created with the entity's PK as FK, forming a composite PK.

```
PERSON_PHONE(**person_id, phone**)
```

> `person_id` → FK referencing PERSON(id)

---

## Rule 7 — Ternary Relationships (n > 2)

### OCCUPANCY (Resident × Apartment × Condominium)

Ternary relationship recording the history of residency. All three PKs of the participating entities become FKs, and together form the composite PK of the new relation. Note that since APARTMENT is a weak entity, its PK is already composite (`number + condominium_id`), so `apt_condominium_id` implicitly also anchors this record to its condominium.

```
OCCUPANCY(**resident_id, apt_number, apt_condominium_id**, start_date, end_date)
```

> `resident_id` → FK referencing RESIDENT(person_id)  
> `apt_number + apt_condominium_id` → FK referencing APARTMENT(number, condominium_id)

---

### CHARGES (Resident × Apartment × Condominium_Fee)

Ternary relationship establishing which resident is financially responsible for which apartment in each fee record.

```
CHARGES(**resident_id, apt_number, apt_condominium_id, condominium_fee_id**)
```

> `resident_id` → FK referencing RESIDENT(person_id)  
> `apt_number + apt_condominium_id` → FK referencing APARTMENT(number, condominium_id)  
> `condominium_fee_id` → FK referencing CONDOMINIUM_FEE(id)

---

## Summary Table

| Relation | Origin | Rule Applied |
|---|---|---|
| PERSON | Strong entity | R1 |
| CONDOMINIUM | Strong entity | R1 |
| CONDOMINIUM_FEE | Strong entity | R1 |
| EMPLOYEE | Specialization of Person | R1 + R3 |
| RESIDENT | Specialization of Person | R1 + R3 |
| APARTMENT | Weak entity of Condominium | R2 |
| DEPENDENT | Weak entity of Resident | R2 |
| EMPLOYEE  | Binary 1:N — Work | R4 |
| PERSON_PHONE | Multivalued attribute of Person | R6 |
| OCCUPANCY | Ternary — Resident × Apartment × Condominium | R7 |
| CHARGES | Ternary — Resident × Apartment × Condominium_Fee | R7 |

---

> **Legend:** `**attribute**` = Primary Key (PK) — `FK` = Foreign Key — `UNIQUE` = Uniqueness constraint

---
Previous: [Conceptual Data Dictionary](https://github.com/jonascar1/FBD_26-1_Jonas-Carneiro-e-Dowglas-Hademar/blob/task/2vasubmission/docs/conceptual_data_dictionary.md)                  
Next: [Relational Data Dictionary With SQL](https://github.com/jonascar1/FBD_26-1_Jonas-Carneiro-e-Dowglas-Hademar/blob/task/2vasubmission/docs/relational_data_dictionary_with_sql.md)
