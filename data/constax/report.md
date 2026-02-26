# constax CWL Generation Report

## constax

### Tool Description
Classify sequences using various methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/constax:2.0.20--pyhdfd78af_0
- **Homepage**: https://github.com/liberjul/CONSTAXv2
- **Package**: https://anaconda.org/channels/bioconda/packages/constax/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/constax/overview
- **Total Downloads**: 46.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/liberjul/CONSTAXv2
- **Stars**: N/A
### Original Help Text
```text
usage: constax [-h] [-c CONF] [-n NUM_THREADS] [-m MHITS] [-e EVALUE]
               [-p P_IDEN] [-d DB] [-f TRAINFILE] [-i INPUT] [-o OUTPUT]
               [-x TAX] [-t] [-b] [--select_by_keyword SELECT_BY_KEYWORD]
               [--msu_hpcc] [-s] [--consistent] [--make_plot] [--check]
               [--mem MEM] [--sintax_path SINTAX_PATH] [--utax_path UTAX_PATH]
               [--rdp_path RDP_PATH] [--constax_path CONSTAX_PATH]
               [--pathfile PATHFILE] [--isolates ISOLATES]
               [--isolates_query_coverage ISOLATES_QUERY_COVERAGE]
               [--isolates_percent_identity ISOLATES_PERCENT_IDENTITY]
               [--high_level_db HIGH_LEVEL_DB]
               [--high_level_query_coverage HIGH_LEVEL_QUERY_COVERAGE]
               [--high_level_percent_identity HIGH_LEVEL_PERCENT_IDENTITY]
               [--combine_only] [-v]

options:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Classification confidence threshold (default: 0.8)
  -n NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads to use for parallel computing steps
                        (default: 1)
  -m MHITS, --mhits MHITS
                        Maximum number of BLAST hits to use, for use with -b
                        option (default: 10)
  -e EVALUE, --evalue EVALUE
                        Maximum expect value of BLAST hits to use, for use
                        with -b option (default: 1.0)
  -p P_IDEN, --p_iden P_IDEN
                        Minimum proportion identity of BLAST hits to use, for
                        use with -b option (default: 0.0)
  -d DB, --db DB        Database to train classifiers, in FASTA format
                        (default: )
  -f TRAINFILE, --trainfile TRAINFILE
                        Path to which training files will be written (default:
                        ./training_files)
  -i INPUT, --input INPUT
                        Input file in FASTA format containing sequence records
                        to classify (default: otus.fasta)
  -o OUTPUT, --output OUTPUT
                        Output directory for classifications (default:
                        ./outputs)
  -x TAX, --tax TAX     Directory for taxonomy assignments (default:
                        ./taxonomy_assignments)
  -t, --train           Complete training if specified (default: False)
  -b, --blast           Use BLAST instead of UTAX if specified (default:
                        False)
  --select_by_keyword SELECT_BY_KEYWORD
                        Takes a keyword argument and --input FASTA file to
                        produce a filtered database with headers containing
                        the keyword with name --output (default: False)
  --msu_hpcc            **THIS ARGUMENT HAS BEEN DEPRECATED IN VERSION
                        2.0.19** If specified, use executable paths on
                        Michigan State University HPCC. Overrides other path
                        arguments (default: False)
  -s, --conservative    If specified, use conservative consensus rule (2 False
                        = False winner) (default: False)
  --consistent          If specified, show if the consensus taxonomy is
                        consistent with the real hierarchical taxonomy
                        (default: False)
  --make_plot           If specified, run R script to make plot of classified
                        taxa (default: False)
  --check               If specified, runs checks but stops before training or
                        classifying (default: False)
  --mem MEM             Memory available to use for RDP, in MB. 32000MB
                        recommended for UNITE, 128000MB for SILVA (default:
                        32000)
  --sintax_path SINTAX_PATH
                        Path to USEARCH/VSEARCH executable for SINTAX
                        classification (default: False)
  --utax_path UTAX_PATH
                        Path to USEARCH executable for UTAX classification
                        (default: False)
  --rdp_path RDP_PATH   Path to RDP classifier.jar file (default: False)
  --constax_path CONSTAX_PATH
                        Path to CONSTAX scripts (default: False)
  --pathfile PATHFILE   File with paths to SINTAX, UTAX, RDP, and CONSTAX
                        executables (default: pathfile.txt)
  --isolates ISOLATES   FASTA formatted file of isolates to use BLAST against
                        (default: False)
  --isolates_query_coverage ISOLATES_QUERY_COVERAGE
                        Threshold of sequence query coverage to report isolate
                        matches (default: 75)
  --isolates_percent_identity ISOLATES_PERCENT_IDENTITY
                        Threshold of aligned sequence percent identity to
                        report isolate matches (default: 1)
  --high_level_db HIGH_LEVEL_DB
                        FASTA database file of representative sequences for
                        assignment of high level taxonomy (default: False)
  --high_level_query_coverage HIGH_LEVEL_QUERY_COVERAGE
                        Threshold of sequence query coverage to report high-
                        level taxonomy matches (default: 75)
  --high_level_percent_identity HIGH_LEVEL_PERCENT_IDENTITY
                        Threshold of aligned sequence percent identity to
                        report high-level taxonomy matches (default: 1)
  --combine_only        Only combine taxonomy without rerunning classifiers
                        (default: False)
  -v, --version         Display version and exit (default: False)
```

