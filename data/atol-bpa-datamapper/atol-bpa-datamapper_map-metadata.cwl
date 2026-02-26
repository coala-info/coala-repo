cwlVersion: v1.2
class: CommandLineTool
baseCommand: map-metadata
label: atol-bpa-datamapper_map-metadata
doc: "Map metadata in filtered jsonlines.gz\n\nTool homepage: https://github.com/TomHarrop/atol-bpa-datamapper"
inputs:
  - id: nodes
    type: File
    doc: NCBI nodes.dmp file from taxdump
    inputBinding:
      position: 1
  - id: names
    type: File
    doc: NCBI names.dmp file from taxdump
    inputBinding:
      position: 2
  - id: taxids_to_busco_dataset_mapping
    type: File
    doc: BUSCO placement file from 
      https://busco-data.ezlab.org/v5/data/placement_files/
    inputBinding:
      position: 3
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Directory to cache the NCBI taxonomy after processing
    inputBinding:
      position: 104
      prefix: --cache_dir
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Test mode. Output will be uncompressed jsonlines.
    inputBinding:
      position: 104
      prefix: --dry-run
  - id: input
    type:
      - 'null'
      - File
    doc: Input file
    default: stdin
    inputBinding:
      position: 104
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level
    default: INFO
    inputBinding:
      position: 104
      prefix: --log-level
  - id: package_field_mapping_file
    type:
      - 'null'
      - File
    doc: Package-level field mapping file in json.
    inputBinding:
      position: 104
      prefix: --package_field_mapping_file
  - id: resource_field_mapping_file
    type:
      - 'null'
      - File
    doc: Resource-level field mapping file in json.
    inputBinding:
      position: 104
      prefix: --resource_field_mapping_file
  - id: sanitization_config_file
    type:
      - 'null'
      - File
    doc: Sanitization configuration file in json.
    inputBinding:
      position: 104
      prefix: --sanitization_config_file
  - id: taxids_to_augustus_dataset_mapping
    type:
      - 'null'
      - File
    doc: File that maps Augustus datasets to NCBI TaxIDs. See 
      config/taxid_to_augustus_dataset.tsv
    inputBinding:
      position: 104
      prefix: --taxids_to_augustus_dataset_mapping
  - id: value_mapping_file
    type:
      - 'null'
      - File
    doc: Value mapping file in json.
    inputBinding:
      position: 104
      prefix: --value_mapping_file
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
  - id: raw_field_usage
    type:
      - 'null'
      - File
    doc: File for field usage counts in the raw data
    outputBinding:
      glob: $(inputs.raw_field_usage)
  - id: raw_value_usage
    type:
      - 'null'
      - File
    doc: File for value usage counts in the raw data
    outputBinding:
      glob: $(inputs.raw_value_usage)
  - id: mapped_field_usage
    type:
      - 'null'
      - File
    doc: File for counts of how many times each BPA field was mapped to an AToL 
      field
    outputBinding:
      glob: $(inputs.mapped_field_usage)
  - id: mapped_value_usage
    type:
      - 'null'
      - File
    doc: File for counts of the values mapped from BPA fields to AToL fields
    outputBinding:
      glob: $(inputs.mapped_value_usage)
  - id: unused_field_counts
    type:
      - 'null'
      - File
    doc: File for counts of fields in the BPA data that weren't used
    outputBinding:
      glob: $(inputs.unused_field_counts)
  - id: mapping_log
    type:
      - 'null'
      - File
    doc: Compressed CSV file to record the mapping used for each package
    outputBinding:
      glob: $(inputs.mapping_log)
  - id: sanitization_changes
    type:
      - 'null'
      - File
    doc: File to record the sanitization changes made during mapping
    outputBinding:
      glob: $(inputs.sanitization_changes)
  - id: grouping_log
    type:
      - 'null'
      - File
    doc: Compressed CSV file to record derived organism info for each package
    outputBinding:
      glob: $(inputs.grouping_log)
  - id: grouped_packages
    type:
      - 'null'
      - File
    doc: JSON file of Package IDs grouped by organism grouping_key
    outputBinding:
      glob: $(inputs.grouped_packages)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-bpa-datamapper:0.2.0--pyhdfd78af_0
