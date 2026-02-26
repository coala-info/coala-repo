# tmb CWL Generation Report

## tmb_pyTMB.py

### Tool Description
Calculates Tumor Mutational Burden (TMB) from variant data.

### Metadata
- **Docker Image**: quay.io/biocontainers/tmb:1.5.0--pyhdfd78af_1
- **Homepage**: https://github.com/bioinfo-pf-curie/TMB
- **Package**: https://anaconda.org/channels/bioconda/packages/tmb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tmb/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-09-13
- **GitHub**: https://github.com/bioinfo-pf-curie/TMB
- **Stars**: N/A
### Original Help Text
```text
usage: pyTMB.py [-h] -i VCF --dbConfig DBCONFIG --varConfig VARCONFIG
                [--sample SAMPLE] [--effGenomeSize EFFGENOMESIZE] [--bed BED]
                [--vaf VAF] [--maf MAF] [--minDepth MINDEPTH]
                [--minAltDepth MINALTDEPTH] [--filterLowQual] [--filterIndels]
                [--filterCoding] [--filterSplice] [--filterNonCoding]
                [--filterSyn] [--filterNonSyn] [--filterCancerHotspot]
                [--filterPolym] [--filterRecurrence] [--polymDb POLYMDB]
                [--cancerDb CANCERDB] [--verbose] [--debug] [--export]
                [--version]

options:
  -h, --help            show this help message and exit
  -i VCF, --vcf VCF     Input file (.vcf, .vcf.gz, .bcf, .bcf.gz) (default:
                        None)
  --dbConfig DBCONFIG   Databases config file (default: None)
  --varConfig VARCONFIG
                        Variant calling config file (default: None)
  --sample SAMPLE       Specify the sample ID to focus on (default: None)
  --effGenomeSize EFFGENOMESIZE
                        Effective genome size (default: None)
  --bed BED             Capture design to use if effGenomeSize is not defined
                        (BED file) (default: None)
  --vaf VAF             Filter variants with Allelic Ratio < vaf (default: 0)
  --maf MAF             Filter variants with MAF > maf (default: 1)
  --minDepth MINDEPTH   Filter variants with depth < minDepth (default: 1)
  --minAltDepth MINALTDEPTH
                        Filter variants with alternative allele depth <
                        minAltDepth (default: 1)
  --filterLowQual       Filter low quality (i.e not PASS) variant (default:
                        False)
  --filterIndels        Filter insertions/deletions (default: False)
  --filterCoding        Filter Coding variants (default: False)
  --filterSplice        Filter Splice variants (default: False)
  --filterNonCoding     Filter Non-coding variants (default: False)
  --filterSyn           Filter Synonymous variants (default: False)
  --filterNonSyn        Filter Non-Synonymous variants (default: False)
  --filterCancerHotspot
                        Filter variants annotated as cancer hotspots (default:
                        False)
  --filterPolym         Filter polymorphism variants in genome databases. See
                        --maf (default: False)
  --filterRecurrence    Filter on recurrence values (default: False)
  --polymDb POLYMDB     Databases used for polymorphisms detection (comma
                        separated) (default: gnomad)
  --cancerDb CANCERDB   Databases used for cancer hotspot annotation (comma
                        separated) (default: cosmic)
  --verbose             Active verbose mode (default: False)
  --debug               Export original VCF with TMB_FILTER tag (default:
                        False)
  --export              Export a VCF with the considered variants (default:
                        False)
  --version             Version number
```

