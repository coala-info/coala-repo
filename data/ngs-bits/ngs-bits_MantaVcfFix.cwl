cwlVersion: v1.2
class: CommandLineTool
baseCommand: MantaVcfFix
label: ngs-bits_MantaVcfFix
doc: "Fixes issues in VCF of Manta SV calls.\n\nRemoves invalid VCF lines containing empty REF entries.\nRemoves duplicate SV calls from Manta VCFs.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - File
    doc: "Input VCF file."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_file_path
    type:
      - string
    doc: "Output VCF file."
    inputBinding:
      position: 2
      prefix: -out
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Print verbose output to STDERR."
    inputBinding:
      position: 3
      prefix: -debug
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 100
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Fixed output VCF file."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
