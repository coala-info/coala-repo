# blobtoolkit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| blobtoolkit_add | PASS |  |
| blobtoolkit_create | PASS |  |
| blobtoolkit_filter | PASS |  |
| blobtoolkit_remove | PASS |  |
| blobtoolkit_replace | PASS |  |
| blobtoolkit_validate | PASS |  |
| blobtoolkit_view | PASS |  |

## blobtoolkit_add

### Tool Description
Add data to a BlobDir.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/blobtoolkit/blobtoolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Total Downloads**: 641
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/blobtoolkit/blobtoolkit
- **Stars**: N/A
### Original Help Text
```text
Add data to a BlobDir.

Usage:
    blobtools add [--bed BED...] [--beddir DIRECTORY] [--bedtsv TSV...] [--bedtsvdir DIRECTORY]
                  [--busco TSV...] [--cov BAM...] [--hits TSV...] [--fasta FASTA] [--hits-cols LIST]
                  [--key path=value...] [--link path=url...] [--taxid INT] [--skip-link-test]
                  [--blobdb JSON] [--meta YAML] [--synonyms TSV...] [--trnascan TSV...]
                  [--text TXT...] [--text-delimiter STRING] [--text-cols LIST] [--text-header]
                  [--text-no-array] [--taxdump DIRECTORY] [--taxrule bestsum|bestsumorder[=prefix]]
                  [--threads INT] [--evalue NUMBER] [--bitscore NUMBER] [--hit-count INT]
                  [--update-plot] [--pileup-args key=value...] [--create] [--replace] DIRECTORY

Arguments:
    DIRECTORY             Existing Blob directory.

Options:
    --bed BED             BED format file.
    --beddir DIRECTORY    Directory containing one or more BED format files.
    --bedtsv TSV          TSV file with header row and bed-format columns 1-3.
    --bedtsvdir DIRECTORY Directory containing one or more BED-like tsv files.
    --busco TSV           BUSCO full_table.tsv output file.
    --cov BAM             BAM/SAM/CRAM read alignment file.
    --fasta FASTA         FASTA sequence file.
    --hits TSV            Tabular BLAST/Diamond output file.
    --hits-cols LIST      Comma separated list of <column number>=<field name>.
                          [Default: 1=qseqid,2=staxids,3=bitscore,5=sseqid,10=qstart,11=qend,14=evalue]
    --taxid INT           Add ranks to metadata for a taxid.
    --key path=value      Set a metadata key to value.
    --link path=URL       Link to an external resource.
    --skip-link-test      Skip test to see if link URL can be resolved.
    --meta YAML           Dataset metadata.
    --blobdb JSON         Blobtools v1 blobDB.
    --synonyms TSV        TSV file containing current identifiers and synonyms.
    --taxdump DIRECTORY   Location of NCBI new_taxdump directory.
    --taxrule rulename[=prefix]
                          Rule to use when assigning BLAST hits to taxa (bestsum, bestsumorder,
                          bestdistsum, bestdistsumorder, blastp).
                          An alternate prefix may be specified. [Default: bestsumorder]
    --threads INT         Number of threads to use for multithreaded tasks. [Default: 1]
    --evalue FLOAT        Set evalue cutoff when parsing hits file. [Default: 1]
    --bitscore FLOAT      Set bitscore cutoff when parsing hits file. [Default: 1]
    --hit-count INT       Number of hits to parse when inferring taxonomy. [Default: 10]
    --update-plot         Flag to use new taxrule as default category.
    --text TXT            Generic text file.
    --text-delimiter STRING
                          Text file delimiter. [Default: whitespace]
    --text-cols LIST      Comma separated list of <column number>[=<field name>].
    --text-header         Flag to indicate first row of text file contains field names.
    --text-no-array       Flag to prevent fields in files with duplicate identifiers being
                          loaded as array fields.
    --trnascan TSV        tRNAscan2-SE output
    --pileup-args key=val Key/value pairs to pass to samtools pileup.
    --create              Create a new BlobDir.
    --replace             Replace existing fields with matching ids.

Examples:
    # 1. Add BUSCO scores to BlobDir
    blobtools add --busco busco.full_table.tsv BlobDir
```

## blobtoolkit_create

### Tool Description
Create a new BlobDir (blobtools add --create).

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/blobtoolkit/blobtoolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Total Downloads**: 641
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/blobtoolkit/blobtoolkit
- **Stars**: N/A
### Original Help Text
```text
Add data to a BlobDir.

Usage:
    blobtools add [--bed BED...] [--beddir DIRECTORY] [--bedtsv TSV...] [--bedtsvdir DIRECTORY]
                  [--busco TSV...] [--cov BAM...] [--hits TSV...] [--fasta FASTA] [--hits-cols LIST]
                  [--key path=value...] [--link path=url...] [--taxid INT] [--skip-link-test]
                  [--blobdb JSON] [--meta YAML] [--synonyms TSV...] [--trnascan TSV...]
                  [--text TXT...] [--text-delimiter STRING] [--text-cols LIST] [--text-header]
                  [--text-no-array] [--taxdump DIRECTORY] [--taxrule bestsum|bestsumorder[=prefix]]
                  [--threads INT] [--evalue NUMBER] [--bitscore NUMBER] [--hit-count INT]
                  [--update-plot] [--pileup-args key=value...] [--create] [--replace] DIRECTORY

Arguments:
    DIRECTORY             Existing Blob directory.

Options:
    --bed BED             BED format file.
    --beddir DIRECTORY    Directory containing one or more BED format files.
    --bedtsv TSV          TSV file with header row and bed-format columns 1-3.
    --bedtsvdir DIRECTORY Directory containing one or more BED-like tsv files.
    --busco TSV           BUSCO full_table.tsv output file.
    --cov BAM             BAM/SAM/CRAM read alignment file.
    --fasta FASTA         FASTA sequence file.
    --hits TSV            Tabular BLAST/Diamond output file.
    --hits-cols LIST      Comma separated list of <column number>=<field name>.
                          [Default: 1=qseqid,2=staxids,3=bitscore,5=sseqid,10=qstart,11=qend,14=evalue]
    --taxid INT           Add ranks to metadata for a taxid.
    --key path=value      Set a metadata key to value.
    --link path=URL       Link to an external resource.
    --skip-link-test      Skip test to see if link URL can be resolved.
    --meta YAML           Dataset metadata.
    --blobdb JSON         Blobtools v1 blobDB.
    --synonyms TSV        TSV file containing current identifiers and synonyms.
    --taxdump DIRECTORY   Location of NCBI new_taxdump directory.
    --taxrule rulename[=prefix]
                          Rule to use when assigning BLAST hits to taxa (bestsum, bestsumorder,
                          bestdistsum, bestdistsumorder, blastp).
                          An alternate prefix may be specified. [Default: bestsumorder]
    --threads INT         Number of threads to use for multithreaded tasks. [Default: 1]
    --evalue FLOAT        Set evalue cutoff when parsing hits file. [Default: 1]
    --bitscore FLOAT      Set bitscore cutoff when parsing hits file. [Default: 1]
    --hit-count INT       Number of hits to parse when inferring taxonomy. [Default: 10]
    --update-plot         Flag to use new taxrule as default category.
    --text TXT            Generic text file.
    --text-delimiter STRING
                          Text file delimiter. [Default: whitespace]
    --text-cols LIST      Comma separated list of <column number>[=<field name>].
    --text-header         Flag to indicate first row of text file contains field names.
    --text-no-array       Flag to prevent fields in files with duplicate identifiers being
                          loaded as array fields.
    --trnascan TSV        tRNAscan2-SE output
    --pileup-args key=val Key/value pairs to pass to samtools pileup.
    --create              Create a new BlobDir.
    --replace             Replace existing fields with matching ids.

Examples:
    # 1. Add BUSCO scores to BlobDir
    blobtools add --busco busco.full_table.tsv BlobDir
```

## blobtoolkit_filter

### Tool Description
Filter a BlobDir.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/blobtoolkit/blobtoolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Total Downloads**: 641
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/blobtoolkit/blobtoolkit
- **Stars**: N/A
### Original Help Text
```text
Filter a BlobDir.

Usage:
    blobtools filter [--param STRING...] [--query-string STRING] [--json JSON]
                     [--list TXT] [--invert] [--output DIRECTORY]
                     [--fasta FASTA] [--fastq FASTQ...] [--suffix STRING]
                     [--cov BAM] [--summary FILENAME] [--summary-rank RANK]
                     [--table FILENAME] [--table-fields STRING]
                     [--taxdump DIRECTORY] [--taxrule STRING] [--text TXT] [--text-header]
                     [--text-delimiter STRING] [--text-id-column INT] DIRECTORY

Arguments:
    DIRECTORY                   Existing BlobDir dataset directory.

Options:
    --param STRING            String of type param=value.
    --query-string STRING     List of param=value pairs from url query string.
    --json JSON               JSON format list file as generated by BlobtoolKit Viewer.
    --list TXT                Space or newline separated list of identifiers.
    --invert                  Invert filter (exclude matching records).
    --output DIRECTORY        Path to directory to generate a new, filtered BlobDir.
    --fasta FASTA             FASTA format assembly file to be filtered.
    --fastq FASTQ             FASTQ format read file to be filtered (requires --cov).
    --cov BAM                 BAM/SAM/CRAM read alignment file.
    --text TXT                generic text file to be filtered.
    --text-delimiter STRING   text file delimiter. [Default: whitespace]
    --text-id-column INT      index of column containing identifiers (1-based). [Default: 1]
    --text-header             Flag to indicate first row of text file contains field names. [Default: False]
    --suffix STRING           String to be added to filtered filename. [Default: filtered]
    --summary FILENAME        Generate a JSON-format summary of the filtered dataset.
    --summary-rank RANK       Taxonomic level for summary. [Default: phylum]
    --table FILENAME          Tabular output of filtered dataset.
    --table-fields STRING     Comma separated list of field IDs to include in the
                              table output. Use 'plot' to include all plot axes.
                              [Default: plot]
    --taxdump DIRECTORY       Location of NCBI new_taxdump directory.
    --taxrule STRING          Taxrule used when processing hits.
```

## blobtoolkit_remove

### Tool Description
Remove fields from a BlobDir.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/blobtoolkit/blobtoolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Total Downloads**: 641
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/blobtoolkit/blobtoolkit
- **Stars**: N/A
### Original Help Text
```text
Remove fields from a BlobDir.

Usage:
    blobtools remove [--all] [--busco] [--cov] [--fasta] [--field STRING...] [--hits]
                     DIRECTORY

Arguments:
    DIRECTORY             Existing Blob directory.

Options:
    --all             Remove all fields except identifiers.
    --busco           Remove all BUSCO fields.
    --cov             Remove all cov and read_cov fields.
    --fasta           Remove gc, length and ncount fields.
    --field STRING    Remove fields by ID.
    --hits            Remove all taxonomy fields.

Examples:
    # 1. Remove BUSCO and ncount fields from a BlobDir
    blobtools remove --busco --field ncount BlobDir
```

## blobtoolkit_replace

### Tool Description
Call blobtools add with --replace flag.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/blobtoolkit/blobtoolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Total Downloads**: 641
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/blobtoolkit/blobtoolkit
- **Stars**: N/A
### Original Help Text
```text
Add data to a BlobDir.

Usage:
    blobtools add [--bed BED...] [--beddir DIRECTORY] [--bedtsv TSV...] [--bedtsvdir DIRECTORY]
                  [--busco TSV...] [--cov BAM...] [--hits TSV...] [--fasta FASTA] [--hits-cols LIST]
                  [--key path=value...] [--link path=url...] [--taxid INT] [--skip-link-test]
                  [--blobdb JSON] [--meta YAML] [--synonyms TSV...] [--trnascan TSV...]
                  [--text TXT...] [--text-delimiter STRING] [--text-cols LIST] [--text-header]
                  [--text-no-array] [--taxdump DIRECTORY] [--taxrule bestsum|bestsumorder[=prefix]]
                  [--threads INT] [--evalue NUMBER] [--bitscore NUMBER] [--hit-count INT]
                  [--update-plot] [--pileup-args key=value...] [--create] [--replace] DIRECTORY

Arguments:
    DIRECTORY             Existing Blob directory.

Options:
    --bed BED             BED format file.
    --beddir DIRECTORY    Directory containing one or more BED format files.
    --bedtsv TSV          TSV file with header row and bed-format columns 1-3.
    --bedtsvdir DIRECTORY Directory containing one or more BED-like tsv files.
    --busco TSV           BUSCO full_table.tsv output file.
    --cov BAM             BAM/SAM/CRAM read alignment file.
    --fasta FASTA         FASTA sequence file.
    --hits TSV            Tabular BLAST/Diamond output file.
    --hits-cols LIST      Comma separated list of <column number>=<field name>.
                          [Default: 1=qseqid,2=staxids,3=bitscore,5=sseqid,10=qstart,11=qend,14=evalue]
    --taxid INT           Add ranks to metadata for a taxid.
    --key path=value      Set a metadata key to value.
    --link path=URL       Link to an external resource.
    --skip-link-test      Skip test to see if link URL can be resolved.
    --meta YAML           Dataset metadata.
    --blobdb JSON         Blobtools v1 blobDB.
    --synonyms TSV        TSV file containing current identifiers and synonyms.
    --taxdump DIRECTORY   Location of NCBI new_taxdump directory.
    --taxrule rulename[=prefix]
                          Rule to use when assigning BLAST hits to taxa (bestsum, bestsumorder,
                          bestdistsum, bestdistsumorder, blastp).
                          An alternate prefix may be specified. [Default: bestsumorder]
    --threads INT         Number of threads to use for multithreaded tasks. [Default: 1]
    --evalue FLOAT        Set evalue cutoff when parsing hits file. [Default: 1]
    --bitscore FLOAT      Set bitscore cutoff when parsing hits file. [Default: 1]
    --hit-count INT       Number of hits to parse when inferring taxonomy. [Default: 10]
    --update-plot         Flag to use new taxrule as default category.
    --text TXT            Generic text file.
    --text-delimiter STRING
                          Text file delimiter. [Default: whitespace]
    --text-cols LIST      Comma separated list of <column number>[=<field name>].
    --text-header         Flag to indicate first row of text file contains field names.
    --text-no-array       Flag to prevent fields in files with duplicate identifiers being
                          loaded as array fields.
    --trnascan TSV        tRNAscan2-SE output
    --pileup-args key=val Key/value pairs to pass to samtools pileup.
    --create              Create a new BlobDir.
    --replace             Replace existing fields with matching ids.

Examples:
    # 1. Add BUSCO scores to BlobDir
    blobtools add --busco busco.full_table.tsv BlobDir
```

## blobtoolkit_validate

### Tool Description
Validate a BlobDir.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/blobtoolkit/blobtoolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Total Downloads**: 641
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/blobtoolkit/blobtoolkit
- **Stars**: N/A
### Original Help Text
```text
Validate a BlobDir.

Usage:
    blobtools validate [--basic] [--example] DIRECTORY

Arguments:
    DIRECTORY             BlobDir directory.

Options:
    --basic    Only require basic metadata.
    --example  Validate example dataset.
```

## blobtoolkit_view

### Tool Description
Generate plots using BlobToolKit Viewer.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/blobtoolkit/blobtoolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Total Downloads**: 641
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/blobtoolkit/blobtoolkit
- **Stars**: N/A
### Original Help Text
```text
Generate plots using BlobToolKit Viewer.

Usage:
  blobtools view [--format STRING...] [--host STRING] [--interactive]
  [--out PATH] [--param STRING...] [--ports RANGE] [--prefix STRING]
  [--preview STRING...] [--driver STRING] [--driver-log PATH]
  [--local] [--remote] [--plot] [--timeout INT] [--view STRING...] DIRECTORY

Options:
      --format STRING         Image format (svg|png). [Default: png]
      --host STRING           Hostname. [Default: http://localhost]
      --interactive           Start interactive session (opens dataset in Firefox/Chromium). [Default: False]
      --out PATH              Directory for outfiles. [Default: .]
      --param key=value       Query string parameter.
      --ports RANGE           Port range for viewer and API. [Default: 8000-8099]
      --prefix STRING         URL prefix. [Default: view]
      --preview STRING        Field name.
      --driver STRING         Webdriver to use (chromium or firefox). [Default: firefox]
      --driver-log PATH       Path to driver logfile for debugging. [Default: /dev/null]
      --local                 Start viewer for local session. [Default: False]
      --remote                Start viewer for remote session. [Default: False]
      --plot                  Use blobtk plot to generate plots. [Default: False]
      --timeout INT           Time to wait for page load in seconds. Default (0) is no timeout. [Default: 0]
      --view STRING           Plot type (blob|cumulative|snail). [Default: blob]

Examples:
    # 1. Create a snail plot:
    blobtools view --plot --view snail /path/to/BlobDir

    # 2. Start an interactive session:
    blobtools view --interactive /path/to/BlobDir

    # 3. Start an remote session:
    blobtools view --remote /path/to/BlobDir
```

