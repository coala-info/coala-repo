cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobs print-parameters
label: cobs_print-parameters
doc: "Prints parameters for COBS.\n\nTool homepage: https://panthema.net/cobs"
inputs:
  - id: false_positive_rate
    type:
      - 'null'
      - float
    doc: false positive rate
    default: 0.3
    inputBinding:
      position: 101
      prefix: --false-positive-rate
  - id: num_elements
    type:
      - 'null'
      - int
    doc: number of elements to be inserted into the index
    inputBinding:
      position: 101
      prefix: --num-elements
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: number of hash functions
    default: 1
    inputBinding:
      position: 101
      prefix: --num-hashes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
stdout: cobs_print-parameters.out
