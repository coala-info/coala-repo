# haplotype-lso CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| haplotype-lso_cli | Failed | image problem: pandas in the image has no DataFrame.append, so the run crashes with AttributeError after BLAST and before any report is written |
| haplotype-lso_convert | PASS | FASTA files converted and renamed from the file names |
| haplotype-lso_paste | Failed | tool bug: write_pasted loops over the result dictionary keys, so every run stops with TypeError (string indices must be integers) |
| haplotype-lso_ref_blast | PASS | NCBI WWW BLAST of one real seed returned 50 Liberibacter hits including the seed itself, same count as the file in the tool repository |
| haplotype-lso_ref_consensus | Failed | image problem: clustalw is not installed in the image, so the consensus step stops with FileNotFoundError: 'clustalw' |
| haplotype-lso_ref_download | PASS | downloaded seed FASTA matches the copy shipped in the tool repository |

## haplotype-lso_convert

### Tool Description
Convert sequence files (FASTA, FASTQ, AB1, SCF) into FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
- **Homepage**: https://github.com/holtgrewe/haplotype-lso
- **Package**: https://anaconda.org/channels/bioconda/packages/haplotype-lso/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hlso convert [-h] [--file-name-as-seq-name]
                    out_dir seq_files [seq_files ...]

positional arguments:
  out_dir               Path to output directory.
  seq_files

options:
  -h, --help            show this help message and exit
  --file-name-as-seq-name
                        Set file name to sample name
```

## haplotype-lso_cli

### Tool Description
Classify Lso Sanger reads: align to the reference sequences, compute identity and assign haplotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
- **Homepage**: https://github.com/holtgrewe/haplotype-lso
- **Package**: https://anaconda.org/channels/bioconda/packages/haplotype-lso/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hlso cli [-h] [--sample-name-from-file] [--sample-regex SAMPLE_REGEX]
                [-o OUTPUT]
                seq_files [seq_files ...]

positional arguments:
  seq_files

options:
  -h, --help            show this help message and exit
  --sample-name-from-file
                        Use sample name instead of file name
  --sample-regex SAMPLE_REGEX
                        Regular expression to match file name to sample name.
  -o OUTPUT, --output OUTPUT
                        Path to output file
```

## haplotype-lso_paste

### Tool Description
Prepare modified copies of the reference sequences by inserting BLAST matches into them.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
- **Homepage**: https://github.com/holtgrewe/haplotype-lso
- **Package**: https://anaconda.org/channels/bioconda/packages/haplotype-lso/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hlso paste [-h] [--keep-masked KEEP_MASKED] [-o OUTPUT_PREFIX]
                  seq_files [seq_files ...]

positional arguments:
  seq_files

options:
  -h, --help            show this help message and exit
  --keep-masked KEEP_MASKED
                        Keep masked reference sequence (mostly useful for
                        debugging purposes).
  -o OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        Prefix for output files
```

## haplotype-lso_ref_download

### Tool Description
Download the seed sequences and the reference sequences from NCBI (GenBank).

### Metadata
- **Docker Image**: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
- **Homepage**: https://github.com/holtgrewe/haplotype-lso
- **Package**: https://anaconda.org/channels/bioconda/packages/haplotype-lso/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hlso ref_download [-h] in_tsv out_tsv

positional arguments:
  in_tsv      Path to output TSV file.
  out_tsv     Path to output TSV file.

options:
  -h, --help  show this help message and exit
```

## haplotype-lso_ref_blast

### Tool Description
Run the seed sequences through NCBI WWW BLAST (blastn, nt).

### Metadata
- **Docker Image**: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
- **Homepage**: https://github.com/holtgrewe/haplotype-lso
- **Package**: https://anaconda.org/channels/bioconda/packages/haplotype-lso/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hlso ref_blast [-h] [--num-threads NUM_THREADS] in_tsv

positional arguments:
  in_tsv                Path to input TSV file.

options:
  -h, --help            show this help message and exit
  --num-threads NUM_THREADS
                        Number of parallel searches to run
```

## haplotype-lso_ref_consensus

### Tool Description
Build consensus sequences for the seeds and the haplotyping table.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
- **Homepage**: https://github.com/holtgrewe/haplotype-lso
- **Package**: https://anaconda.org/channels/bioconda/packages/haplotype-lso/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hlso ref_consensus [-h] [--verbose] [--max-errors MAX_ERRORS]
                          [--output-table OUTPUT_TABLE]
                          in_tsv

positional arguments:
  in_tsv                Path to output TSV file.

options:
  -h, --help            show this help message and exit
  --verbose             Enable verbose mode
  --max-errors MAX_ERRORS
                        Maximal number of mismatches to accept in seed
                        consensus computation
  --output-table OUTPUT_TABLE
                        Path to output haplotype table.
```

