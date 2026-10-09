# kraken CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kraken | PASS | ran on nf-core SARS-CoV-2 reads with the nf-core KrakenUniq test database (Kraken 1 format); all 100 reads classified as taxid 2697049, same as the Kraken2 output; paired and quick modes also work; database is now a Directory input |
| kraken_build | Failed | image problem: kraken-build stops with 'Can't locate Getopt/Std.pm' (Perl module missing in the image) |
| kraken_filter | PASS | new CWL; threshold 0.8 turned low-confidence reads into unclassified lines with P scores; same database files as kraken_report |
| kraken_mpa_report | PASS | new CWL; MetaPhlAn-style lineage lines with 100 reads at each rank, header line and intermediate ranks work; same database files as kraken_report |
| kraken_report | PASS | new CWL; ran on Kraken output of 100 SARS-CoV-2 reads: lineage counts match the Kraken2 report; database taxonomy names rebuilt from that report (synthetic taxonomy names), kdb/idx from the nf-core KrakenUniq test database |
| kraken_translate | PASS | new CWL; each read ID got its full lineage names; same database files as kraken_report |

## kraken

### Tool Description
Need to specify input filenames!

### Metadata
- **Docker Image**: biocontainers/kraken:v1.1-3-deb_cv1
- **Homepage**: http://ccb.jhu.edu/software/kraken/
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kraken/overview
- **Total Downloads**: 84.8K
- **Last updated**: 2025-09-30
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Need to specify input filenames!
Usage: kraken [options] <filename(s)>

Options:
  --db NAME               Name for Kraken DB
                          (default: none)
  --threads NUM           Number of threads (default: 1)
  --fasta-input           Input is FASTA format
  --fastq-input           Input is FASTQ format
  --fastq-output          Output in FASTQ format
  --gzip-compressed       Input is gzip compressed
  --bzip2-compressed      Input is bzip2 compressed
  --quick                 Quick operation (use first hit or hits)
  --min-hits NUM          In quick op., number of hits req'd for classification
                          NOTE: this is ignored if --quick is not specified
  --unclassified-out FILENAME
                          Print unclassified sequences to filename
  --classified-out FILENAME
                          Print classified sequences to filename
  --out-fmt FORMAT        Format for [un]classified sequence output. supported 
                          options are: {legacy, paired, interleaved}
  --output FILENAME       Print output to filename (default: stdout); "-" will
                          suppress normal output
  --only-classified-output
                          Print no Kraken output for unclassified sequences
  --preload               Loads DB into memory before classification
  --paired                The two filenames provided are paired-end reads
  --check-names           Ensure each pair of reads have names that agree
                          with each other; ignored if --paired is not specified
  --help                  Print this message
  --version               Print version information

If none of the *-input or *-compressed flags are specified, and the 
file is a regular file, automatic format detection is attempted.
```

## kraken_build

### Tool Description
Build a Kraken database. Exactly one task option must be selected per call.

### Metadata
- **Docker Image**: biocontainers/kraken:v1.1-3-deb_cv1
- **Homepage**: http://ccb.jhu.edu/software/kraken/
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kraken-build [task option] [options]

Task options (exactly one must be selected):
  --download-taxonomy        Download NCBI taxonomic information
  --download-library TYPE    Download partial library
                             (TYPE = one of "archaea", "bacteria", "plasmid", 
                             "viral", "human")
  --add-to-library FILE      Add FILE to library
  --build                    Create DB from library
                             (requires taxonomy d/l'ed and at least one file
                             in library)
  --rebuild                  Create DB from library like --build, but remove
                             existing non-library/taxonomy files before build
  --clean                    Remove unneeded files from a built database
  --shrink NEW_CT            Shrink an existing DB to have only NEW_CT k-mers
  --standard                 Download and create default database
  --upgrade                  Upgrade an existing older database to use scrambled
                             minimizer ordering (see README for details)
  --help                     Print this message
  --version                  Print version information

Options:
  --db NAME                  Kraken DB/library name (mandatory except for
                             --help/--version)
  --threads #                Number of threads (def: 1)
  --new-db NAME              New Kraken DB name (shrink task only; mandatory
                             for shrink task)
  --kmer-len NUM             K-mer length in bp (build/shrink tasks only;
                             def: 31)
  --minimizer-len NUM        Minimizer length in bp (build/shrink tasks only;
                             def: 15)
  --jellyfish-hash-size STR  Pass a specific hash size argument to jellyfish
                             when building database (build task only)
  --max-db-size SIZE         Shrink the DB before full build, making sure
                             database and index together use <= SIZE gigabytes
                             (build task only)
  --shrink-block-offset NUM  When shrinking, select the k-mer that is NUM
                             positions from the end of a block of k-mers
                             (default: 1)
  --work-on-disk             Perform most operations on disk rather than in
                             RAM (will slow down build in most cases)
```

## kraken_filter

### Tool Description
Filter Kraken classifications: reads whose confidence score is below the threshold are moved to a higher taxon.

### Metadata
- **Docker Image**: biocontainers/kraken:v1.1-3-deb_cv1
- **Homepage**: http://ccb.jhu.edu/software/kraken/
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kraken-filter [--db KRAKEN_DB_NAME] [--threshold NUM] <kraken output file(s)>
```

## kraken_report

### Tool Description
Create a Kraken report (percent, clade and taxon read counts per taxon) from Kraken output files.

### Metadata
- **Docker Image**: biocontainers/kraken:v1.1-3-deb_cv1
- **Homepage**: http://ccb.jhu.edu/software/kraken/
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kraken-report [--db KRAKEN_DB_NAME] [--show-zeros] <kraken output file(s)>
```

## kraken_mpa_report

### Tool Description
Create a MetaPhlAn-style report (lineage and read count per taxon) from Kraken output files.

### Metadata
- **Docker Image**: biocontainers/kraken:v1.1-3-deb_cv1
- **Homepage**: http://ccb.jhu.edu/software/kraken/
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kraken-mpa-report [--db KRAKEN_DB_NAME] [options] <kraken output file(s)>

Options:
  --db NAME             Name of Kraken database
                        (default: none)
  --show-zeros          Display taxa even if they lack a read in any sample
  --header-line         Display a header line indicating sample IDs
                        (sample IDs are the filenames)
  --intermediate-ranks  Display taxa not at the standard ranks with x__ prefix
```

## kraken_translate

### Tool Description
Translate the taxon IDs in Kraken output files into taxon names or full lineages.

### Metadata
- **Docker Image**: biocontainers/kraken:v1.1-3-deb_cv1
- **Homepage**: http://ccb.jhu.edu/software/kraken/
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kraken-translate [--db KRAKEN_DB_NAME] [--mpa-format] <kraken output file(s)>
```
