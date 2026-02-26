cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit frag-length-intervals
label: finaletoolkit_frag-length-intervals
doc: "Retrieves fragment length summary statistics over intervals defined in a BED
  file based on alignment data from a BAM/CRAM/Fragment file.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: Path to a BAM/CRAM/Fragment file containing fragment data.
    inputBinding:
      position: 1
  - id: interval_file
    type: File
    doc: Path to a BED file containing intervals to retrieve fragment length 
      summary statistics over.
    inputBinding:
      position: 2
  - id: intersect_policy
    type:
      - 'null'
      - string
    doc: Specifies what policy is used to include fragments in the given 
      interval. See User Guide for more information.
    inputBinding:
      position: 103
      prefix: --intersect-policy
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length for a fragment to be included in fragment length.
    inputBinding:
      position: 103
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length for a fragment to be included in fragment length.
    inputBinding:
      position: 103
      prefix: --min-length
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Minimum mapping quality threshold.
    inputBinding:
      position: 103
      prefix: --quality-threshold
  - id: short_reads
    type:
      - 'null'
      - int
    doc: Threshold for short read fraction. Default is 150.
    default: 150
    inputBinding:
      position: 103
      prefix: --short-reads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode to display detailed processing information.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 103
      prefix: --workers
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: A BED file containing fragment length summary statistics (mean, median,
      st. dev, min, max) over the intervals specified in the interval file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
