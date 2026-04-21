# Conceptual Data Dictionary

## PERSON

In the Person entity, data about people in the system are stored, and they may be specialized as employees or residents. These people can be associated with apartments as residents or act in condominium management as employees.

| Attributes  | Description                           | Semantic Type | Required | Notes |
|------------|---------------------------------------|--------------|----------|------|
| person_id  | Person identifier                     | Simple       | Yes      | PK   |
| name       | Person's name                         | Simple       | Yes      | —    |
| cpf        | Person's CPF                          | Simple       | Yes      | —    |
| phone      | Set of person's phone numbers         | Multivalued  | Yes      | —    |

---

## RESIDENT

In the Resident entity, its specific attributes are stored, in addition to the attributes inherited from the Person entity, due to the specialization process. The resident may be associated with an apartment and may have dependents.

| Attributes         | Description                                              | Semantic Type | Required | Notes |
|-------------------|----------------------------------------------------------|--------------|----------|------|
| type              | Classifies the resident as owner or tenant               | Simple       | Yes      | —    |
| primary_occupant  | Indicates whether the resident is the main responsible for the apartment | Simple | Yes | Values: true or false |

---

## EMPLOYEE

In the Employee entity, its specific attributes are stored, in addition to the attributes inherited from the Person entity, due to the specialization process. The employee is associated with a condominium, where they work.

| Attributes | Description                                | Semantic Type | Required | Notes |
|-----------|--------------------------------------------|--------------|----------|------|
| workplace   | Indicates the condominium where the employee works  | Simple | Yes | FK |
| salary    | Monthly salary value                        | Simple       | Yes      | —    |
| role      | Describes the function performed by the employee | Simple | Yes | — |

---

## DEPENDENT

In the Dependent entity, its specific attributes are stored. It is a weak entity, whose existence depends on the Resident entity, always being associated with it.

| Attributes   | Description                                                | Semantic Type | Required | Notes |
|-------------|------------------------------------------------------------|--------------|----------|------|
| name         | Dependent's name                                           | Simple       | Yes      | Partial key (used together with resident id) |
| relationship | Degree of relationship of the dependent in relation to the resident | Simple | Yes | — |

---

## PAYMENT

In the Payment entity, information related to payments made by residents are stored, including values, dates, status, and possible late fees.

| Attributes        | Description                                              | Semantic Type | Required | Notes |
|------------------|----------------------------------------------------------|--------------|----------|------|
| payment_id       | Unique payment identifier                                | Simple       | Yes      | PK   |
| value            | Amount to be charged                                     | Simple       | Yes      | —    |
| due_date         | Deadline date to make the payment                        | Simple       | Yes      | —    |
| payment_date     | Date when the payment was made                           | Simple       | No       | —    |
| reference_date   | Period to which the payment refers                       | Simple       | Yes      | —    |
| status           | Payment status (paid, pending or overdue)                | Simple       | Yes      | —    |
| resident_id      | Foreign key that identifies the responsible resident     | Simple       | Yes      | FK   |
| late_fee         | Additional value charged in case of delay                | Simple       | Yes       | —    |

---

## APARTMENT

In the Apartment entity, information about the residential units of the condominium are stored, including their identification, number and condominium fee value, as well as the association with the condominium to which it belongs.

| Attributes        | Description                                      | Semantic Type | Required | Notes |
|------------------|--------------------------------------------------|--------------|----------|------|
| apartment_id     | Unique apartment identifier                      | Simple       | Yes      | PK   |
| number           | Apartment identifying number within the condominium | Simple    | Yes      | —    |
| condo_fee        | Condominium fee value charged to the apartment   | Simple       | Yes      | —    |
| condominium_id   | Foreign key that identifies the condominium to which the apartment belongs | Simple | Yes | FK |

---

## CONDOMINIUM

In the Condominium entity, general information about the condominium are stored, including its identification, name, CNPJ and address data.

| Attributes        | Description                                      | Semantic Type | Required | Notes |
|------------------|--------------------------------------------------|--------------|----------|------|
| condominium_id   | Unique condominium identifier                    | Simple       | Yes      | PK   |
| name             | Condominium name                                 | Simple       | Yes      | —    |
| cnpj             | Condominium CNPJ                                 | Simple       | Yes      | —    |
| address          | Set of information that represents the location of the condominium | Composite | Yes | Will be divided into subattributes (Number, NeighborHood, CEP, Complement) |