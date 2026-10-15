cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preseq
  - gc_extrap
label: preseq_gc_extrap
doc: "The gc_extrap command in preseq predicts the genome coverage of future sequencing of a low-input library.

Tool homepage: https://github.com/smithlabcode/preseq"
inputs:
  - id: input_file
    type: File
    doc: "Input file: BED reads sorted by position (or MR format)"
    inputBinding:
      position: 200
  - id: max_width
    type:
      - 'null'
      - int
    doc: "Max fragment length, set equal to read length for single end reads [10000]"
    inputBinding:
      position: 102
      prefix: -w
  - id: bin_size
    type:
      - 'null'
      - int
    doc: "Bin size [10]"
    inputBinding:
      position: 102
      prefix: -b
  - id: extrap
    type:
      - 'null'
      - float
    doc: "Maximum extrapolation in base pairs [1000000000000]"
    inputBinding:
      position: 102
      prefix: -e
  - id: step_size
    type:
      - 'null'
      - float
    doc: "Step size in bases between extrapolations [100000000]"
    inputBinding:
      position: 102
      prefix: -s
  - id: bootstraps
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
    doc: "Maximum number of terms [100]"
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
  - id: bed_input
    type:
      - 'null'
      - boolean
    doc: "Input is in bed format without sequence information"
    inputBinding:
      position: 102
      prefix: -B
  - id: quick
    type:
      - 'null'
      - boolean
    doc: "Quick mode: run gc_extrap without bootstrapping for confidence intervals"
    inputBinding:
      position: 102
      prefix: -Q
  - id: defects
    type:
      - 'null'
      - boolean
    doc: "Defects mode to extrapolate without testing for defects"
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
    doc: "Coverage yield table"
    outputBinding:
      glob: "$(inputs.output_file_path ? inputs.output_file_path : 'no_output_file')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq_gc_extrap.out
