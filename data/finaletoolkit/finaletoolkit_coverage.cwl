cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit_coverage
label: finaletoolkit_coverage
doc: "Calculates fragmentation coverage over intervals defined in a BED file based
  on alignment data from a BAM/CRAM/Fragment file.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: Path to a BAM/CRAM/Fragment file containing fragment data.
    inputBinding:
      position: 1
  - id: interval_file
    type: File
    doc: Path to a BED file containing intervals to calculate coverage over.
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
    doc: Maximum length for a fragment to be included in coverage.
    inputBinding:
      position: 103
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length for a fragment to be included in coverage.
    inputBinding:
      position: 103
      prefix: --min-length
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: If flag set, multiplies by user inputed scale factor if given and 
      normalizes output by total coverage. May lead to longer execution time for
      high-throughput data.
    inputBinding:
      position: 103
      prefix: --normalize
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Minimum mapping quality threshold.
    inputBinding:
      position: 103
      prefix: --quality-threshold
  - id: scale_factor
    type:
      - 'null'
      - float
    doc: Scale factor for coverage values.
    default: 1
    inputBinding:
      position: 103
      prefix: --scale-factor
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
    doc: A BED file containing coverage values over the intervals specified in 
      interval file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
