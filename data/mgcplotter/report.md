# mgcplotter CWL Generation Report

## mgcplotter_MGCplotter

### Tool Description
Microbial Genome Circular plotting tool

### Metadata
- **Docker Image**: quay.io/biocontainers/mgcplotter:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/MGCplotter/
- **Package**: https://anaconda.org/channels/bioconda/packages/mgcplotter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mgcplotter/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/moshi4/MGCplotter
- **Stars**: N/A
### Original Help Text
```text
usage: MGCplotter -r R -o O [--query_files  [...]] [--cog_evalue]
                  [--mmseqs_evalue] [-t] [-f] [-v] [-h] [--ticks_labelsize]
                  [--forward_cds_r] [--reverse_cds_r] [--rrna_r] [--trna_r]
                  [--conserved_cds_r] [--gc_content_r] [--gc_skew_r]
                  [--assign_cog_color] [--cog_color_json]
                  [--forward_cds_color] [--reverse_cds_color] [--rrna_color]
                  [--trna_color] [--conserved_cds_color]
                  [--gc_content_p_color] [--gc_content_n_color]
                  [--gc_skew_p_color] [--gc_skew_n_color]

Microbial Genome Circular plotting tool

General Options:
  -r R, --ref_file R      Reference genome genbank file (*.gb|*.gbk|*.gbff)
  -o O, --outdir O        Output directory
  --query_files  [ ...]   Query CDS fasta or genome genbank files
                          (*.fa|*.faa|*.fasta|*.gb|*.gbk|*.gbff)
  --cog_evalue            COGclassifier e-value parameter (Default: 1e-02)
  --mmseqs_evalue         MMseqs RBH search e-value parameter (Default: 1e-03)
  -t , --thread_num       Threads number parameter (Default: 19)
  -f, --force             Forcibly overwrite previous calculation result
                          (Default: OFF)
  -v, --version           Print version information
  -h, --help              Show this help message and exit

Graph Size Options:
  --ticks_labelsize       Ticks label size (Default: 35)
  --forward_cds_r         Forward CDS track radius size (Default: 0.07)
  --reverse_cds_r         Reverse CDS track radius size (Default: 0.07)
  --rrna_r                rRNA track radius size (Default: 0.07)
  --trna_r                tRNA track radius size (Default: 0.07)
  --conserved_cds_r       Conserved CDS track radius size (Default: 0.04)
  --gc_content_r          GC content track radius size (Default: 0.15)
  --gc_skew_r             GC skew track radius size (Default: 0.15)

Graph Color Options:
  --assign_cog_color      Assign COG classification color to reference CDSs
                          (Default: OFF)
  --cog_color_json        User-defined COG classification color json file
  --forward_cds_color     Forward CDS color (Default: 'red')
  --reverse_cds_color     Reverse CDS color (Default: 'blue')
  --rrna_color            rRNA color (Default: 'green')
  --trna_color            tRNA color (Default: 'magenta')
  --conserved_cds_color   Conserved CDS color (Default: 'chocolate')
  --gc_content_p_color    GC content color for positive value from average
                          (Default: 'black')
  --gc_content_n_color    GC content color for negative value from average
                          (Default: 'grey')
  --gc_skew_p_color       GC skew color for positive value (Default: 'olive')
  --gc_skew_n_color       GC skew color for negative value (Default: 'purple')
```

