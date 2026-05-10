cwlVersion: v1.2
class: CommandLineTool
baseCommand: build_lmer_table
label: repeatscout_build_lmer_table
doc: "Builds a table of lmers from a sequence.\n\nTool homepage: https://github.com/Dfam-consortium/RepeatScout"
inputs:
  - id: l
    type: int
    doc: Length of lmers to consider
    inputBinding:
      position: 101
      prefix: -l
  - id: min_lmers
    type:
      - 'null'
      - int
    doc: smallest number of required lmers
    inputBinding:
      position: 101
      prefix: -min
  - id: sequence
    type: File
    doc: Input sequence file
    inputBinding:
      position: 101
  - id: tandem
    type:
      - 'null'
      - int
    doc: tandem distance window
    inputBinding:
      position: 101
      prefix: -tandem
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: output a small amount of debugging information.
    inputBinding:
      position: 101
      prefix: -v
  - id: freq_path
    type: string
    doc: Output or path parameter `freq_path`
    inputBinding:
      position: 102
      prefix: --freq
outputs:
  - id: freq
    type: File
    doc: Output frequency table file
    outputBinding:
      glob: $(inputs.freq_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
