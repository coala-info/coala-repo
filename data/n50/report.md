# n50 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| n50 | PASS | ran on 4 real nf-core files (SARS-CoV-2 and human genome FASTA, Illumina and nanopore FASTQ); N50, lengths and counts match an independent calculation |
| n50_binner | PASS | new CWL; nanopore test reads binned: 97 reads up to 1000 bp, 3 up to 2500 bp, as in the file |
| n50_countfx | PASS | new CWL; counted 100 Illumina reads |
| n50_fac | PASS | new CWL; counted 1 sequence in the SARS-CoV-2 genome |
| n50_fqc | PASS | new CWL; counted 100 Illumina reads from the gzip file |
| n50_gen | PASS | new CWL; wrote 2 FASTA files with 5 and 6 sequences; names match N50_count_length |
| n50_generate | Failed | new CWL; tool bug: segfault (exit 139) on the documented length,count CSV, and -f passes --FASTA/--FASTQ to n50_simreads which rejects it |
| n50_simreads | PASS | new CWL; made 5 reads (3x100, 2x50); FASTQ lengths match |
| n50_simseqs | PASS | new CWL; made 5 sequences (3x100, 2x50); file names and lengths match |
| n50_single | PASS | new CWL; header mode and N50-only mode match n50 results |

## n50

### Tool Description
Calculate sequence statistics (N50, GC%, length stats) for FASTA/FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: http://metacpan.org/pod/Proch::N50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Total Downloads**: 108.2K
- **Last updated**: 2025-07-08
- **GitHub**: https://github.com/quadram-institute-bioscience/n50
- **Stars**: N/A
### Original Help Text
```text
Usage: n50 [options] FILES...

Calculate sequence statistics (N50, GC%, length stats) for FASTA/FASTQ files.

Arguments:
  FILES           One or more FASTA/FASTQ files, gzipped or not. '-' for STDIN.

Options:
  -a, --abs       Print file paths as absolute paths
  -b, --basename  Print file paths as basename only (e.g., file.fq.gz)
  -j, --json      Output results in JSON format
  -c, --csv       Output results in CSV format (default is TSV)
  -n, --nice      Output results in a visually aligned ASCII table
  -h, --help      Show this help message and exit
  -v, --version   Show version number and exit

Output Columns (TSV/CSV):
  Filepath, TotSeqs, TotLen, N50, N75, N90, I50, GC, Avg, Min, Max, AuN
```

## n50_simseqs

### Tool Description
Simulate sequences with the desired lengths (ARGS are COUNT*SIZE pairs).

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: https://github.com/quadram-institute-bioscience/n50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: n50_simseqs [--fasta|--fastq] -o OUTDIR [-p PREFIX] ARGS
ARGS format: COUNT*SIZE
  --version  Show version number and exit
```

## n50_simreads

### Tool Description
Simulate reads with the desired lengths (ARGS are COUNT*SIZE pairs).

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: https://github.com/quadram-institute-bioscience/n50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: n50_simreads [--fasta|--fastq] -o OUTDIR [-p PREFIX] ARGS
ARGS format: COUNT*SIZE
```

## n50_binner

### Tool Description
Count the reads of a FASTQ file in 16 predefined length bins and print a CSV table (Bin,Number of Reads).

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: https://github.com/quadram-institute-bioscience/n50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: n50_binner <fastq_file>
```

## n50_generate

### Tool Description
Generate reads with n50_simreads from a read length distribution (CSV with a length,count header, as made by n50_binner).

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: https://github.com/quadram-institute-bioscience/n50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Input file and output directory are required.
Usage: n50_generate -i INPUTFILE -o OUTDIR [-f FORMAT] [-s PATH]
  -i INPUTFILE   Input file path
  -o OUTDIR      Output directory
  -f FORMAT      Optional: Output format (FASTQ by default, FASTA also supported)
  -s PATH        Optional: Path to n50_simreads executable
```

## n50_single

### Tool Description
Print the N50 or the total length, number of sequences and N50 of a single FASTA or FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: https://github.com/quadram-institute-bioscience/n50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: n50_single [--fasta | --fastq] [--header] [--n50] [filename]
```

## n50_countfx

### Tool Description
Count the sequences of a FASTA or FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: https://github.com/quadram-institute-bioscience/n50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

### Original Help Text
```text
Error: No input file specified
Usage: countfx [options] <file>
Options:
  --fasta    Force FASTA format
  --fastq    Force FASTQ format
  -h, --help Show this help message

File format detection:
  .fq, .fq.gz, .fastq, .fastq.gz -> FASTQ
  All other extensions -> FASTA
```

## n50_fqc

### Tool Description
Count the sequences of a gzip compressed FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: https://github.com/quadram-institute-bioscience/n50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fqc <fastq.gz file> [num_threads]
```

## n50_fac

### Tool Description
Count the sequences of a gzip compressed FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: https://github.com/quadram-institute-bioscience/n50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fac [--chunk-size N] <fasta.gz file>
```

## n50_gen

### Tool Description
Generate random DNA sequences in FASTA or FASTQ files with varying lengths; file names contain N50, number of sequences and total length.

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: https://github.com/quadram-institute-bioscience/n50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gen <min_seqs> <max_seqs> <min_len> <max_len> <tot_files> <format> <outdir>
```

