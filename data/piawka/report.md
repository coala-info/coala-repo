# piawka CWL Generation Report

## piawka

### Tool Description
A tool for calculating population genetics statistics (pi, Dxy, Fst, etc.) from VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/piawka:0.8.11--hdfd78af_0
- **Homepage**: https://github.com/novikovalab/piawka
- **Package**: https://anaconda.org/channels/bioconda/packages/piawka/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/piawka/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/novikovalab/piawka
- **Stars**: N/A
### Original Help Text
```text
piawka v0.8.11
Usage:
piawka -g groups_tsv -v vcf_gz [OPTIONS]
Options:
-1, --persite       output values for each site
-b, --bed <arg>     BED file with regions to be analyzed
-B, --targets <arg> BED file with targets (faster for numerous small regions)
-D, --nodxy         do not output Dxy
-f, --fst           output Hudson Fst
-F, --fstwc         output Weir and Cockerham Fst instead
-g, --groups <arg>  either 2-columns sample / group table or 
                    keywords "unite" (1 group) or "divide" (n_samples groups)
-h, --help          show this help message
-H, --het           output only per-sample pi = heterozygosity
-j, --jobs <arg>    number of parallel jobs to run
-m, --mult          use multiallelic sites
-M, --miss <arg>    max share of missing GT per group at site, 0.0-1.0
-P, --nopi          do not output pi
-q, --quiet         do not output progress and warning messages
-r, --rho           output Ronfort's rho
-t, --tajimalike    output TajimaD-like stat (manages missing data but untested)
-T, --tajima        output classic TajimaD instead (affected by missing data)
-v, --vcf <arg>     gzipped and tabixed VCF file
-w, --watterson     output Watterson's theta
locus	nSites	pop1	pop2	nUsed	metric	value	numerator	denominator	nGeno	nMiss
```


## Metadata
- **Skill**: generated
