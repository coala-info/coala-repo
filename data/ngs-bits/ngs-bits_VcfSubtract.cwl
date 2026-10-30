cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfSubtract
label: ngs-bits_VcfSubtract
doc: "Substracts the variants in a VCF from a second VCF.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: in2
    type: File
    doc: "Variants in VCF format that are remove from 'in'"
    inputBinding:
      position: 1
      prefix: -in2
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF file from which the variants of 'in2' are substracted."
    inputBinding:
      position: 2
      prefix: -in
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output VCF file with variants from 'in2' removed from 'in'."
    inputBinding:
      position: 3
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 4
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output VCF file with variants from 'in2' removed from 'in'."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
