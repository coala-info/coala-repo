# mehari CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mehari_annotate_seqvars | PASS |  |
| mehari_annotate_strucvars | PASS |  |
| mehari_db_check | Not completed | needs HGNC JSON, disease-gene, known-issue and ClinVar count tables that are not available as small test files. |
| mehari_db_create | PASS |  |
| mehari_db_dump | PASS |  |
| mehari_db_merge | PASS |  |
| mehari_db_subset | PASS |  |
| mehari_verify_seqvars | Not completed | needs a full genome reference FASTA and VEP output for the matching database; no small real input available. |

## mehari_annotate_seqvars

### Tool Description
Annotate sequence variant VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
- **Homepage**: https://github.com/varfish-org/mehari
- **Package**: https://anaconda.org/channels/bioconda/packages/mehari/overview
- **Validation**: PASS

### Original Help Text
```text
Annotate sequence variant VCF files

Usage: mehari annotate seqvars [OPTIONS] --path-input-vcf <PATH_INPUT_VCF> <--path-output-vcf <PATH_OUTPUT_VCF>|--path-output-tsv <PATH_OUTPUT_TSV>> <--transcripts <TRANSCRIPTS>|--frequencies <FREQUENCIES>|--clinvar <CLINVAR>>

Options:
      --genome-release <GENOME_RELEASE>
          Genome release to use, default is to auto-detect [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
  -q, --quiet...
          Decrease logging verbosity
      --reference <REFERENCE>
          Reference genome FASTA file (with accompanying index)
      --in-memory-reference
          Read the reference genome into memory
      --path-input-ped <PATH_INPUT_PED>
          Path to the input PED file
      --path-input-vcf <PATH_INPUT_VCF>
          Path to the input VCF file
      --path-output-vcf <PATH_OUTPUT_VCF>
          Path to the output VCF file
      --path-output-tsv <PATH_OUTPUT_TSV>
          Path to the output TSV file (for import into VarFish)
      --max-var-count <MAX_VAR_COUNT>
          For debug purposes, maximal number of variants to annotate
      --hgnc <HGNC>
          Path to HGNC TSV file
      --transcripts <TRANSCRIPTS>
          Transcript database containing the transcript information
      --frequencies <FREQUENCIES>
          Frequency database
      --clinvar <CLINVAR>
          ClinVar database
      --transcript-source <TRANSCRIPT_SOURCE>
          The transcript source [default: both] [possible values: ensembl, ref-seq, both]
      --report-most-severe-consequence-by <REPORT_MOST_SEVERE_CONSEQUENCE_BY>
          Whether to report only the most severe consequence, grouped by gene, transcript, or allele [possible values: gene, transcript, allele]
      --pick-transcript <PICK_TRANSCRIPT>
          Which kind of transcript to pick / restrict to. Default is not to pick at all [possible values: mane-select, mane-select-backport, mane-plus-clinical, mane-plus-clinical-backport, length, ensembl-canonical, ensembl-canonical-backport, ref-seq-select, ref-seq-select-backport, gencode-primary, gencode-primary-backport, basic, basic-backport]
      --pick-transcript-mode <PICK_TRANSCRIPT_MODE>
          Determines how to handle multiple transcripts. Default is to keep all [default: all] [possible values: first, all]
      --keep-intergenic
          Whether to keep intergenic variants
      --discard-utr-splice-variants
          Whether to report splice variants in UTRs
      --tsv-contig-style <TSV_CONTIG_STYLE>
          Style for contig names in TSV output [default: auto] [possible values: passthrough, with-chr, without-chr, auto]
  -h, --help
          Print help (see more with '--help')
```

## mehari_annotate_strucvars

### Tool Description
Annotate structural variant VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
- **Homepage**: https://github.com/varfish-org/mehari
- **Package**: https://anaconda.org/channels/bioconda/packages/mehari/overview
- **Validation**: PASS

### Original Help Text
```text
Annotate structural variant VCF files

Usage: mehari annotate strucvars [OPTIONS] --path-input-ped <PATH_INPUT_PED> --path-input-vcf <PATH_INPUT_VCF> <--path-output-vcf <PATH_OUTPUT_VCF>|--path-output-tsv <PATH_OUTPUT_TSV>>

Options:
      --genome-release <GENOME_RELEASE>
          Genome release to use, default is to auto-detect [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-input-ped <PATH_INPUT_PED>
          Path to the input PED file
  -q, --quiet...
          Decrease logging verbosity
      --path-input-vcf <PATH_INPUT_VCF>
          Path to the input VCF files
      --path-output-vcf <PATH_OUTPUT_VCF>
          Path to the output VCF file
      --path-output-tsv <PATH_OUTPUT_TSV>
          Path to the output TSV file (for import into VarFish)
      --max-var-count <MAX_VAR_COUNT>
          For debug purposes, maximal number of variants to annotate
      --path-cov-vcf <PATH_COV_VCF>
          Paths to the per-sample VCF files with coverage and mapping quality information as generated by maelstrom-core
      --min-overlap <MIN_OVERLAP>
          Minimal reciprocal overlap to require [default: 0.8]
      --slack-bnd <SLACK_BND>
          Slack to use around break-ends [default: 50]
      --slack-ins <SLACK_INS>
          Slack to use around insertions [default: 50]
      --rng-seed <RNG_SEED>
          Seed for random number generator (UUIDs), if any
      --file-date <FILE_DATE>
          Optionally, value to write to `##fileDate`
      --tsv-contig-style <TSV_CONTIG_STYLE>
          Style for contig names in TSV output [default: auto] [possible values: passthrough, with-chr, without-chr, auto]
  -h, --help
          Print help (see more with '--help')
```

## mehari_db_create

### Tool Description
Construct mehari transcripts and sequence database

### Metadata
- **Docker Image**: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
- **Homepage**: https://github.com/varfish-org/mehari
- **Package**: https://anaconda.org/channels/bioconda/packages/mehari/overview
- **Validation**: PASS

### Original Help Text
```text
Construct mehari transcripts and sequence database

Usage: mehari db create [OPTIONS] --assembly <ASSEMBLY> --transcript-source <TRANSCRIPT_SOURCE> --cdot-version <CDOT_VERSION> --path-out <PATH_OUT> --path-cdot-json <PATH_CDOT_JSON> --path-seqrepo-instance <PATH_SEQREPO_INSTANCE>

Options:
      --assembly <ASSEMBLY>
          Targeted genome assembly to extract transcripts for [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --assembly-version <ASSEMBLY_VERSION>
          Version of the genome assembly, e.g. "GRCh37.p13"
  -q, --quiet...
          Decrease logging verbosity
      --transcript-source <TRANSCRIPT_SOURCE>
          Source of the transcripts. RefSeq, Ensembl, or Other [possible values: refseq, ensembl, other]
      --transcript-source-version <TRANSCRIPT_SOURCE_VERSION>
          Version of the transcript source. E.g. "112" for Ensembl
      --cdot-version <CDOT_VERSION>
          Version of cdot data
      --path-out <PATH_OUT>
          Path to output protobuf file to write to
      --path-cdot-json <PATH_CDOT_JSON>
          Paths to the cdot JSON transcripts to import
      --path-seqrepo-instance <PATH_SEQREPO_INSTANCE>
          Path to the seqrepo instance directory to use
      --path-mane-txs-tsv <PATH_MANE_TXS_TSV>
          Path to TSV file for label transfer of transcripts.  Columns are transcript id (without version), (unused) gene symbol, and label
      --max-txs <MAX_TXS>
          Maximal number of transcripts to process. DEPRECATED
      --gene-symbols <GENE_SYMBOLS>
          Limit transcript database to the following HGNC symbols.  Useful for building test databases
      --threads <THREADS>
          Number of threads to use for steps supporting parallel processing [default: 1]
      --compression-level <COMPRESSION_LEVEL>
          ZSTD compression level to use [default: 19]
  -h, --help
          Print help (see more with '--help')
```

## mehari_db_check

### Tool Description
Check transcript database

### Metadata
- **Docker Image**: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
- **Homepage**: https://github.com/varfish-org/mehari
- **Package**: https://anaconda.org/channels/bioconda/packages/mehari/overview
- **Validation**: PASS

### Original Help Text
```text
Check transcript database

Usage: mehari db check [OPTIONS] --db <DB> --cdot <CDOT> --hgnc <HGNC> --disease-genes <DISEASE_GENES> --known-issues <KNOWN_ISSUES> --clinvar-hgnc-counts <CLINVAR_HGNC_COUNTS> --clinvar-tx-acc-counts <CLINVAR_TX_ACC_COUNTS> --output <OUTPUT>

Options:
      --db <DB>
          Path to the transcript database file to check
  -v, --verbose...
          Increase logging verbosity
      --cdot <CDOT>
          Paths to the cdot JSON files to check against
  -q, --quiet...
          Decrease logging verbosity
      --hgnc <HGNC>
          Path to the HGNC JSON file to check against
      --disease-genes <DISEASE_GENES>
          Path to the disease gene TSV file to check against
      --known-issues <KNOWN_ISSUES>
          Path to the known issues TSV
      --clinvar-hgnc-counts <CLINVAR_HGNC_COUNTS>
          Path to hgncId → count mapping
      --clinvar-tx-acc-counts <CLINVAR_TX_ACC_COUNTS>
          Path to txAcc → count mapping
      --output <OUTPUT>
          Path to the output TSV file
  -h, --help
          Print help
```

## mehari_db_dump

### Tool Description
Dump transcript database

### Metadata
- **Docker Image**: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
- **Homepage**: https://github.com/varfish-org/mehari
- **Package**: https://anaconda.org/channels/bioconda/packages/mehari/overview
- **Validation**: PASS

### Original Help Text
```text
Dump transcript database

Usage: mehari db dump [OPTIONS] --path-db <PATH_DB>

Options:
      --path-db <PATH_DB>  Path to database file to dump
  -v, --verbose...         Increase logging verbosity
  -q, --quiet...           Decrease logging verbosity
  -h, --help               Print help
```

## mehari_db_merge

### Tool Description
Merge two or more mehari transcript databases

### Metadata
- **Docker Image**: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
- **Homepage**: https://github.com/varfish-org/mehari
- **Package**: https://anaconda.org/channels/bioconda/packages/mehari/overview
- **Validation**: PASS

### Original Help Text
```text
Merge two or more mehari transcript databases

Usage: mehari db merge [OPTIONS] --database <DATABASE> --output <OUTPUT>

Options:
      --database <DATABASE>
          The input transcript databases to merge
  -v, --verbose...
          Increase logging verbosity
      --output <OUTPUT>
          Output file to write the merged transcript database to
  -q, --quiet...
          Decrease logging verbosity
      --compression-level <COMPRESSION_LEVEL>
          ZSTD compression level to use [default: 19]
  -h, --help
          Print help
```

## mehari_db_subset

### Tool Description
Subset transcript database

### Metadata
- **Docker Image**: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
- **Homepage**: https://github.com/varfish-org/mehari
- **Package**: https://anaconda.org/channels/bioconda/packages/mehari/overview
- **Validation**: PASS

### Original Help Text
```text
Subset transcript database

Usage: mehari db subset [OPTIONS] --path-in <PATH_IN> --path-out <PATH_OUT> <--vcf <VCF>|--hgnc-id <HGNC_ID>|--transcript-id <TRANSCRIPT_ID>>

Options:
      --path-in <PATH_IN>              Path to database file to read from
  -v, --verbose...                     Increase logging verbosity
      --path-out <PATH_OUT>            Path to output file to write to
  -q, --quiet...                       Decrease logging verbosity
      --vcf <VCF>                      Limit transcript database to the transcripts affected by the variants described in the specified VCF file
      --hgnc-id <HGNC_ID>              Limit transcript database to the specified HGNC ID. Can be specified multiple times
      --transcript-id <TRANSCRIPT_ID>  Limit transcript database to the specified transcript ID. Can be specified multiple times
  -h, --help                           Print help
```

## mehari_verify_seqvars

### Tool Description
Compare variant effect predictions to VEP ones

### Metadata
- **Docker Image**: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
- **Homepage**: https://github.com/varfish-org/mehari
- **Package**: https://anaconda.org/channels/bioconda/packages/mehari/overview
- **Validation**: PASS

### Original Help Text
```text
Compare variant effect predictions to VEP ones

Usage: mehari verify seqvars [OPTIONS] --path-db <PATH_DB> --path-input-tsv <PATH_INPUT_TSV> --path-reference-fasta <PATH_REFERENCE_FASTA> --path-output-tsv <PATH_OUTPUT_TSV>

Options:
      --path-db <PATH_DB>
          Path to the mehari database folder
  -v, --verbose...
          Increase logging verbosity
      --path-input-tsv <PATH_INPUT_TSV>
          Path to the input TSV file
  -q, --quiet...
          Decrease logging verbosity
      --path-reference-fasta <PATH_REFERENCE_FASTA>
          Path to the reference FASTA file
      --in-memory-reference
          Read the reference genome into memory
      --path-output-tsv <PATH_OUTPUT_TSV>
          Path to output TSV file
      --report-most-severe-consequence-by <REPORT_MOST_SEVERE_CONSEQUENCE_BY>
          Whether to report only the worst consequence for each picked transcript [possible values: gene, transcript, allele]
      --pick-transcript <PICK_TRANSCRIPT>
          Which kind of transcript to pick / restrict to. Default is not to pick at all [possible values: mane-select, mane-select-backport, mane-plus-clinical, mane-plus-clinical-backport, length, ensembl-canonical, ensembl-canonical-backport, ref-seq-select, ref-seq-select-backport, gencode-primary, gencode-primary-backport, basic, basic-backport]
      --pick-transcript-mode <PICK_TRANSCRIPT_MODE>
          Determines how to handle multiple transcripts. Default is to keep all [default: all] [possible values: first, all]
      --max-var-count <MAX_VAR_COUNT>
          For debug purposes, maximal number of variants to annotate
  -h, --help
          Print help (see more with '--help')
```

## Metadata
- **Skill**: generated
