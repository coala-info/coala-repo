# atol-bpa-datamapper CWL Generation Report

## atol-bpa-datamapper_map-metadata

### Tool Description
Map metadata in filtered jsonlines.gz

### Metadata
- **Docker Image**: quay.io/biocontainers/atol-bpa-datamapper:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/TomHarrop/atol-bpa-datamapper
- **Package**: https://anaconda.org/channels/bioconda/packages/atol-bpa-datamapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/atol-bpa-datamapper/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/TomHarrop/atol-bpa-datamapper
- **Stars**: N/A
### Original Help Text
```text
usage: map-metadata [-h] [-i INPUT] [-o OUTPUT]
                    [-f PACKAGE_FIELD_MAPPING_FILE]
                    [-r RESOURCE_FIELD_MAPPING_FILE] [-v VALUE_MAPPING_FILE]
                    [-s SANITIZATION_CONFIG_FILE]
                    [-l {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [-n]
                    [--raw_field_usage RAW_FIELD_USAGE]
                    [--raw_value_usage RAW_VALUE_USAGE]
                    [--mapped_field_usage MAPPED_FIELD_USAGE]
                    [--mapped_value_usage MAPPED_VALUE_USAGE]
                    [--unused_field_counts UNUSED_FIELD_COUNTS]
                    [--mapping_log MAPPING_LOG]
                    [--sanitization_changes SANITIZATION_CHANGES] --nodes
                    NODES --names NAMES --taxids_to_busco_dataset_mapping
                    TAXIDS_TO_BUSCO_DATASET_MAPPING
                    [--taxids_to_augustus_dataset_mapping TAXIDS_TO_AUGUSTUS_DATASET_MAPPING]
                    [--grouping_log GROUPING_LOG]
                    [--grouped_packages GROUPED_PACKAGES]
                    [--cache_dir CACHE_DIR]

Map metadata in filtered jsonlines.gz

options:
  -h, --help            show this help message and exit

Input:
  -i INPUT, --input INPUT
                        Input file (default: stdin)
  --nodes NODES         NCBI nodes.dmp file from taxdump
  --names NAMES         NCBI names.dmp file from taxdump
  --taxids_to_busco_dataset_mapping TAXIDS_TO_BUSCO_DATASET_MAPPING
                        BUSCO placement file from https://busco-
                        data.ezlab.org/v5/data/placement_files/
  --taxids_to_augustus_dataset_mapping TAXIDS_TO_AUGUSTUS_DATASET_MAPPING
                        File that maps Augustus datasets to NCBI TaxIDs. See
                        config/taxid_to_augustus_dataset.tsv

Output:
  -o OUTPUT, --output OUTPUT
                        Output file (default: stdout)

General options:
  -f PACKAGE_FIELD_MAPPING_FILE, --package_field_mapping_file PACKAGE_FIELD_MAPPING_FILE
                        Package-level field mapping file in json.
  -r RESOURCE_FIELD_MAPPING_FILE, --resource_field_mapping_file RESOURCE_FIELD_MAPPING_FILE
                        Resource-level field mapping file in json.
  -v VALUE_MAPPING_FILE, --value_mapping_file VALUE_MAPPING_FILE
                        Value mapping file in json.
  -s SANITIZATION_CONFIG_FILE, --sanitization_config_file SANITIZATION_CONFIG_FILE
                        Sanitization configuration file in json.
  -l {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging level (default: INFO)
  -n, --dry-run         Test mode. Output will be uncompressed jsonlines.
  --cache_dir CACHE_DIR
                        Directory to cache the NCBI taxonomy after processing

Counters:
  --raw_field_usage RAW_FIELD_USAGE
                        File for field usage counts in the raw data
  --raw_value_usage RAW_VALUE_USAGE
                        File for value usage counts in the raw data
  --mapped_field_usage MAPPED_FIELD_USAGE
                        File for counts of how many times each BPA field was
                        mapped to an AToL field
  --mapped_value_usage MAPPED_VALUE_USAGE
                        File for counts of the values mapped from BPA fields
                        to AToL fields
  --unused_field_counts UNUSED_FIELD_COUNTS
                        File for counts of fields in the BPA data that weren't
                        used

Mapping options:
  --mapping_log MAPPING_LOG
                        Compressed CSV file to record the mapping used for
                        each package
  --sanitization_changes SANITIZATION_CHANGES
                        File to record the sanitization changes made during
                        mapping
  --grouping_log GROUPING_LOG
                        Compressed CSV file to record derived organism info
                        for each package
  --grouped_packages GROUPED_PACKAGES
                        JSON file of Package IDs grouped by organism
                        grouping_key
```

