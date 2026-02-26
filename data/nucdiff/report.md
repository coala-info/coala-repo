# nucdiff CWL Generation Report

## nucdiff

### Tool Description
Compares two fasta files and outputs differences

### Metadata
- **Docker Image**: quay.io/biocontainers/nucdiff:2.0.3--pyh864c0ab_1
- **Homepage**: https://github.com/uio-cels/NucDiff
- **Package**: https://anaconda.org/channels/bioconda/packages/nucdiff/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nucdiff/overview
- **Total Downloads**: 16.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/uio-cels/NucDiff
- **Stars**: N/A
### Original Help Text
```text
usage: nucdiff [-h] [--reloc_dist [int]] [--nucmer_opt [NUCMER_OPT]]
               [--filter_opt [FILTER_OPT]] [--delta_file [DELTA_FILE]]
               [--proc [int]] [--ref_name_full [{yes,no}]]
               [--query_name_full [{yes,no}]] [--vcf [{yes,no}]] [--version]
               Reference.fasta Query.fasta Output_dir Prefix

positional arguments:
  Reference.fasta       - Fasta file with the reference sequences
  Query.fasta           - Fasta file with the query sequences
  Output_dir            - Path to the directory where all intermediate and
                        final results will be stored
  Prefix                - Name that will be added to all generated files
                        including the ones created by NUCmer

optional arguments:
  -h, --help            show this help message and exit
  --reloc_dist [int]    - Minimum distance between two relocated blocks
                        [10000]
  --nucmer_opt [NUCMER_OPT]
                        - NUCmer run options. By default, NUCmer will be run
                        with its default parameters values, except the
                        --maxmatch parameter. --maxmatch is hard coded and
                        cannot be changed. To change any other parameter
                        values, type parameter names and new values inside
                        single or double quotation marks.
  --filter_opt [FILTER_OPT]
                        - Delta-filter run options. By default, it will be run
                        with -q parameter only. -q is hard coded and cannot be
                        changed. To add any other parameter values, type
                        parameter names and their values inside single or
                        double quotation marks.
  --delta_file [DELTA_FILE]
                        - Path to the already existing delta file (NUCmer
                        output file)
  --proc [int]          - Number of processes to be used [1]
  --ref_name_full [{yes,no}]
                        - Print full reference names in output files ('yes'
                        value). In case of 'no', everything after the first
                        space will be ignored. ['no']
  --query_name_full [{yes,no}]
                        - Print full query names in output files ('yes'
                        value). In case of 'no', everything after the first
                        space will be ignored.['no']
  --vcf [{yes,no}]      - Output small and medium local differences in the VCF
                        format
  --version             show program's version number and exit
```

