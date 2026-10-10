cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz-tools
  - circle_check
label: mitoz_tools_circle_check
doc: "Check whether sequences of length >= 12 Kbp are circular. Writes <outPrefix>.mitogenome.fa (sequence ids carry topology=circular or topology=linear; the overlapping region of circular sequences is removed), <outPrefix>.start2end_for-circular-mt-only and <outPrefix>.overlap_information.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: "input fasta file"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_prefix
    type: string
    doc: "output prefix"
    inputBinding:
      position: 2
      prefix: -o
  - id: mismatch
    type:
      - 'null'
      - int
    doc: "mismatch allowed in the overlapping region [3]"
    inputBinding:
      position: 3
      prefix: -m
outputs:
  - id: mitogenome
    type: File
    doc: "All input sequences, with topology in the id line."
    outputBinding:
      glob: $(inputs.output_prefix).mitogenome.fa
  - id: start2end
    type:
      - 'null'
      - File
    doc: "Circular sequences only, with the first 300 bp moved to the end."
    outputBinding:
      glob: $(inputs.output_prefix).start2end_for-circular-mt-only
  - id: overlap_information
    type:
      - 'null'
      - File
    doc: "Overlapping sequence detected for the circular sequences."
    outputBinding:
      glob: $(inputs.output_prefix).overlap_information
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
