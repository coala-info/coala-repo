---
name: perl-json-validator
description: This tool validates Perl data structures against JSON Schema and OpenAPI specifications. Use when user asks to validate data against a schema, build schemas programmatically using a DSL, coerce data types, or bundle schemas for distribution.
homepage: https://github.com/jhthorsen/json-validator
metadata:
  docker_image: "quay.io/biocontainers/perl-json-validator:5.15--pl5321hdfd78af_0"
---

# perl-json-validator

## Overview
The `perl-json-validator` skill provides a robust framework for validating Perl data structures against formal schemas. It supports a wide range of standards, including various JSON Schema drafts and OpenAPI (Swagger) versions 2 and 3. Beyond simple validation, it allows for data coercion (e.g., converting strings to numbers where appropriate), schema bundling for distribution, and programmatic schema construction via an elegant DSL.

## Core Usage Patterns

### Basic Validation
To validate a Perl hash or array against a schema, initialize the validator and provide the schema definition.

```perl
use JSON::Validator;
my $jv = JSON::Validator->new;

# Load schema from a local file, URL, or inline hash
$jv->schema('file:///path/to/schema.json');

# Validate data
my @errors = $jv->validate({ name => "AI Assistant", version => 1.0 });

# Check for success
if (@errors) {
    say "Validation failed: $_" for @errors;
} else {
    say "Data is valid!";
}
```

### Programmatic Schema Building (Joi DSL)
For dynamic schema creation without writing raw JSON, use the `joi` helper.

```perl
use JSON::Validator::Joi 'joi';

my @errors = joi(
    { firstName => "Jan", age => 42 },
    joi->object->props({
        firstName => joi->string->required,
        age       => joi->integer->min(0),
    })
);
```

### Data Coercion
Enable coercion to automatically fix types (e.g., turning the string "123" into an integer) during the validation process.

```perl
# Recommended way to enable coercion on the schema object
$jv->schema->coerce({ numbers => 1, booleans => 1, strings => 1 });
```

### Handling OpenAPI Specifications
The validator automatically detects OpenAPI/Swagger specifications.

```perl
$jv->schema("https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/examples/v3.0/petstore.json");
# The validator now behaves as an OpenAPI validator
```

## Expert Tips and Best Practices

*   **Caching Remote Schemas**: When working with remote URLs, set the `JSON_VALIDATOR_CACHE_PATH` environment variable to avoid repeated network requests.
    ```bash
    export JSON_VALIDATOR_CACHE_PATH=/tmp/schema-cache
    ```
*   **Performance Optimization**: Install `Sereal::Encoder` (v4.00+) to significantly speed up `data_checksum` operations, which are used internally during schema parsing and validation.
*   **Schema Bundling**: Use the `bundle` method to resolve all `$ref` pointers and create a single, self-contained schema structure. This is useful for exporting schemas to environments without network access.
*   **Format Validation**: For specific formats like `hostname`, `ipv4`, or `email`, ensure the relevant optional Perl modules (like `Data::Validate::IP` or `Email::Valid`) are installed to enable deep format checking.

## Reference documentation
- [JSON::Validator GitHub Repository](./references/github_com_jhthorsen_json-validator.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-json-validator_overview.md)