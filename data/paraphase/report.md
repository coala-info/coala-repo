# paraphase CWL Generation Report

## paraphase

### Tool Description
Paraphase: HiFi-based caller for highly similar paralogous genes

### Metadata
- **Docker Image**: quay.io/biocontainers/paraphase:3.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/paraphase
- **Package**: https://anaconda.org/channels/bioconda/packages/paraphase/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/paraphase/overview
- **Total Downloads**: 16.0K
- **Last updated**: 2025-11-10
- **GitHub**: https://github.com/PacificBiosciences/paraphase
- **Stars**: N/A
### Original Help Text
```text
usage: paraphase [-h] (-b BAM | -l LIST) -r REFERENCE -o OUT [-p PREFIX]
                 [-g GENE] [-c CONFIG] [-t THREADS]
                 [--min-variant-frequency MIN_VARIANT_FREQUENCY]
                 [--min-haplotype-frequency MIN_HAPLOTYPE_FREQUENCY]
                 [--genome GENOME] [--novcf] [--gene1only]
                 [--write-nocalls-in-vcf] [--targeted] [--samtools SAMTOOLS]
                 [--minimap2 MINIMAP2] [-v]

Paraphase: HiFi-based caller for highly similar paralogous genes

options:
  -h, --help            show this help message and exit
  -p, --prefix PREFIX   Prefix of output files for a single sample. Used with -b.
                        If not provided, prefix will be extracted from the header of the input BAM.
  -g, --gene GENE       Optionally specify which gene(s) to run (separated by comma).
                        Will run all genes if not specified.
                        The full set of accepted regions are defined in the config file.
                        Alternatively, you can define genes to call by modifying paraphase/data/genes.yaml
  -c, --config CONFIG   Optional path to a user-defined config file listing the full set of regions to analyze.
                        By default Paraphase uses the config file in paraphase/data/38/config.yaml
  -t, --threads THREADS
                        Optional number of threads
  --min-variant-frequency MIN_VARIANT_FREQUENCY
                        Optional. Minimum frequency for a variant to be used for phasing. Works with the targeted mode.
                        The cutoff for variant-supporting reads is determined by max(5, total_depth * min_frequency).
                        Note that total_depth is the combined depth of all paralogs for a paralog group.
                        Default is 0.11.
  --min-haplotype-frequency MIN_HAPLOTYPE_FREQUENCY
                        Optional. Minimum frequency of unique supporting reads for a haplotype. Works with the targeted mode.
                        The cutoff for haplotype-supporting reads is determined by max(4, total_depth * min_frequency).
                        Note that total_depth is the combined depth of all paralogs for a paralog group.
                        Default is 0.03.
  --genome GENOME       Optionally specify which genome reference build the input BAM files are aligned against.
                        Accepted values are 19, 37, chm13, and 38. Default is 38.
                        Note that fewer genes are currently supported in 19/37/chm13. See paraphase/data/19/config.yaml and paraphase/data/chm13/config.yaml
  --novcf               Optional. If specified, paraphase will not write vcfs
  --gene1only           Optional. If specified, variant calls will be made against the main gene only.
                        By default, for SMN1, PMS2, STRC, NCF1 and IKBKG, haplotypes are assigned to gene or
                        paralog/pseudogene, and variants are called against gene or paralog/pseudogene, respectively.
  --write-nocalls-in-vcf
                        Optional. If specified, Paraphase will write no-call sites in the VCFs, marked with LowQual filter.
  --targeted            Optional. If specified, paraphase will not assume depth is uniform across the genome.
  --samtools SAMTOOLS   Optional path to samtools
  --minimap2 MINIMAP2   Optional path to minimap2
  -v, --version         show program's version number and exit

Input Options:
  -b, --bam BAM         Input BAM file, mutually exclusive with -l
  -l, --list LIST       File listing absolute paths to multiple input BAM files, one per line
  -r, --reference REFERENCE
                        Path to reference genome fasta file

Output Options:
  -o, --out OUT         Output directory
```


## Metadata
- **Skill**: generated
