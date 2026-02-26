# irescue CWL Generation Report

## irescue

### Tool Description
IRescue (Interspersed Repeats single-cell quantifier): a toolfor quantifying transposable elements expression in scRNA-seq.

### Metadata
- **Docker Image**: quay.io/biocontainers/irescue:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bodegalab/irescue
- **Package**: https://anaconda.org/channels/bioconda/packages/irescue/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/irescue/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/bodegalab/irescue
- **Stars**: N/A
### Original Help Text
```text
usage: irescue -b <file.bam> [-g GENOME_ASSEMBLY | -r BED_FILE] [OPTIONS]

IRescue (Interspersed Repeats single-cell quantifier): a toolfor quantifying
transposable elements expression in scRNA-seq.

options:
  -h, --help            show this help message and exit
  -b, --bam FILE        scRNA-seq reads aligned to a reference genome
                        (required).
  -r, --regions FILE    Genomic TE coordinates in bed format (at least 4
                        columns with TE feature name (e.g. subfamily) as the
                        4th column). Takes priority over --genome (default:
                        None).
  -g, --genome STR      Genome assembly symbol. One of: GRCh38, hg38, GRCh37,
                        hg19, GRCm39, mm39, GRCm38, mm10, dm6, test (default:
                        None).
  -w, --whitelist FILE  Text file of filtered cell barcodes by e.g. Cell
                        Ranger, STARSolo or your gene expression quantifier of
                        choice (Recommended. default: None). Note: If not
                        provided, all barcodes found in BAM will be used.
  -c, --cb-tag STR      BAM tag containing the cell barcode sequence (default:
                        CB).
  -u, --umi-tag STR     BAM tag containing the UMI sequence (default: UR).
  -l, --locus           Perform locus-level quantification, instead of
                        subfamily-level (default: False).
  --no-umi              Ignore UMI sequence. Intended for UMI-less datasets,
                        such as Smart-seq (default: False).
  -p, --threads CPUS    Number of cpus to use (default: 1).
  -o, --outdir DIR      Output directory name (default: irescue_out).
  --min-bp-overlap INT  Minimum overlap between read and TE as number of
                        nucleotides (Default: disabled).
  --min-fraction-overlap FLOAT
                        Minimum overlap between read and TE as a fraction of
                        read's alignment (i.e. 0.00 <= NUM <= 1.00) (Default:
                        disabled).
  --strandedness STR    Library strandedness. Use only if the orientation of
                        TEs is relevant. One of: unstranded, forward, reverse
                        (default: unstranded).
  --max-iters INT       Maximum number of EM iterations (Default: 100).
  --tolerance FLOAT     Log-likelihood change below which convergence is
                        assumed (Default: 0.0001).
  --dump-ec             Write a description log file of Equivalence Classes.
  --integers            Use if integers count are needed for downstream
                        analysis.
  --samtools PATH       Path to samtools binary, in case it's not in PATH
                        (Default: samtools).
  --bedtools PATH       Path to bedtools binary, in case it's not in PATH
                        (Default: bedtools).
  --no-tags-check       Suppress checking for CBtag and UMItag presence in BAM
                        file.
  --keeptmp             Keep temporary files under <output_dir>/tmp.
  -v, --verbose         Writes additional logging to stderr. Use once for
                        normal verbosity (-v), twice for debugging (-vv).
  -V, --version         Print software's version and exit.

Home page: https://github.com/bodegalab/irescue
```

