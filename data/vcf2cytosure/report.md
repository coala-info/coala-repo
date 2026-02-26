# vcf2cytosure CWL Generation Report

## vcf2cytosure

### Tool Description
convert SV vcf files to cytosure

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf2cytosure:0.9.3--pyh7e72e81_0
- **Homepage**: https://github.com/NBISweden/vcf2cytosure
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf2cytosure/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcf2cytosure/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/NBISweden/vcf2cytosure
- **Stars**: N/A
### Original Help Text
```text
usage: VCF2cytosure - convert SV vcf files to cytosure [-h] [--size SIZE]
                                                       [--frequency FREQUENCY]
                                                       [--frequency_tag FREQUENCY_TAG]
                                                       [--no-filter]
                                                       [--genome GENOME]
                                                       [--sex SEX] --vcf VCF
                                                       [--bins BINS]
                                                       [--coverage COVERAGE]
                                                       [--cn CN] [--snv SNV]
                                                       [--dp DP]
                                                       [--maxbnd MAXBND]
                                                       [--out OUT]
                                                       [--blacklist BLACKLIST]
                                                       [-V]

options:
  -h, --help            show this help message and exit

Filtering:
  --size SIZE           Minimum variant size. Default: 1000
  --frequency FREQUENCY
                        Maximum frequency. Default: 0.01
  --frequency_tag FREQUENCY_TAG
                        Frequency tag of the info field. Default: FRQ
  --no-filter           Disable any filtering

Input:
  --genome GENOME       Human genome version. Use 37 for GRCh37/hg19, 38 for
                        GRCh38 template.
  --sex SEX             Sample sex male/female. Default: female
  --vcf VCF             VCF file
  --bins BINS           the number of coverage bins per probes default=20
  --coverage COVERAGE   Coverage file
  --cn CN               add probes using cnvkit cn file(cannot be used
                        together with --coverage)
  --snv SNV             snv vcf file, use coverage annotation to position the
                        height of the probes(cannot be used together with
                        --coverage)
  --dp DP               read depth tag of snv vcf file. This option is only
                        used if you use snv to set the heigth of the probes.
                        The dp tag is a tag which is used to retrieve the
                        depth of coverage across the snv (default=DP)
  --maxbnd MAXBND       Maxixmum BND size, BND events exceeding this size are
                        discarded
  --out OUT             output file (default = the prefix of the input vcf)
  --blacklist BLACKLIST
                        Blacklist bed format file to exclude completely
                        contained variants.
  -V, --version         Print program version and exit.
```

