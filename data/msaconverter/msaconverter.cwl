cwlVersion: v1.2
class: CommandLineTool
baseCommand: msaconverter
label: msaconverter
doc: "Convert multiple-sequence-alignment into different formats.\n\nTool homepage:
  https://github.com/linzhi2013/msaconverter"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: input msa file
    inputBinding:
      position: 101
      prefix: -i
  - id: input_format
    type:
      - 'null'
      - string
    doc: input msa format
    default: fasta
    inputBinding:
      position: 101
      prefix: -p
  - id: molecule_type
    type:
      - 'null'
      - string
    doc: Molecule types
    default: DNA
    inputBinding:
      position: 101
      prefix: -t
  - id: output_format
    type:
      - 'null'
      - string
    doc: input msa format
    default: phylip-relaxed
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output msa file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msaconverter:0.0.4--pyhdfd78af_0
