cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - periodicity
label: riboraptor_periodicity
doc: "Calculate periodicity of Ribo-seq data.\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: input_file
    type: File
    doc: Input Ribo-seq data file (e.g., BAM, BED, TSV).
    inputBinding:
      position: 1
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Maximum read length to consider.
    default: 50
    inputBinding:
      position: 102
      prefix: --max-read-length
  - id: min_period_score
    type:
      - 'null'
      - float
    doc: Minimum score for a period to be considered significant.
    default: 0.5
    inputBinding:
      position: 102
      prefix: --min-period-score
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length to consider.
    default: 20
    inputBinding:
      position: 102
      prefix: --min-read-length
  - id: period_range
    type:
      - 'null'
      - string
    doc: Range of periods to test (e.g., '10-50').
    default: 10-50
    inputBinding:
      position: 102
      prefix: --period-range
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for the sliding window.
    default: 100
    inputBinding:
      position: 102
      prefix: --step-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the sliding window for periodicity calculation.
    default: 1000
    inputBinding:
      position: 102
      prefix: --window-size
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save output files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
