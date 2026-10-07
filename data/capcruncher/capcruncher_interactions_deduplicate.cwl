cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
  - deduplicate
label: capcruncher_interactions_deduplicate
doc: "Identifies and removes duplicated aligned fragments. Unlike fastq deduplicate, this command removes fragments with identical genomic coordinates.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: slices
    type:
      - File
      - Directory
    doc: "Slices to deduplicate (parquet file or directory)"
    inputBinding:
      position: 1
  - id: output
    type: string
    default: deduplicated_slices
    doc: "Output path for the deduplicated slices (parquet)"
    inputBinding:
      position: 2
      prefix: -o
  - id: statistics
    type:
      - 'null'
      - string
    doc: "Output prefix for stats file(s)"
    inputBinding:
      position: 2
      prefix: --statistics
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Name of sample e.g. DOX_treated_1"
    inputBinding:
      position: 2
      prefix: --sample-name
  - id: read_type
    type:
      - 'null'
      - string
    doc: "Type of read (flashed or pe)"
    inputBinding:
      position: 2
      prefix: --read-type
outputs:
  - id: deduplicated_slices
    type:
      - File
      - Directory
    doc: Deduplicated slices (parquet)
    outputBinding:
      glob: $(inputs.output)
  - id: statistics_files
    type:
      type: array
      items: File
    doc: "Deduplication statistics"
    outputBinding:
      glob: '$(inputs.statistics ? inputs.statistics + "*" : [])'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
