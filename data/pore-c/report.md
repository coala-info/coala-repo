# pore-c CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pore-c_alignments_assign-consensus-haplotype | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_alignments_assign-fragments | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_alignments_create-table | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_alignments_filter-bam | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_alignments_reformat-bam | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_alignments_to-contacts | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_contacts_downsample | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_contacts_export | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_contacts_merge | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_contacts_summarize | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_reads_prepare | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_refgenome_fragments-to-hicref | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_refgenome_prepare | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_refgenome_virtual-digest | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |
| pore-c_utils_parquet-to-csv | PASS | ran on the real Pore-C test data from the tool repo; output files match the tool tests |

## pore-c_alignments_assign-consensus-haplotype

### Tool Description
Calculate a per-read consensus haplotype for each phase set in the pore-C table and write the result to a new table.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c alignments assign-consensus-haplotype [OPTIONS] PORE_C_TABLE
                                                    OUTPUT_PORE_C_TABLE

  Calculate a per-read consensus haplotype for each phase_set in ALIGN_TABLE
  and write the results back to OUTPUT_ALIGN_TABLE

Options:
  --threshold FLOAT  major:minor haplotype fraction must be greater than this
                     value to assign a consensus  [default: 0.8]

  --help             Show this message and exit.
```

## pore-c_alignments_assign-fragments

### Tool Description
For each alignment in the alignment table either filter it out or assign a fragment from the fragments table.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c alignments assign-fragments [OPTIONS] ALIGN_TABLE
                                          FRAGMENTS_TABLE PORE_C_TABLE

  For each alignment in ALIGN_TABLE either filter out or assign a fragment
  from FRAGMENT_TABLE

Options:
  --mapping_quality_cutoff INTEGER
                                  Minimum mapping quality for an alignment to
                                  be considered  [default: 1]

  --min_overlap_length INTEGER    Minimum overlap in base pairs between an
                                  alignment and restriction fragment
                                  [default: 10]

  --containment_cutoff FLOAT      Minimum percentage of a fragment included in
                                  an overlap for that fragment to be
                                  considered 'contained' within an alignment
                                  [default: 99.0]

  --help                          Show this message and exit.
```

## pore-c_alignments_create-table

### Tool Description
Convert a BAM file to a tabular format sorted by read for downstream analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c alignments create-table [OPTIONS] INPUT_BAM OUTPUT_TABLE

  Convert a BAM file to a tabular format sorted by read for downstream
  analysis

Options:
  --alignment-haplotypes PATH  The alignment to haplotype mapping from
                               whatshap

  --help                       Show this message and exit.
```

## pore-c_alignments_filter-bam

### Tool Description
Filter a BAM file using a pore-C table.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c alignments filter-bam [OPTIONS] INPUT_BAM PORE_C_TABLE
                                    OUTPUT_BAM

Options:
  --clean-read-name  Strip out the extra information placed in the BAM  by
                     reformat_bam

  --help             Show this message and exit.
```

## pore-c_alignments_reformat-bam

### Tool Description
Reformat query names of a SAM/BAM file so that each alignment has a unique name (read_id:read_idx:align_idx) and add a BX tag.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c alignments reformat-bam [OPTIONS] INPUT_SAM OUTPUT_SAM

  Reformat query_name in INPUT_SAM  and write to OUTPUT_SAM

  This tool reformats an alignment file so that it works with downstream
  steps in the Pore-C pipeline. For both files you can supply '-' if you
  want to read/write from/to stdin/stdout. The 'query_name' field of the
  alignment file will be reformatted so that each alignment in the SAM file
  has a unique query name:

      <read_id> -> <read_id>:<read_idx>:<align_idx>

  Where 'read_idx' is a unique integer id for each read within the file and
  'align_idx' is a unique integer id for each alignment within the file. The
  tool also adds a 'BX' tag consisting of the 'read_id' to each record.

Options:
  --input-is-bam   If piping a BAM from stdin (rather than sam)  [default:
                   False]

  --output-is-bam  If piping a BAM to stdout (rather than sam)  [default:
                   False]

  --set-bx-flag    Set the BX tag to the read name  [default: False]
  --help           Show this message and exit.
```

## pore-c_alignments_to-contacts

### Tool Description
Convert the alignment table to a pairwise contact table.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c alignments to-contacts [OPTIONS] PORE_C_TABLE CONTACT_TABLE

  Covert the alignment table to a pairwise contact table and associated
  concatemer table

Options:
  --help  Show this message and exit.
```

## pore-c_contacts_downsample

### Tool Description
Downsample a contact table.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c contacts downsample [OPTIONS] SRC_CONTACT_TABLE
                                  DEST_CONTACT_TABLE_PREFIX
                                  [DOWNSAMPLE_INCREMENTS]...

Options:
  --downsample-unit [Gb|Mb|Kb]
  --random-seed INTEGER
  --tol FLOAT                   Check if the difference between the sampled
                                amout and the target amount is greater than
                                this proportion

  --warn                        If the a sample fails the --tol check print a
                                warning rather than exiting

  --max-attempts INTEGER        The number of times to try and find a set of
                                subsamples all within --tol

  --help                        Show this message and exit.
```

## pore-c_contacts_export

### Tool Description
Export contacts to cooler, salsa_bed, paired_end_fastq, pairs or merged_no_dups formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c contacts export [OPTIONS] CONTACT_TABLE [cooler|salsa_bed|paired
                              _end_fastq|pairs|merged_no_dups] OUTPUT_PREFIX

  Export contacts to the following formats:

   - cooler: a sparse representation of a contact matrix  -
   paired_end_fastq: for each contact create a pseudo pair-end read using
   the reference genome sequence

Options:
  --min-mapping-quality INTEGER   Both alignments have mapping qualities
                                  greater than this  [default: 0]

  --min-align-base-qscore INTEGER
                                  Both alignments have mean base qualities
                                  greater than this  [default: 0]

  --cooler-resolution INTEGER     The bin width of the resulting matrix
                                  [default: 1000]

  --fragment-table TEXT           The fragment table for the corresponding
                                  virtual digest(required if export format is
                                  in cooler)

  --by-haplotype                  Create a cooler for each pair of haplotypes
                                  (eg 1-1, 1-2, 2-2,...). Only valid with
                                  'cooler'

  --chromsizes TEXT               The chromsizes file for the corresponding
                                  genome(required if export format is in
                                  cooler,pairs)

  --reference-fasta TEXT          The reference genome used to generate the
                                  contact table(required if export format is
                                  in paired_end_fastq,merged_no_dups)

  --help                          Show this message and exit.
```

## pore-c_contacts_merge

### Tool Description
Merge contact tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c contacts merge [OPTIONS] [SRC_CONTACT_TABLES]...
                             DEST_CONTACT_TABLE

Options:
  --fofn  If this flag is set then the SRC_CONTACT_TABLES is a file of
          filenames corresponding to the contact tables you want to merge.
          This is workaround for when the command line gets too long.

  --help  Show this message and exit.
```

## pore-c_contacts_summarize

### Tool Description
Summarise a contact table.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c contacts summarize [OPTIONS] CONTACT_TABLE READ_SUMMARY_TABLE
                                 CONCATEMER_TABLE CONCATEMER_SUMMARY_CSV

Options:
  --user-metadata TEXT  Add additional user metadata to the summary table,
                        must be a dictionary in json format

  --help                Show this message and exit.
```

## pore-c_reads_prepare

### Tool Description
Preprocess a set of reads for use with pore_c tools: filter by length and qscore, split into batches and write metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c reads prepare [OPTIONS] FASTQ OUTPUT_PREFIX

  Preprocess a set of reads for use with pore_c tools.

  This tool creates the following files:

      <output_prefix>.batch[batch_idx].fq.gz - Fastq with all the reads that pass the qscore and
        length filters. Fastqs are split so there are at most --batch-size reads per fastq
      <output_prefix>.fail.fq.gz - Reads that fail the filters
      <output_prefix>.read_metadata.parquet - Length and qscore metadata for each read and
        whether they pass the filter
      <output_prefix>.summary.csv - Summary stats for all/pass/fail reads
      <output_prefix>.catalog.yaml - An intake catalog

Options:
  --batch-size INTEGER       The reads will be split into batches of this size
                             for downstream processing  [default: 10000]

  --min-read-length INTEGER  The minimum length read to run through pore_c
                             [default: 1]

  --max-read-length INTEGER  The maximum length read to run through pore_c.
                             Note that bwa mem can crash on very long reads
                             [default: 150000]

  --min-qscore INTEGER       The minimum read qscore  [default: 0]
  --max-qscore INTEGER       The maximum read qscore  [default: 266]
  --user-metadata TEXT       Additional user metadata to associate with this
                             run

  --help                     Show this message and exit.
```

## pore-c_refgenome_fragments-to-hicref

### Tool Description
Convert a *.fragments.parquet file to hicRef format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c refgenome fragments-to-hicref [OPTIONS] FRAGMENTS_PARQUET HICREF

  Convert a  *.fragments.parquet file to hicRef format

Options:
  --help  Show this message and exit.
```

## pore-c_refgenome_prepare

### Tool Description
Pre-process a reference genome for use by pore-C tools: writes a decompressed fasta, a chromsizes file, a metadata csv and an intake catalog.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c refgenome prepare [OPTIONS] REFERENCE_FASTA OUTPUT_PREFIX

  Pre-process a reference genome for use by pore-C tools.

  Prepare a reference genome or draft assembly use by pore-c tools. This
  tool creates the following files:      <output_prefix>.fa - A
  decompressed fasta file     <output_prefix>.chromsizes - A tab-separated
  list of chromosome lengths     <output_prefix>.metadata.csv - A csv with
  metadata about each of     <output_prefix>.catalog.yaml - An intake
  catalog of these files

Options:
  --genome-id TEXT  An ID for this genome assembly
  --help            Show this message and exit.
```

## pore-c_refgenome_virtual-digest

### Tool Description
Carry out a virtual digestion of the genome/assembly FASTA (enzyme, regex or fixed-width bins) and write the fragment table.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c refgenome virtual-digest [OPTIONS] FASTA CUT_ON OUTPUT_PREFIX

  Carry out a virtual digestion of the genome/assembly FASTA.

  The DIGEST_TYPE sets what type of value you can use for CUT_ON.

      ---------------------------------------------------------------------
      | digest_type |  cut_on           | notes                           |
      ---------------------------------------------------------------------
      | enzyme      | NlaIII            | Enzyme name is case sensitive   |
      | enzyme      | HindIII           |                                 |
      | regex       | (GAATTC|GCGGCCGC) | Two site EcoRI and NotI         |
      | regex       | RAATY             | Degenerate site ApoI            |
      | bin         | 50000             | Create equal-width bins of 50k  |
      | bin         | 50k               | Create equal-width bins of 50k  |
      =====================================================================

  This tool will create the following output files:

      <output_prefix>.fragments.parquet

        A table containing the coordinates and some metadata on each
        fragment

      <output_prefix>.digest_stats.csv

        Per chromosome/contig summary statistics

      <output_prefix>.catalog.yaml

        An intake catalog of the digest files

Options:
  --digest-type [enzyme|regex|bin]
                                  The type of digest you want to do
  -n, --n_workers INTEGER         The number of dask_workers to use  [default:
                                  1]

  --help                          Show this message and exit.
```

## pore-c_utils_parquet-to-csv

### Tool Description
Convert a parquet file to CSV.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pore_c utils parquet-to-csv [OPTIONS] INPUT_PARQUET OUTPUT_CSV

  Convert a parquet file to CSV

Options:
  --help  Show this message and exit.
```
