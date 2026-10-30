cwlVersion: v1.2
class: CommandLineTool
baseCommand: SnifflesVcfFix
label: ngs-bits_SnifflesVcfFix
doc: "Fixes VCF file from Sniffles SV Caller. Converts lowEvidence variants into het variants.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF file. If unset, reads from STDIN."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output VCF list. If unset, writes to STDOUT."
    inputBinding:
      position: 2
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 3
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output VCF list. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
