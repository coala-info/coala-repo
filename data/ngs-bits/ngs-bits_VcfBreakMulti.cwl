cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfBreakMulti
label: ngs-bits_VcfBreakMulti
doc: "Breaks multi-allelic variants into several lines, making sure that allele-specific INFO/SAMPLE fields are still valid.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF file. If unset, reads from STDIN."
    inputBinding:
      position: 1
      prefix: -in
  - id: no_errors
    type:
      - 'null'
      - boolean
    doc: "Ignore VCF format errors if possible."
    inputBinding:
      position: 2
      prefix: -no_errors
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output VCF list. If unset, writes to STDOUT."
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
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Writes ignored VCF format errors to stderr."
    inputBinding:
      position: 5
      prefix: -verbose
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
