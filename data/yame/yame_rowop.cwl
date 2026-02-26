cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - rowop
label: yame_rowop
doc: "Perform row-wise operations across multiple records (samples) in a CX file.\n\
  \  Depending on the operation, output is either a new CX file or plain text.\n\n\
  Tool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cx_file
    type: File
    doc: Input CX file
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: Output file name (defaults to stdout for text operations)
    inputBinding:
      position: 2
  - id: beta0_threshold
    type:
      - 'null'
      - float
    doc: Call unmethylated if beta < beta0 (for binasum with fmt3 input)
    default: 0.4
    inputBinding:
      position: 103
      prefix: -p
  - id: beta1_threshold
    type:
      - 'null'
      - float
    doc: Call methylated if beta > beta1 (for binasum with fmt3 input)
    default: 0.6
    inputBinding:
      position: 103
      prefix: -q
  - id: binstring_threshold
    type:
      - 'null'
      - float
    doc: Call methylated if beta > threshold (for binstring operation)
    default: 0.5
    inputBinding:
      position: 103
      prefix: -b
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage (M+U) for a sample/row to contribute
    default: 1
    inputBinding:
      position: 103
      prefix: -c
  - id: neighbor_window_size
    type:
      - 'null'
      - int
    doc: Neighbor window size (for cometh operation)
    default: 5
    inputBinding:
      position: 103
      prefix: -w
  - id: operation
    type:
      - 'null'
      - string
    doc: Operation name
    default: binasum
    inputBinding:
      position: 103
      prefix: -o
  - id: tie_breaking_seed
    type:
      - 'null'
      - int
    doc: Seed for tie breaking (for binstring operation)
    default: current time
    inputBinding:
      position: 103
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (print UU-UM-MU-MM instead of packed uint64) (for cometh
      operation)
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
stdout: yame_rowop.out
