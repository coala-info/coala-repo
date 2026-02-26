# primerforge CWL Generation Report

## primerforge_primerForge

### Tool Description
Finds pairs of primers suitable for a group of input genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/primerforge:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/dr-joe-wirth/primerForge
- **Package**: https://anaconda.org/channels/bioconda/packages/primerforge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/primerforge/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dr-joe-wirth/primerForge
- **Stars**: N/A
### Original Help Text
```text
Finds pairs of primers suitable for a group of input genomes
    Joseph S. Wirth, 2024

If you use this software, please cite our article:
    https://doi.org/10.21105/joss.06850

usage:
    primerForge [-ioBubfpgtrdnkvh]

required arguments:
    -i, --ingroup          [file] ingroup filename or a file pattern inside double-quotes (eg."*.gbff")

optional arguments:
    -o, --out              [file] output filename for primer pair data (default: results.tsv)
    -B, --bed_file         [file] output filename for primer data in BED file format (default: primers.bed)
    -u, --outgroup         [file] outgroup filename or a file pattern inside double-quotes (eg."*.gbff")
    -b, --bad_sizes        [int,int] a range of PCR product lengths that the outgroup cannot produce (default: same as '--pcr_prod')
    -f, --format           [str] file format of the ingroup and outgroup [genbank|fasta] (default: genbank)
    -p, --primer_len       [int(s)] a single primer length or a range specified as 'min,max'; (minimum 10) (default: 16,20)
    -g, --gc_range         [float,float] a min and max percent GC specified as a comma separated list (default: 40.0,60.0)
    -t, --tm_range         [float,float] a min and max melting temp (°C) specified as a comma separated list (default: 55.0,68.0)
    -r, --pcr_prod         [int(s)] a single PCR product length or a range specified as 'min,max' (default: 120,2400)
    -d, --tm_diff          [float] the maximum allowable Tm difference °C between a pair of primers (default: 5.0)
    -n, --num_threads      [int] the number of threads for parallel processing (default: 1)
    -k, --keep             keep intermediate files (default: False)
    -v, --version          print the version
    -h, --help             print this message

    --check_install        check installation
    --debug                run in debug mode
    --advanced             print advanced options
```

