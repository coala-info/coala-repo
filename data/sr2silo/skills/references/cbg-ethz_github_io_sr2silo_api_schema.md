[ ]
[ ]

[Skip to content](#data-schemas)

[![logo](../../assets/logo.svg)](../.. "sr2silo")

sr2silo

Data Schemas

Initializing search

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [Usage](../../usage/configuration/)
* [API Reference](../loculus/)
* [Contributing](../../contributing/)

[![logo](../../assets/logo.svg)](../.. "sr2silo")
sr2silo

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [ ]

  Usage

  Usage
  + [Configuration](../../usage/configuration/)
  + [Multi-Organism Support](../../usage/organisms/)
  + [Deployment](../../usage/deployment/)
  + [Resource Requirements](../../usage/resource_requirements/)
* [x]

  API Reference

  API Reference
  + [Loculus Integration](../loculus/)
  + [Processing](../process/)
  + [ ]

    Data Schemas

    [Data Schemas](./)

    Table of contents
    - [Output Format](#output-format)
    - [Modifying the Schema](#modifying-the-schema)
    - [ReadMetadata](#readmetadata)
    - [ReadMetadata](#sr2silo.silo_read_schema.ReadMetadata)
    - [NucleotideSegment](#nucleotidesegment)
    - [NucleotideSegment](#sr2silo.silo_read_schema.NucleotideSegment)

      * [validate\_nucleotide\_insertions](#sr2silo.silo_read_schema.NucleotideSegment.validate_nucleotide_insertions)
      * [validate\_nucleotide\_sequence](#sr2silo.silo_read_schema.NucleotideSegment.validate_nucleotide_sequence)
      * [validate\_offset](#sr2silo.silo_read_schema.NucleotideSegment.validate_offset)
    - [AminoAcidSegment](#aminoacidsegment)
    - [AminoAcidSegment](#sr2silo.silo_read_schema.AminoAcidSegment)

      * [validate\_amino\_acid\_insertions](#sr2silo.silo_read_schema.AminoAcidSegment.validate_amino_acid_insertions)
      * [validate\_amino\_acid\_sequence](#sr2silo.silo_read_schema.AminoAcidSegment.validate_amino_acid_sequence)
      * [validate\_offset](#sr2silo.silo_read_schema.AminoAcidSegment.validate_offset)
    - [AlignedReadSchema](#alignedreadschema)
    - [AlignedReadSchema](#sr2silo.silo_read_schema.AlignedReadSchema)

      * [validate\_dynamic\_fields](#sr2silo.silo_read_schema.AlignedReadSchema.validate_dynamic_fields)
  + [V-Pipe Integration](../vpipe/)
* [ ]

  Contributing

  Contributing
  + [Overview](../../contributing/)
  + [Branching Strategy](../../contributing/branching-strategy/)

# Data Schemas

Pydantic schemas defining the SILO database format for reads.

These schemas validate read data before submission to SILO, ensuring all records conform to the expected format. Sequences follow [IUPAC nucleotide codes](https://www.bioinformatics.org/sms2/iupac.html).

## Output Format

The output format for LAPIS-SILO v0.8.0+ uses:

* **camelCase naming** for metadata fields (e.g., `readId`, `sampleId`, `batchId`)
* **Flat structure** with metadata at root level (no nested "metadata" object)
* **Segment format** with `sequence`, `insertions`, and `offset` fields
* **Insertion format** as `"position:sequence"` (e.g., `"123:ACGT"`)

## Modifying the Schema

To customize the output schema for your use case:

1. **Edit the schema file** at `src/sr2silo/silo_read_schema.py`:
2. Add or modify fields in the `ReadMetadata` class
3. Use Pydantic `Field(alias="camelCaseName")` for camelCase output
4. **Update the database config** at `resources/silo/database_config.yaml`:
5. Ensure field names match the Pydantic aliases
6. **Run validation** to verify consistency:

   ```
   python tests/test_database_config_validation.py
   ```

This validation ensures your Pydantic schema matches the SILO database configuration.

## ReadMetadata

## `sr2silo.silo_read_schema.ReadMetadata`

Bases: `BaseModel`

V-Pipe SILO-specific pydantic schema for ReadMetadata JSON format.
(specific to WISE / run at ETHZ)

Uses camelCase aliases for serialization to match SILO database schema,
while maintaining snake\_case field names for Python conventions.

## NucleotideSegment

## `sr2silo.silo_read_schema.NucleotideSegment`

Bases: `BaseModel`

Schema for a nucleotide genomic segment (e.g., main nucleotide sequence).

### `validate_nucleotide_insertions(v)` `classmethod`

Validate that nucleotide insertions have the format 'position:sequence'.

### `validate_nucleotide_sequence(v)` `classmethod`

Validate that sequence contains only valid nucleotide characters.

### `validate_offset(v)` `classmethod`

Validate that offset is non-negative.

## AminoAcidSegment

## `sr2silo.silo_read_schema.AminoAcidSegment`

Bases: `BaseModel`

Schema for an amino acid genomic segment (e.g., gene sequences).

### `validate_amino_acid_insertions(v)` `classmethod`

Validate that amino acid insertions have the format 'position:sequence'.

### `validate_amino_acid_sequence(v)` `classmethod`

Validate that sequence contains only valid amino acid characters.

### `validate_offset(v)` `classmethod`

Validate that offset is non-negative.

## AlignedReadSchema

## `sr2silo.silo_read_schema.AlignedReadSchema`

Bases: `BaseModel`

SILO-specific pydantic schema for AlignedRead JSON format.

This schema validates the new SILO format where:
- readId is a required field at the root level (uses camelCase alias)
- Metadata fields are at the root level (use camelCase aliases)
- 'main' is a nucleotide segment with nucleotide-specific validation
- Gene segments are amino acid segments with amino acid-specific validation
- Unaligned sequences are prefixed with 'unaligned\_'

### `validate_dynamic_fields()`

Validate gene segments, unaligned sequences, and metadata fields.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)