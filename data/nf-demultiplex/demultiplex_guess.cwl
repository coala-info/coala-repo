cwlVersion: v1.2
class: CommandLineTool
baseCommand: demultiplex guess
label: demultiplex_guess
doc: "Retrieve the most frequent barcodes.\n\nTool homepage: https://github.com/jfjlaros/demultiplex"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: end
    type:
      - 'null'
      - string
    doc: end of the selection
    default: None
    inputBinding:
      position: 102
      prefix: -e
  - id: extract_barcodes
    type:
      - 'null'
      - boolean
    doc: extract the barcodes from the read
    default: false
    inputBinding:
      position: 102
      prefix: -r
  - id: format
    type:
      - 'null'
      - string
    doc: provdide the header format
    default: None
    inputBinding:
      position: 102
      prefix: --format
  - id: sample_size
    type:
      - 'null'
      - int
    doc: sample size
    default: 1000000
    inputBinding:
      position: 102
      prefix: -n
  - id: select_on_frequency
    type:
      - 'null'
      - boolean
    doc: select on frequency instead of a fixed amount
    default: false
    inputBinding:
      position: 102
      prefix: -f
  - id: start
    type:
      - 'null'
      - string
    doc: start of the selection
    default: None
    inputBinding:
      position: 102
      prefix: -s
  - id: threshold
    type:
      - 'null'
      - int
    doc: threshold for the selection method
    default: 12
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1
