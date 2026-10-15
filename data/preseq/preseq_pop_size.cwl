cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preseq
  - pop_size
label: preseq_pop_size
doc: "The pop_size command in preseq estimates the number of unique species (population size) of a library.

Tool homepage: https://github.com/smithlabcode/preseq"
inputs:
  - id: input_file
    type: File
    doc: "Input file: BED or MR reads sorted by position, a BAM file (with -B), a count histogram (-H) or counts only (-V)"
    inputBinding:
      position: 200
  - id: extrap
    type:
      - 'null'
      - float
    doc: "Maximum extrapolation [0.0]"
    inputBinding:
      position: 102
      prefix: -e
  - id: steps
    type:
      - 'null'
      - int
    doc: "Number of steps [50]"
    inputBinding:
      position: 102
      prefix: -s
  - id: boots
    type:
      - 'null'
      - int
    doc: "Number of bootstraps [100]"
    inputBinding:
      position: 102
      prefix: -n
  - id: cval
    type:
      - 'null'
      - float
    doc: "Level for confidence intervals [0.95]"
    inputBinding:
      position: 102
      prefix: -c
  - id: terms
    type:
      - 'null'
      - int
    doc: "Maximum terms in estimator [100]"
    inputBinding:
      position: 102
      prefix: -x
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print more information"
    inputBinding:
      position: 102
      prefix: -v
  - id: bam_input
    type:
      - 'null'
      - boolean
    doc: "Input is in BAM format"
    inputBinding:
      position: 102
      prefix: -B
  - id: seg_len
    type:
      - 'null'
      - int
    doc: "Maximum segment length when merging paired end bam reads [5000]"
    inputBinding:
      position: 102
      prefix: -l
  - id: pe_input
    type:
      - 'null'
      - boolean
    doc: "Input is a paired end read file"
    inputBinding:
      position: 102
      prefix: -P
  - id: vals_input
    type:
      - 'null'
      - boolean
    doc: "Input is a text file containing only the observed counts"
    inputBinding:
      position: 102
      prefix: -V
  - id: hist_input
    type:
      - 'null'
      - boolean
    doc: "Input is a text file containing the observed histogram"
    inputBinding:
      position: 102
      prefix: -H
  - id: quick
    type:
      - 'null'
      - boolean
    doc: "Quick mode (no bootstraps) for confidence intervals"
    inputBinding:
      position: 102
      prefix: -Q
  - id: defects
    type:
      - 'null'
      - boolean
    doc: "No testing for defects"
    inputBinding:
      position: 102
      prefix: -D
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator [408]"
    inputBinding:
      position: 102
      prefix: -r
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Output file name (default: stdout)"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Population size estimate table"
    outputBinding:
      glob: "$(inputs.output_file_path ? inputs.output_file_path : 'no_output_file')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq_pop_size.out
