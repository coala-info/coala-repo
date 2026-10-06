# biom-format CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| biom-format_add_metadata | PASS |  |
| biom-format_convert | PASS |  |
| biom-format_export_metadata | PASS |  |
| biom-format_from_uc | PASS |  |
| biom-format_head | PASS |  |
| biom-format_normalize_table | PASS |  |
| biom-format_subset_table | PASS |  |
| biom-format_summarize_table | PASS |  |
| biom-format_table_ids | PASS |  |
| biom-format_validate_table | PASS |  |

## biom-format_add_metadata

### Tool Description
Add sample and/or observation metadata to BIOM-formatted files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom add-metadata [OPTIONS]

  Add metadata to a BIOM table.

  Add sample and/or observation metadata to BIOM-formatted files. See examples
  here: http://biom-format.org/documentation/adding_metadata.html

  Example usage:

  Add sample metadata to a BIOM table:

  $ biom add-metadata -i otu_table.biom -o table_with_sample_metadata.biom
  -m sample_metadata.txt

Options:
  -i, --input-fp FILE             The input BIOM table  [required]
  -o, --output-fp FILE            The output BIOM table  [required]
  -m, --sample-metadata-fp FILE   The sample metadata mapping file (will add
                                  sample metadata to the input BIOM table, if
                                  provided).
  --observation-metadata-fp FILE  The observation metadata mapping file (will
                                  add observation metadata to the input BIOM
                                  table, if provided).
  --sc-separated TEXT             Comma-separated list of the metadata fields
                                  to split on semicolons. This is useful for
                                  hierarchical data such as taxonomy or
                                  functional categories.
  --sc-pipe-separated TEXT        Comma-separated list of the metadata fields
                                  to split on semicolons and pipes ("|"). This
                                  is useful for hierarchical data such as
                                  functional categories with one-to-many
                                  mappings (e.g. x;y;z|x;y;w)).
  --int-fields TEXT               Comma-separated list of the metadata fields
                                  to cast to integers. This is useful for
                                  integer data such as "DaysSinceStart".
  --float-fields TEXT             Comma-separated list of the metadata fields
                                  to cast to floating point numbers. This is
                                  useful for real number data such as "pH".
  --sample-header TEXT            Comma-separated list of the sample metadata
                                  field names. This is useful if a header line
                                  is not provided with the metadata, if you
                                  want to rename the fields, or if you want to
                                  include only the first n fields where n is
                                  the number of entries provided here.
  --observation-header TEXT       Comma-separated list of the observation
                                  metadata field names. This is useful if a
                                  header line is not provided with the
                                  metadata, if you want to rename the fields,
                                  or if you want to include only the first n
                                  fields where n is the number of entries
                                  provided here.
  --output-as-json                Write the output file in JSON format.
  -h, --help                      Show this message and exit.
```

## biom-format_convert

### Tool Description
Convert between BIOM table formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom convert [OPTIONS]

  Convert to/from the BIOM table format.

  Convert between BIOM table formats. See examples here: http://biom-
  format.org/documentation/biom_conversion.html

  Example usage:

  Convert a "classic" BIOM file (tab-separated text) to an HDF5 BIOM formatted
  OTU table:

  $ biom convert -i table.txt -o table.biom --to-hdf5

Options:
  -i, --input-fp FILE             The input BIOM table  [required]
  -o, --output-fp FILE            The output BIOM table  [required]
  -m, --sample-metadata-fp FILE   The sample metadata mapping file (will add
                                  sample metadata to the input BIOM table, if
                                  provided).
  --observation-metadata-fp FILE  The observation metadata mapping file (will
                                  add observation metadata to the input BIOM
                                  table, if provided).
  --to-json                       Output as JSON-formatted table.
  --to-hdf5                       Output as HDF5-formatted table.
  --to-tsv                        Output as TSV-formatted (classic) table.
  --collapsed-samples             If --to_hdf5 is passed and the original
                                  table is a BIOM table with collapsed
                                  samples, this will update the sample
                                  metadata of the table to the supported HDF5
                                  collapsed format.
  --collapsed-observations        If --to_hdf5 is passed and the original
                                  table is a BIOM table with collapsed
                                  observations, this will update the
                                  observation metadata of the table to the
                                  supported HDF5 collapsed format.
  --header-key TEXT               The observation metadata to include from the
                                  input BIOM table file when creating a tsv
                                  table file. By default no observation
                                  metadata will be included.
  --output-metadata-id TEXT       The name to be given to the observation
                                  metadata column when creating a tsv table
                                  file if the column should be renamed.
  --table-type [OTU table|Pathway table|Function table|Ortholog table|Gene table|Metabolite table|Taxon table|Table]
                                  The type of the table.
  --process-obs-metadata [sc_separated|naive|taxonomy]
                                  Process metadata associated with
                                  observations when converting from a classic
                                  table.
  --tsv-metadata-formatter [sc_separated|naive]
                                  Method for formatting the observation
                                  metadata.
  -h, --help                      Show this message and exit.
```

## biom-format_export_metadata

### Tool Description
Export metadata as TSV.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom export-metadata [OPTIONS]

  Export metadata as TSV.

  Example usage:

  Export metadata as TSV:

  $ biom export-metadata -i otu_table.biom   --sample-metadata-fp sample.tsv
  --observation-metadata-fp observation.tsv

Options:
  -i, --input-fp FILE             The input BIOM table  [required]
  -m, --sample-metadata-fp FILE   The sample metadata output file.
  --observation-metadata-fp FILE  The observation metadata output file.
  -h, --help                      Show this message and exit.
```

## biom-format_from_uc

### Tool Description
Create a BIOM table from a vsearch/uclust/usearch BIOM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom from-uc [OPTIONS]

  Create a BIOM table from a vsearch/uclust/usearch BIOM file.

  Example usage:

  Simple BIOM creation:

  $ biom from-uc -i in.uc -o out.biom

  BIOM creation with OTU re-naming:

  $ biom from-uc -i in.uc -o out.biom --rep-set-fp rep-set.fna

Options:
  -i, --input-fp FILE   The input uc filepath.  [required]
  -o, --output-fp PATH  The output BIOM filepath  [required]
  --rep-set-fp FILE     Fasta file containing representative sequences with
                        where sequences are labeled with OTU identifiers, and
                        description fields contain original sequence
                        identifiers. This output is created, for example, by
                        vsearch with the --relabel_sha1 --relabel_keep
                        options.
  -h, --help            Show this message and exit.
```

## biom-format_head

### Tool Description
Dump the first bit of a table.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom head [OPTIONS]

  Dump the first bit of a table.

  Example usage:

  Print out the upper left corner of a BIOM table to standard out:

  $ biom head -i table.biom

Options:
  -i, --input-fp FILE   The input BIOM table  [required]
  -o, --output-fp PATH  An output file-path
  -n, --n-obs INTEGER   The number of observations to show
  -m, --n-samp INTEGER  The number of samples to show
  -h, --help            Show this message and exit.
```

## biom-format_normalize_table

### Tool Description
Normalize the values of a BIOM table through various methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom normalize-table [OPTIONS]

  Normalize a BIOM table.

  Normalize the values of a BIOM table through various methods. Relative
  abundance will take the relative abundance of each observation in terms of
  samples or observations.  Presence absensece will convert observations to
  1's and 0's based on presence of the observation.

  Example usage:

  Normalizing a BIOM table to relative abundnace:

  $ biom normalize-table -i table.biom -r -o normalized_table.biom

  Converting a BIOM table to a presence/absence table:

  $ biom normalize-table -i table.biom -p -o converted_table.biom

Options:
  -i, --input-fp FILE             The input BIOM table  [required]
  -o, --output-fp PATH            An output file-path
  -r, --relative-abund            convert table to relative abundance
  -p, --presence-absence          convert table to presence/absence
  -a, --axis [sample|observation]
                                  The axis to normalize over
  -h, --help                      Show this message and exit.
```

## biom-format_subset_table

### Tool Description
Subset a BIOM table, over either observations or samples, without fully parsing it.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom subset-table [OPTIONS]

  Subset a BIOM table.

  Subset a BIOM table, over either observations or samples, without fully
  parsing it. This command is intended to assist in working with very large
  tables when tight on memory, or as a lightweight way to subset a full table.
  Currently, it is possible to produce tables with rows or columns
  (observations or samples) that are fully zeroed.

  Example usage:

  Choose a subset of the observations in table.biom (JSON) and write them to
  subset.biom:

  $ biom subset-table -j table.biom -a observations -s observation_ids.txt
  -o subset.biom

  Choose a subset of the observations in table.biom (HDF5) and write them to
  subset.biom:

  $ biom subset-table -i table.biom -a observations -s observation_ids.txt
  -o subset.biom

Options:
  -i, --input-hdf5-fp FILE        the input hdf5 BIOM table filepath to subset
  -j, --input-json-fp FILE        the input json BIOM table filepath to subset
  -a, --axis [sample|observation]
                                  the axis to subset over, either sample or
                                  observation  [required]
  -s, --ids FILE                  a file containing a single column of IDs to
                                  retain (either sample IDs or observation
                                  IDs, depending on the axis)  [required]
  -o, --output-fp FILE            the output BIOM table filepath  [required]
  -h, --help                      Show this message and exit.
```

## biom-format_summarize_table

### Tool Description
Summarize sample or observation data in a BIOM table.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom summarize-table [OPTIONS]

  Summarize sample or observation data in a BIOM table.

  Provides details on the observation counts per sample, including summary
  statistics, as well as metadata categories associated with samples and
  observations.

  Example usage:

  Write a summary of table.biom to table_summary.txt:

  $ biom summarize-table -i table.biom -o table_summary.txt

Options:
  -i, --input-fp FILE   The input BIOM table  [required]
  -o, --output-fp FILE  An output file-path
  --qualitative         Present counts as number of unique observation ids per
                        sample, rather than counts of observations per sample.
  --observations        Summarize over observations
  -h, --help            Show this message and exit.
```

## biom-format_table_ids

### Tool Description
Dump out the IDs found within a table.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom table-ids [OPTIONS]

  Dump IDs in a table.

  Dump out the IDs found within a table:

  Example usage:

  Get the sample IDs within a table:

  $ biom table-ids -i table.biom

  Get the observation IDs within a table:

  $ biom table-ids -i table.biom --observations

Options:
  -i, --input-fp FILE  The input BIOM table  [required]
  --observations       Grab observation IDs
  -h, --help           Show this message and exit.
```

## biom-format_validate_table

### Tool Description
Test a file for adherence to the Biological Observation Matrix (BIOM) format specification.

### Metadata
- **Docker Image**: quay.io/biocontainers/biom-format:2.1.15
- **Homepage**: http://www.biom-format.org
- **Package**: https://anaconda.org/channels/bioconda/packages/biom-format/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: biom validate-table [OPTIONS]

  Validate a BIOM-formatted file.

  Test a file for adherence to the Biological Observation Matrix (BIOM) format
  specification. This specification is defined at http://biom-format.org

  Example usage:

  Validate the contents of table.biom for adherence to the BIOM format
  specification

  $ biom validate-table -i table.biom

Options:
  -i, --input-fp FILE        The input filepath to validate against the BIOM
                             format specification  [required]
  -f, --format-version TEXT  The specific format version to validate against
  -h, --help                 Show this message and exit.
```

## Metadata
- **Skill**: generated
