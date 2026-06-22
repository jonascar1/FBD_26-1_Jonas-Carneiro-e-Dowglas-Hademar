# Conceptual Data Dictionary

## PERSON

In the Person entity, data about people in the system are stored, and they may be specialized as employees or residents. These people can be associated with apartments as residents or act in condominium management as employees.

| Attributes  | Description                           | Semantic Type | Required | Notes |
|------------|---------------------------------------|--------------|----------|------|
| id         | Person identifier                     | Simple       | Yes      | Candidate key |
| name       | Person's name                         | Simple       | Yes      | — |
| cpf        | Person's CPF                          | Simple       | Yes      | Candidate key |
| phone      | Set of person's phone numbers         | Multivalued  | Yes      | —    |

---

## RESIDENT

In the Resident entity, its specific attributes are stored, in addition to the attributes inherited from the Person entity, due to the specialization process. The resident may be associated with apartments and may have dependents.

| Attributes         | Description                                              | Semantic Type | Required | Notes |
|-------------------|----------------------------------------------------------|--------------|----------|------|
| type              | Classifies the resident as owner or tenant               | Simple       | Yes      | —    |
| primary_occupant  | Indicates whether the resident is the main responsible for the apartment | Simple | Yes | — |

---

## EMPLOYEE

In the Employee entity, its specific attributes are stored, in addition to the attributes inherited from the Person entity, due to the specialization process. The employee is associated with a condominium, where they work.

| Attributes | Description                                | Semantic Type | Required | Notes |
|-----------|--------------------------------------------|--------------|----------|------|
| salary    | Monthly salary value                        | Simple       | Yes      | —    |
| role      | Describes the function performed by the employee | Simple | Yes | — |

---

## DEPENDENT

In the Dependent entity, its specific attributes are stored. It is a weak entity, whose existence depends on the Resident entity, always being associated with it.

| Attributes   | Description                                                | Semantic Type | Required | Notes |
|-------------|------------------------------------------------------------|--------------|----------|------|
| name         | Dependent's name                                           | Simple       | Yes      | Partial key |
| relationship | Degree of relationship of the dependent in relation to the resident | Simple | Yes | — |

---

## APARTMENT

In the Apartment entity, information about the residential units of the condominium are stored, including their number and condominium fee value, as well as the association with the condominium to which it belongs. Also being a weak entity, it depends on a condominium to exist.

| Attributes        | Description                                      | Semantic Type | Required | Notes |
|------------------|--------------------------------------------------|--------------|----------|------|
| number           | Apartment identifying number within the condominium | Simple    | Yes      | Partial key |
| condo_fee        | Condominium fee value charged to the apartment   | Simple       | Yes      | —    |

---

## CONDOMINIUM

In the Condominium entity, general information about the condominium are stored, including its identification, name, CNPJ and address data.

| Attributes        | Description                                      | Semantic Type | Required | Notes |
|------------------|--------------------------------------------------|--------------|----------|------|
| id       | Unique condominium identifier                    | Simple       | Yes      | Candidate key |
| name     | Condominium name                                 | Simple       | Yes      | — |
| cnpj     | Condominium CNPJ                                 | Simple       | Yes      | Candidate key |
| address  | Set of information that represents the location of the condominium | Composite | Yes | Will be divided into subattributes (Number, NeighborHood, CEP, Complement) |

**Previous:** [Requirements](requirements.md)   
**Next:** [ER diagram](../media/er_diagram.png)  

