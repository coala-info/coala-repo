# tb_variant_filter CWL Generation Report

## tb_variant_filter

### Tool Description
Filter variants from a VCF file (relative to M. tuberculosis H37Rv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tb_variant_filter:0.4.0--pyhdfd78af_0
- **Homepage**: http://github.com/pvanheus/tb_variant_filter
- **Package**: https://anaconda.org/channels/bioconda/packages/tb_variant_filter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tb_variant_filter/overview
- **Total Downloads**: 22.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pvanheus/tb_variant_filter
- **Stars**: N/A
### Original Help Text
```text
usage: tb_variant_filter [-h] [--region_filter REGION_FILTER]
                         [--close_to_indel_filter]
                         [--indel_window_size INDEL_WINDOW_SIZE]
                         [--min_percentage_alt_filter]
                         [--min_percentage_alt MIN_PERCENTAGE_ALT]
                         [--min_depth_filter] [--min_depth MIN_DEPTH]
                         [--snv_only_filter]
                         input_file [output_file]

Filter variants from a VCF file (relative to M. tuberculosis H37Rv)

positional arguments:
  input_file            VCF input file (relative to H37Rv)
  output_file           Output file (VCF format)

options:
  -h, --help            show this help message and exit
  --region_filter REGION_FILTER, -R REGION_FILTER
  --close_to_indel_filter, -I
                        Mask out single nucleotide variants that are too close
                        to indels
  --indel_window_size INDEL_WINDOW_SIZE
                        Window around indel to mask out (mask this number of
                        bases upstream/downstream from the indel. Requires -I
                        option to selected)
  --min_percentage_alt_filter, -P
                        Mask out variants with less than a given percentage
                        variant allele at this site
  --min_percentage_alt MIN_PERCENTAGE_ALT
                        Variants with less than this percentage variants at a
                        site will be masked out
  --min_depth_filter, -D
                        Mask out variants with less than a given depth of
                        reads
  --min_depth MIN_DEPTH
                        Variants at sites with less than this depth of reads
                        will be masked out
  --snv_only_filter     Mask out variants that are not SNVs
```

