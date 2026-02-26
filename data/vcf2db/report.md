# vcf2db CWL Generation Report

## vcf2db_vcf2db.py

### Tool Description
Take a VCF and create a gemini compatible database

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf2db:2020.02.24--pl5321hdfd78af_3
- **Homepage**: https://github.com/quinlan-lab/vcf2db
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf2db/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcf2db/overview
- **Total Downloads**: 89.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/quinlan-lab/vcf2db
- **Stars**: N/A
### Original Help Text
```text
usage: 
Take a VCF and create a gemini compatible database

       [-h] [--a-ok A_OK] [-e INFO_EXCLUDE] [--impacts-field IMPACTS_FIELD]
       [--legacy-compression]
       [--expand {gt_depths,gt_ref_depths,gt_alt_freqs,gt_alt_depths,gt_quals,gt_types}]
       VCF ped db

positional arguments:
  VCF
  ped
  db

options:
  -h, --help            show this help message and exit
  --a-ok A_OK           list of info names to include even with Number=A (will
                        error if they have > 1 value
  -e INFO_EXCLUDE, --info-exclude INFO_EXCLUDE
                        don't save this field to the database. May be
                        specified multiple times.
  --impacts-field IMPACTS_FIELD
                        this field should be propagated to the variant_impacts
                        table. by default, only CSQ/EFF/ANN fields are added.
                        the field can be suffixed with a type of ':i' or ':f'
                        to indicate int or float to override the default of
                        string. e.g. AF:f
  --legacy-compression
  --expand {gt_depths,gt_ref_depths,gt_alt_freqs,gt_alt_depths,gt_quals,gt_types}
                        sample columns to expand into their own tables
```

