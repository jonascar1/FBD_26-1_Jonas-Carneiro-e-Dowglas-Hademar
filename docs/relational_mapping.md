## PERSON

```
PERSON(**ID**, CPF, Name, Role, Salary, Type, Primary_occupant, person_type)
```

## Generalization/Specialization (Person → Occupant Types)

The **Person** entity includes the attributes `person_type` and `primary_occupant`, which indicate different categories of person within the condominium. Instead of creating separate tables for each category, the specialization was represented through attributes in the same entity. This approach simplifies the database structure and avoids redundancy, since all occupant types share the same core attributes.

## PERSON_PHONE

```
PERSON_PHONE(**person_ID, phone**)
```

## Multivalued Attribute (person_phone)

The **person_phone** table was created to represent the multivalued phone number attribute. Since a person may have multiple phone numbers, storing them in a single column would violate normalization principles. Creating a separate table allows the system to store any number of phone records for each person while maintaining data consistency.

## DEPENDENT

```
DEPENDENT(**person_ID, Name**, Relationship)
```

## Weak Entity (Dependent)

The **Dependent** entity was modeled as a weak entity because it cannot exist independently of a registered person. A dependent is identified through the foreign key `person_ID`, which links it directly to its owner. Therefore, its existence depends on the corresponding **Person** entity, making the weak entity approach appropriate.

## CONDOMINIUM

```
CONDOMINIUM(**ID**, CNPJ, Name, Number, CEP, Complement, Neighborhood, Start_time, End_time, Workplace)
```

## APARTMENT

```
APARTMENT(**Number, condominium_ID**, condo_fee)
```

## LIVES_PERSON_CONDOMINIUM_APARTMENT

```
LIVES_PERSON_CONDOMINIUM_APARTMENT(**fk_number,fk_Person_ID, fk_Condominium_ID**, Amount, Payment_status, Reference_date, Payment_date, Due_date, Late_fee)
```

## Many-to-Many Relationship (Person × Condominium × Apartment)

The relationship between people and apartments was mapped using the associative entity **Lives_Person_Condominium_Apartment**. This solution was chosen because a person may be associated with multiple apartments over time, and an apartment may be occupied by different people. Additionally, the relationship has its own attributes, such as payment amount, status, due date, and payment date, which justify the creation of a separate table.

```text
obs: ** atribute ** = PK