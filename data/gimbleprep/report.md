# gimbleprep CWL Generation Report

## gimbleprep

### Tool Description
Prepare data for GIMBLE

### Metadata
- **Docker Image**: quay.io/biocontainers/gimbleprep:0.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/LohseLab/gimbleprep
- **Package**: https://anaconda.org/channels/bioconda/packages/gimbleprep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gimbleprep/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LohseLab/gimbleprep
- **Stars**: N/A
### Original Help Text
```text
usage: gimbleprep                 -f <f> -v <v> -b <b> [-g <g> -m <m> -M <M> -q <q> -t <t> -o <o> -k] [-h|--help]
                                        
[Options]
    -f, --fasta_file=<f>             FASTA file
    -v, --vcf_file=<v>               VCF file (raw)
    -b, --bam_dir=<b>                Directory containing all BAM files
    -g, --snpgap=<g>                 SnpGap [default: 2]
    -q, --min_qual=<q>               Minimum PHRED quality [default: 1]
    -m, --min_depth=<m>              Min read depth [default: 8]
    -M, --max_depth=<M>              Max read depth (as multiple of mean coverage of each BAM) [default: 2]
    -t, --threads=<t>                Threads [default: 1]
    -o, --outprefix=<o>              Outprefix [default: gimble]
    -k, --keep_tmp                   Do not delete temporary files [default: False]
    -h, --help                       Show this
```

