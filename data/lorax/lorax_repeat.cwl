cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorax repeat
label: lorax_repeat
doc: "Finds tandem repeats in a reference genome.\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: ref_fa
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 1
  - id: chromosome_end_window
    type:
      - 'null'
      - int
    doc: 'chromosome end window [0: deactivate]'
    default: 0
    inputBinding:
      position: 102
      prefix: --chrend
  - id: min_chromosome_length
    type:
      - 'null'
      - int
    doc: min. chromosome length
    default: 40000000
    inputBinding:
      position: 102
      prefix: --chrlen
  - id: nomix
    type:
      - 'null'
      - boolean
    doc: do not mix repeat units
    inputBinding:
      position: 102
      prefix: --nomix
  - id: repeat_period
    type:
      - 'null'
      - int
    doc: repeat period
    default: 3
    inputBinding:
      position: 102
      prefix: --period
  - id: repeat_units
    type:
      - 'null'
      - type: array
        items: string
    doc: repeat units
    default: TTAGGG,TCAGGG,TGAGGG,TTGGGG
    inputBinding:
      position: 102
      prefix: --repeats
  - id: window_length
    type:
      - 'null'
      - int
    doc: window length
    default: 1000
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
