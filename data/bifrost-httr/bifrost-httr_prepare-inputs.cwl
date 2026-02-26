cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bifrost-httr
  - prepare-inputs
label: bifrost-httr_prepare-inputs
doc: "Prepare Bifrost inputs from meta data and counts.\n\nTool homepage: https://github.com/seqera-services/bifrost-httr"
inputs:
  - id: batch_key
    type:
      - 'null'
      - string
    doc: "Field to use as batch key in the BIFROST model (default: 'N/A' - single
      batch for all samples)"
    default: N/A
    inputBinding:
      position: 101
      prefix: --batch-key
  - id: batch_matched_controls
    type:
      - 'null'
      - boolean
    doc: Filter control samples to only those in batches containing treatments
    default: false
    inputBinding:
      position: 101
      prefix: --batch-matched-controls
  - id: config
    type: File
    doc: Path to configuration YAML file
    inputBinding:
      position: 101
      prefix: --config
  - id: counts
    type: File
    doc: Path to counts CSV file
    inputBinding:
      position: 101
      prefix: --counts
  - id: meta_data
    type: File
    doc: Path to meta data CSV file
    inputBinding:
      position: 101
      prefix: --meta-data
  - id: meta_mapper
    type:
      - 'null'
      - File
    doc: "Optional: Path to meta data mapper YAML file. Not needed if metadata columns
      already match BIFROST's internal format."
    inputBinding:
      position: 101
      prefix: --meta-mapper
  - id: min_avg_treatment_count
    type:
      - 'null'
      - int
    doc: Minimum average treatment count required
    default: 5
    inputBinding:
      position: 101
      prefix: --min-avg-treatment-count
  - id: min_num_mapped_reads
    type:
      - 'null'
      - int
    doc: Minimum number of mapped reads required
    default: 100000
    inputBinding:
      position: 101
      prefix: --min-num-mapped-reads
  - id: min_percent_mapped_reads
    type:
      - 'null'
      - float
    doc: Minimum percentage of mapped reads required
    default: 50.0
    inputBinding:
      position: 101
      prefix: --min-percent-mapped-reads
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to store outputs
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
