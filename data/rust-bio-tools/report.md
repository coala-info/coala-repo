# rust-bio-tools CWL Generation Report

## rust-bio-tools_rbt

### Tool Description
A set of ultra-fast command line utilities for bioinformatics tasks based on Rust-Bio.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-bio-tools:0.42.2--h5c46d4b_3
- **Homepage**: https://github.com/rust-bio/rust-bio-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rust-bio-tools/overview
- **Total Downloads**: 312.5K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/rust-bio/rust-bio-tools
- **Stars**: N/A
### Original Help Text
```text
Rust-Bio-Tools 0.42.2
Johannes Köster <johannes.koester@tu-dortmund.de>
A set of ultra-fast command line utilities for bioinformatics tasks based on Rust-Bio.

USAGE:
    rbt [FLAGS] <SUBCOMMAND>

FLAGS:
    -h, --help       
            Prints help information

    -V, --version    
            Prints version information

    -v, --verbose    
            Verbose output.


SUBCOMMANDS:
    bam-anonymize                  Tool to build artifical reads from real BAM files with identical properties
    bam-depth                      Print depth of BAM or CRAM file at given positions from STDIN (tab separated:
                                   chrom, pos)
    collapse-reads-to-fragments    Tool to predict maximum likelihood fragment sequence from FASTQ or BAM files
    csv-report                     Creates report from a given csv file containing a table with the given data
                                   Examples: With current directory as default ouput path: rbt csv-report
                                   path/to/table.csv --rows-per-page 100 --sort-column "p-value" --sort-order
                                   ascending
    fastq-filter                   Remove records from a FASTQ file (from STDIN), output to STDOUT
    fastq-split                    Split FASTQ file from STDIN into N chunks
    help                           Prints this message or the help of the given subcommand(s)
    plot-bam                       Creates a html file with a vega visualization of the given bam region that is
                                   then written to stdout.
    sequence-stats                 Tool to compute stats on sequence file (from STDIN), output is in YAML with
                                   fields: - min: length of shortest sequence - max: length of longest sequence -
                                   average: average length of sequence - median: median length of sequence -
                                   nb_reads: number of reads - nb_bases: number of bases - n50: N50 of sequences
    vcf-annotate-dgidb             Looks for interacting drugs in DGIdb and annotates them for every gene in every
                                   record
    vcf-baf                        Annotate b-allele frequency for each single nucleotide variant and sample
    vcf-fix-iupac-alleles          Convert any IUPAC codes in alleles into Ns (in order to comply with VCF 4 specs).
                                   Reads VCF/BCF from STDIN and writes BCF to STDOUT
    vcf-match                      Annotate for each variant in a VCF/BCF at STDIN whether it is contained in a
                                   given second VCF/BCF. The matching is fuzzy for indels and exact for SNVs.
                                   Results are printed as BCF to STDOUT, with an additional INFO tag MATCHING. The
                                   two vcfs do not have to be sorted
    vcf-report                     Creates report from a given VCF file including a visual plot for every variant
                                   with the given BAM and FASTA file. The VCF file has to be annotated with VEP,
                                   using the options --hgvs and --hgvsg
    vcf-split                      Split a given VCF/BCF file into N chunks of approximately the same size.
                                   Breakends are kept together. Output type is always BCF
    vcf-to-txt                     Convert VCF/BCF file from STDIN to tab-separated TXT file at STDOUT. INFO and
                                   FORMAT tags have to be selected explicitly
```

