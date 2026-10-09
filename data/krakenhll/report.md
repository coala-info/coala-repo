# krakenhll CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| krakenhll | PASS | ran on nf-core SARS-CoV-2 reads with the nf-core KrakenUniq test database (same format); all 100 reads classified as taxid 2697049 with a full report; also right on a database built here; database is now a staged writable Directory because krakenhll writes database.kdb.counts into it |
| krakenhll_build | PASS | new CWL; built a 2-genome database (SARS-CoV-2 and Haemophilus influenzae, minimizer length 10) with add-to-library and build; reads and genome chunks classify to the right taxa; add-to-library exits 255 by design so 255 is a success code |
| krakenhll_extract_reads | PASS | new CWL; extracted the 100 SARS-CoV-2 reads for taxid 2697049 from single-end and paired-end files (FASTA output for pairs gives 200 records) |
| krakenhll_filter | PASS | new CWL; ran on KrakenHLL output of 100 reads and added P scores (all reads stay classified at threshold 0.8) |
| krakenhll_mpa_report | PASS | new CWL; MetaPhlAn-style lines with 100 reads at each rank (rank names empty because the nf-core test database has no names) |
| krakenhll_report | PASS | new CWL; report lists 100 classified reads along the lineage down to 2697049 (names empty because the nf-core test database has no names) |
| krakenhll_translate | PASS | new CWL; every read got its lineage and species name (ancestor names empty because the nf-core test database has no names) |

## krakenhll

### Tool Description
Classify sequences using KrakenHLL

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
- **Homepage**: https://github.com/fbreitwieser/krakenhll
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Total Downloads**: 26.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fbreitwieser/krakenhll
- **Stars**: N/A
### Original Help Text
```text
Need to specify input filenames!
Usage: krakenhll --report-file FILENAME [options] <filename(s)>

Options:
  --db NAME               Name for Kraken DB (default: none)
  --threads NUM           Number of threads (default: 1)
  --fasta-input           Input is FASTA format
  --fastq-input           Input is FASTQ format
  --gzip-compressed       Input is gzip compressed
  --bzip2-compressed      Input is bzip2 compressed
  --precision INT         Precision for unique k-mer counting, between 10 and 18 (default: 12)
  --quick                 Quick operation (use first hit or hits)
  --min-hits NUM          In quick op., number of hits req'd for classification
                          NOTE: this is ignored if --quick is not specified
  --unclassified-out FILENAME
                          Print unclassified sequences to filename
  --classified-out FILENAME
                          Print classified sequences to filename
  --output FILENAME       Print output to filename (default: stdout); "off" will
                          suppress normal output
  --only-classified-output
                          Print no Kraken output for unclassified sequences
  --preload               Loads DB into memory before classification
  --paired                The two filenames provided are paired-end reads
  --check-names           Ensure each pair of reads have names that agree
                          with each other; ignored if --paired is not specified
  --help                  Print this message
  --version               Print version information

Experimental:
  --uid-mapping           Map using UID database

If none of the *-input or *-compressed flags are specified, and the 
file is a regular file, automatic format detection is attempted.
```

## krakenhll_build

### Tool Description
Build a KrakenHLL database. Exactly one task option can be selected per call (default is build). The add-to-library task always ends with exit code 255 (the script ends with exit -1), so 255 is accepted.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
- **Homepage**: https://github.com/fbreitwieser/krakenhll
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: krakenhll-build [task option] [options]

Task options (exactly one can be selected -- default is build):
  --download-taxonomy        Download NCBI taxonomic information
  --download-library TYPE    Download partial library (TYPE = one of "refseq/bacteria", "refseq/archaea", "refseq/viral"). 
                             Use krakenhll-download for more options.
  --add-to-library FILE      Add FILE to library
  --build                    Create DB from library (requires taxonomy d/l'ed and at 
                             least one file in library)
  --rebuild                  Create DB from library like --build, but remove
                             existing non-library/taxonomy files before build
  --clean                    Remove unneeded files from a built database
  --shrink NEW_CT            Shrink an existing DB to have only NEW_CT k-mers
  --standard                 Download and create default database, which contains complete genomes 
                             for archaea, bacteria and viruses from RefSeq, as well as viral strains 
                             from NCBI. Specify --taxids-for-genomes and --taxids-for-sequences
                             separately, if desired.

  --help                     Print this message
  --version                  Print version information

Options:
  --db DBDIR                 Kraken DB directory (mandatory except for --help/--version)
  --threads #                Number of threads (def: 1)
  --new-db NAME              New Kraken DB name (shrink task only; mandatory
                             for shrink task)
  --kmer-len NUM             K-mer length in bp (build/shrink tasks only;
                             def: 31)
  --minimizer-len NUM        Minimizer length in bp (build/shrink tasks only;
                             def: 15)
  --jellyfish-hash-size STR  Pass a specific hash size argument to jellyfish
                             when building database (build task only)
  --jellyfish-bin STR        Use STR as Jellyfish 1 binary.
  --max-db-size SIZE         Shrink the DB before full build, making sure
                             database and index together use <= SIZE gigabytes
                             (build task only)
  --shrink-block-offset NUM  When shrinking, select the k-mer that is NUM
                             positions from the end of a block of k-mers
                             (default: 1)
  --lca-database             Build a LCA database (default yes)
  --no-lca-database          Do not build a LCA database
  --work-on-disk             Perform most operations on disk rather than in
                             RAM (will slow down build in most cases)
  --taxids-for-genomes       Add taxonomy IDs (starting with 1 billion) for genomes.
                             Only works with 3-column seqid2taxid map with third 
                             column being the name
  --taxids-for-sequences     Add taxonomy IDs for sequences, starting with 1 billion.
                             Can be useful to resolve classifications with multiple genomes
                             for one taxonomy ID.
  --library-dir DIR          Use DIR for reference sequences instead of DBDIR/library.
  --taxonomy-dir DIR         Use DIR for taxonomy instead of DBDIR/taxonomy.

Experimental:
  --uid-database             Build a UID database (default no)
```

## krakenhll_extract_reads

### Tool Description
Extract all reads from a FASTA/FASTQ file that were matched to the given taxa by KrakenHLL. Reads are written to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
- **Homepage**: https://github.com/fbreitwieser/krakenhll
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/krakenhll-extract-reads version [unknown] calling Getopt::Std::getopts (version 1.11 [paranoid]),
running under Perl version 5.22.0.

Usage: krakenhll-extract-reads [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -t
	Boolean (without arguments): -f -v -i -a -p

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]

krakenhll-extract-reads: Extract all reads from FASTQ file that are matched to a specied taxon by KrakenHLL

Usage: krakenhll-extract-reads [OPTIONS] <taxon> <kraken> <fasta/fastq>

<taxon>         taxonomy ID, possibly multiple separated by ','
<kraken>        kraken result file
<fasta/fastq>   fasta/fastq file, possibly gzipped

Options:
  -a  input is FASTA file (default: FASTQ)
  -f  output in FASTA format
  -i  invert: print all reads not matching taxon
  -t TAXDB Include children of taxonomy IDs, using TAXDB to find them
  -v  verbose
  -p  paired-end reads: use a '%' in fasta/q file name as placeholder for 1 and 2

Example:
    krakenhll-extract-reads -p 9606 result.kraken input_%.fq 
    outputs all reads of input_1.fq and input_2.fq that have the taxonomy ID 9606 to STDOUT.
```

## krakenhll_filter

### Tool Description
Filter KrakenHLL classifications: reads whose confidence score is below the threshold are moved to a higher taxon.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
- **Homepage**: https://github.com/fbreitwieser/krakenhll
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: krakenhll-filter [--db KRAKEN_DB_NAME] [--threshold NUM] <kraken output file(s)>

Threshold must be between 0 and 1.
```

## krakenhll_mpa_report

### Tool Description
Create a MetaPhlAn-style report (lineage and read count per taxon) from KrakenHLL output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
- **Homepage**: https://github.com/fbreitwieser/krakenhll
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: krakenhll-mpa-report [--db KRAKEN_DB_NAME] [options] <kraken output file(s)>

Options:
  --db NAME             Name of Kraken database
                        (default: none)
  --show-zeros          Display taxa even if they lack a read in any sample
  --header-line         Display a header line indicating sample IDs
                        (sample IDs are the filenames)
  --intermediate-ranks  Display taxa not at the standard ranks with x__ prefix
```

## krakenhll_report

### Tool Description
Create a report from raw KrakenHLL output (no k-mer counts or coverage). Use krakenhll --report-file for the full report.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
- **Homepage**: https://github.com/fbreitwieser/krakenhll
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: krakenhll-report --db KRAKEN_DB_NAME [OPTIONS] <kraken output file(s)>

OPTIONS:
  --show-zeros    Show full taxonomy table.
  --taxon-counts  Input files are in the format '<taxon ID><tab><count>' instead of Kraken output.
  --taxon-list    Input files is list of taxon IDs instead of Kraken output.
  -h              This message.
  
This script should only be used when post-processing raw KrakenHLL output, and k-mer counts and coverages are not needed. For most use-cases, krakenhll --report-file is better than krakenhll-report.
```

## krakenhll_translate

### Tool Description
Translate the taxon IDs in KrakenHLL output files into taxon names or full lineages.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
- **Homepage**: https://github.com/fbreitwieser/krakenhll
- **Package**: https://anaconda.org/channels/bioconda/packages/krakenhll/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: krakenhll-translate [--db KRAKEN_DB_NAME] [--mpa-format] <kraken output file(s)>
```
