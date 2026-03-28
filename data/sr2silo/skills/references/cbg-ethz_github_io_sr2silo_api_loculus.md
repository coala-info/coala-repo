[ ]
[ ]

[Skip to content](#loculus-integration)

[![logo](../../assets/logo.svg)](../.. "sr2silo")

sr2silo

Loculus Integration

Initializing search

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [Usage](../../usage/configuration/)
* [API Reference](./)
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
  + [ ]

    Loculus Integration

    [Loculus Integration](./)

    Table of contents
    - [LoculusClient](#loculusclient)
    - [LoculusClient](#sr2silo.loculus.LoculusClient)

      * [\_\_init\_\_](#sr2silo.loculus.LoculusClient.__init__)
      * [approve\_all](#sr2silo.loculus.LoculusClient.approve_all)
      * [authenticate](#sr2silo.loculus.LoculusClient.authenticate)
      * [request\_upload](#sr2silo.loculus.LoculusClient.request_upload)
      * [submit](#sr2silo.loculus.LoculusClient.submit)
    - [Submission](#submission)
    - [Submission](#sr2silo.loculus.Submission)

      * [\_\_init\_\_](#sr2silo.loculus.Submission.__init__)
      * [count\_reads](#sr2silo.loculus.Submission.count_reads)
      * [create\_metadata\_file](#sr2silo.loculus.Submission.create_metadata_file)
      * [generate\_placeholder\_fasta](#sr2silo.loculus.Submission.generate_placeholder_fasta)
      * [get\_submission\_ids\_from\_tsv](#sr2silo.loculus.Submission.get_submission_ids_from_tsv)
      * [parse\_metadata](#sr2silo.loculus.Submission.parse_metadata)
    - [LapisClient](#lapisclient)
    - [LapisClient](#sr2silo.loculus.LapisClient)

      * [\_\_init\_\_](#sr2silo.loculus.LapisClient.__init__)
      * [referenceGenome](#sr2silo.loculus.LapisClient.referenceGenome)
      * [referenceGenomeToFasta](#sr2silo.loculus.LapisClient.referenceGenomeToFasta)
  + [Processing](../process/)
  + [Data Schemas](../schema/)
  + [V-Pipe Integration](../vpipe/)
* [ ]

  Contributing

  Contributing
  + [Overview](../../contributing/)
  + [Branching Strategy](../../contributing/branching-strategy/)

# Loculus Integration

Client classes for interacting with Loculus/LAPIS backends.

## LoculusClient

## `sr2silo.loculus.LoculusClient`

Client for interacting with the Loculus API.

### `__init__(token_url, backend_url, organism)`

Initialize the Loculus client.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `token_url` | `str` | URL for authentication token endpoint (e.g. 'https:///realms//protocol/openid-connect/token') | *required* |
| `backend_url` | `str` | Base URL for backend endpoint | *required* |
| `organism` | `str` | Organism identifier (e.g., 'covid') | *required* |

### `approve_all(username)`

Approve all processed sequences for the authenticated user.

This releases all sequences that have been submitted and processed
by the backend, making them publicly available.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `username` | `str` | The username to filter approvals by (only approve sequences submitted by this user) | *required* |

Returns:

| Name | Type | Description |
| --- | --- | --- |
| `dict` | `dict` | Response from the approval API |

Raises:

| Type | Description |
| --- | --- |
| `Exception` | If approval fails or authentication token is missing |

### `authenticate(username, password)`

Fetch an access token from the token endpoint, to use with the Loculus backend.
Uses the `client_id` 'backend-client'.

### `request_upload(group_id, numberFiles)`

Request S3 pre-signed URLs to upload files.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `group_id` | `int` | The group ID for the upload request | *required* |
| `numberFiles` | `int` | The number of files to request upload URLs for | *required* |

Returns:

| Type | Description |
| --- | --- |
| `List[RequestUploadResponse]` | List of request-upload response objects containing fileId and pre-signed URL |

Raises:

| Type | Description |
| --- | --- |
| `Exception` | If the request fails or authentication token is missing |

### `submit(group_id, metadata_file_path, processed_file_path, nucleotide_alignment, submission_id=None, data_use_terms_type='OPEN', resubmit_duplicate=False)`

Submit data to the Lapis API using pre-signed upload approach.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `group_id` | `int` | The group ID for the submission | *required* |
| `metadata_file_path` | `Path` | Path to the metadata TSV file | *required* |
| `processed_file_path` | `Path` | Path to the processed data file (e.g., .ndjson.zst) | *required* |
| `nucleotide_alignment` | `Path` | Path to nucleotide alignment file (.bam) | *required* |
| `submission_id` | `str | None` | Unique identifier for this submission (auto-generated if not provided) | `None` |
| `data_use_terms_type` | `str` | Data use terms type (default: "OPEN") | `'OPEN'` |

Returns:

| Type | Description |
| --- | --- |
| `SubmitResponse` | Submit response object |

Raises:

| Type | Description |
| --- | --- |
| `Exception` | If submission fails or authentication token is missing |

## Submission

## `sr2silo.loculus.Submission`

Submission-related utilities.
Methods for generating placeholder FASTA files containing "NNN" sequences,
and S3 links

### `__init__(fasta, s3_link)`

Initialize the Submission object.

### `count_reads(silo_input)` `staticmethod`

Counts the number of reads in a silo input .ndjson.zstd or .ndjson file.

Assumption: each line in the file corresponds to one read.

### `create_metadata_file(processed_file, count_reads=False)` `staticmethod`

Create a metadata TSV file with the required submissionId header.

```
The metadata file will be saved in a 'submission' subdirectory of
its parent directory.
```

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `processed_file` | `Path` | Path to the processed file. | *required* |
| `count_reads` | `bool` | Whether to include a countReads column (default: False) | `False` |

Returns:

| Type | Description |
| --- | --- |
| `tuple[Path, str]` | Tuple of (Path to the created metadata file, submission ID) |

### `generate_placeholder_fasta(submission_ids)` `staticmethod`

Generates a placeholder FASTA file for each submission ID with "NNN" as
the sequence.

### `get_submission_ids_from_tsv(file_path)` `staticmethod`

Reads a TSV file and extracts submission IDs by parsing the
"submissionId" column.

### `parse_metadata(silo_input)` `staticmethod`

Parses the metadata from a silo input .ndjson.zstd or .ndjson
returning all metadata fields but readId as a dictionary with keys
in snake\_case format for internal Python use.

The input JSON uses camelCase (matching SILO database schema),
but this method returns snake\_case keys for Python conventions.

Assumptions

* the metadata is stored in the root of the object under the keys
* each read has the same metadata, up to readId

## LapisClient

## `sr2silo.loculus.LapisClient`

Client for interacting with the Lapis API.

### `__init__(lapisUrl)`

Initialize the Lapis client.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `lapisUrl` |  | Base URL for the Lapis API | *required* |

### `referenceGenome()`

Fetch reference genome from the Lapis `sample/referenceGenome` endpoint.

Returns:

| Type | Description |
| --- | --- |
| `dict` | JSON response as a dictionary. |

Raises:

| Type | Description |
| --- | --- |
| `Exception` | If the request fails. |

### `referenceGenomeToFasta(reference_json_string, nucleotide_out_fp, amino_acid_out_fp)` `staticmethod`

Convert a reference JSON from `sample/referenceGenome` endpoint
to separate nucleotide and amino acid reference FASTA files.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `reference_json_string` | `str` | JSON string containing reference sequences with 'nucleotideSequences' and 'genes' sections | *required* |
| `nucleotide_out_fp` | `Path` | Path to the output nucleotide FASTA file | *required* |
| `amino_acid_out_fp` | `Path` | Path to the output amino acid FASTA file | *required* |

Returns:

| Type | Description |
| --- | --- |
| `None` | None |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)