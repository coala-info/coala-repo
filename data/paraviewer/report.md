# paraviewer CWL Generation Report

## paraviewer

### Tool Description
A tool for visualizing paraphase and PureTarget Carrier Panel results.

### Metadata
- **Docker Image**: quay.io/biocontainers/paraviewer:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/Paraviewer
- **Package**: https://anaconda.org/channels/bioconda/packages/paraviewer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/paraviewer/overview
- **Total Downloads**: 69
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/PacificBiosciences/Paraviewer
- **Stars**: N/A
### Original Help Text
```text
usage: paraviewer [-h] [-v] --outdir OUTDIR [--paraphase-dir PARAPHASE_DIR]
                  [--ptcp-dir PTCP_DIR] [--clobber] --genome {hg19,hg38}
                  [--pedigree PEDIGREE]
                  [--include-only-regions INCLUDE_ONLY_REGIONS [INCLUDE_ONLY_REGIONS ...]]
                  [--exclude-regions EXCLUDE_REGIONS [EXCLUDE_REGIONS ...]]
                  [--include-only-samples INCLUDE_ONLY_SAMPLES [INCLUDE_ONLY_SAMPLES ...]]
                  [--exclude-samples EXCLUDE_SAMPLES [EXCLUDE_SAMPLES ...]]
                  [--max-reads-per-haplotype MAX_READS_PER_HAPLOTYPE]
                  [--verbose]

options:
  -h, --help            show this help message and exit
  -v, --version         Installed version (0.1.0)
  --outdir OUTDIR       Path to output directory - should not already exist
                        (default: None)
  --paraphase-dir PARAPHASE_DIR
                        Path to paraphase result directory. (default: None)
  --ptcp-dir PTCP_DIR   Path to PureTarget Carrier Panel result directory.
                        (default: None)
  --clobber             Overwrite output directory if it already exists
                        (default: False)
  --genome {hg19,hg38}  Desired genome build. Choose between GRCh37/HG19
                        (hg19) and GRCh38/HG38 (hg38) (default: None)
  --pedigree PEDIGREE   Path to GATK-format PED file containing pedigree
                        information - unrepresented samples will be excluded.
                        (default: None)
  --include-only-regions INCLUDE_ONLY_REGIONS [INCLUDE_ONLY_REGIONS ...]
                        Space-delimited list of region names to include.
                        Regions not specified will be excluded. (default:
                        None)
  --exclude-regions EXCLUDE_REGIONS [EXCLUDE_REGIONS ...]
                        Space-delimited list of region names to exclude.
                        (default: None)
  --include-only-samples INCLUDE_ONLY_SAMPLES [INCLUDE_ONLY_SAMPLES ...]
                        Space-delimited list of sample IDs to include. Samples
                        not specified will be excluded. (default: None)
  --exclude-samples EXCLUDE_SAMPLES [EXCLUDE_SAMPLES ...]
                        Space-delimited list of sample IDs to exclude.
                        (default: None)
  --max-reads-per-haplotype MAX_READS_PER_HAPLOTYPE
                        Maximum number of reads to show per haplotype.
                        (default: 500)
  --verbose             Print verbose output for debugging purposes (default:
                        False)
```


## Metadata
- **Skill**: generated
