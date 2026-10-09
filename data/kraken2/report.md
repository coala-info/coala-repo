# kraken2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kraken2 | PASS | ran on nf-core SARS-CoV-2 reads with the nf-core kraken2 test database; all 100 reads classified as taxid 2697049 and the report matches the nf-core one; also correct on a database built here; database is now a Directory input and --output flag fixed |
| kraken2_build | PASS | new CWL; built a 2-genome database (SARS-CoV-2 and Haemophilus influenzae) with add-to-library and build; reads and genome chunks classify to the right taxa (needed a newline added to the nf-core accession map) |
| kraken2_inspect | PASS | new CWL; inspect lists both species of the built database with sensible minimizer counts, and the nf-core database (9958 minimizers, one species) |

## kraken2

### Tool Description
Classify sequences using the Kraken 2 algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0
- **Homepage**: http://ccb.jhu.edu/software/kraken/
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kraken2/overview
- **Total Downloads**: 174.6K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/DerrickWood/kraken2
- **Stars**: N/A
### Original Help Text
```text
Need to specify input filenames!
Usage: kraken2 [options] <filename(s)>

Options:
  --db NAME               Name for Kraken 2 DB
                          (default: none)
  --threads NUM           Number of threads (default: 1)
  --quick                 Quick operation (use first hit or hits)
  --unclassified-out FILENAME
                          Print unclassified sequences to filename
  --classified-out FILENAME
                          Print classified sequences to filename
  --output FILENAME       Print output to filename (default: stdout); "-" will
                          suppress normal output
  --confidence FLOAT      Confidence score threshold (default: 0.0); must be
                          in [0, 1].
  --minimum-base-quality NUM
                          Minimum base quality used in classification (def: 0,
                          only effective with FASTQ input).
  --report FILENAME       Print a report with aggregrate counts/clade to file
  --use-mpa-style         With --report, format report output like Kraken 1's
                          kraken-mpa-report
  --report-zero-counts    With --report, report counts for ALL taxa, even if
                          counts are zero
  --report-minimizer-data With --report, report minimizer and distinct minimizer
                          count information in addition to normal Kraken report
  --memory-mapping        Avoids loading database into RAM
  --paired                The filenames provided have paired-end reads
  --use-names             Print scientific names instead of just taxids
  --gzip-compressed       Input files are compressed with gzip
  --bzip2-compressed      Input files are compressed with bzip2
  --minimum-hit-groups NUM
                          Minimum number of hit groups (overlapping k-mers
                          sharing the same minimizer) needed to make a call
                          (default: 2)
  --help                  Print this message
  --version               Print version information

If none of the *-compressed flags are specified, and the filename provided
is a regular file, automatic format detection is attempted.
```

## kraken2_build

### Tool Description
Build a Kraken 2 database. Exactly one task option must be selected per call.

### Metadata
- **Docker Image**: quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0
- **Homepage**: https://github.com/DerrickWood/kraken2
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kraken2-build [task option] [options]

Task options (exactly one must be selected):
  --download-taxonomy        Download NCBI taxonomic information
  --download-library TYPE    Download partial library
                             (TYPE = one of "archaea", "bacteria", "plasmid",
                             "viral", "human", "fungi", "plant", "protozoa",
                             "nr", "nt", "UniVec", "UniVec_Core")
  --special TYPE             Download and build a special database
                             (TYPE = one of "greengenes", "silva", "rdp")
  --add-to-library FILE      Add FILE to library
  --build                    Create DB from library
                             (requires taxonomy d/l'ed and at least one file
                             in library)
  --clean                    Remove unneeded files from a built database
  --standard                 Download and build default database
  --help                     Print this message
  --version                  Print version information

Options:
  --db NAME                  Kraken 2 DB name (mandatory except for
                             --help/--version)
  --threads #                Number of threads (def: 1)
  --kmer-len NUM             K-mer length in bp/aa (build task only;
                             def: 35 nt, 15 aa)
  --minimizer-len NUM        Minimizer length in bp/aa (build task only;
                             def: 31 nt, 12 aa)
  --minimizer-spaces NUM     Number of characters in minimizer that are
                             ignored in comparisons (build task only;
                             def: 7 nt, 0 aa)
  --protein                  Build a protein database for translated search
  --no-masking               Used with --standard/--download-library/
                             --add-to-library to avoid masking low-complexity
                             sequences prior to building; masking requires
                             dustmasker or segmasker to be installed in PATH,
                             which some users might not have.
  --max-db-size NUM          Maximum number of bytes for Kraken 2 hash table;
                             if the estimator determines more would normally be
                             needed, the reference library will be downsampled
                             to fit. (Used with --build/--standard/--special)
  --use-ftp                  Use FTP for downloading instead of RSYNC; used with
                             --download-library/--download-taxonomy/--standard.
  --skip-maps                Avoids downloading accession number to taxid maps,
                             used with --download-taxonomy.
  --load-factor FRAC         Proportion of the hash table to be populated
                             (build task only; def: 0.7, must be
                             between 0 and 1).
  --fast-build               Do not require database to be deterministically
                             built when using multiple threads.  This is faster,
                             but does introduce variability in minimizer/LCA
                             pairs.  Used with --build and --standard options.
```

## kraken2_inspect

### Tool Description
Inspect a Kraken 2 database: print the taxa and minimizer counts it holds.

### Metadata
- **Docker Image**: quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0
- **Homepage**: https://github.com/DerrickWood/kraken2
- **Package**: https://anaconda.org/channels/bioconda/packages/kraken2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kraken2-inspect [options]

Options:
  --db NAME               Name for Kraken 2 DB
                          (default: none)
  --threads NUM           Number of threads to use
  --skip-counts           Only print database summary statistics
  --use-mpa-style         Format output like Kraken 1's kraken-mpa-report
  --report-zero-counts    Report counts for ALL taxa, even if
                          counts are zero
  --help                  Print this message
  --version               Print version information
```
