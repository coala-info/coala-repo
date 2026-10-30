cwlVersion: v1.2
class: CommandLineTool
baseCommand: TsvToQC
label: ngs-bits_TsvToQC
doc: "Converts TSV file to a qcML file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input TSV file with two columns (QC term accession and value). If unset, reads from STDIN."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output qcML file. If unset, writes to STDOUT."
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
  - id: sources
    type: File[]
    doc: "Source files the QC terms were extracted from."
    inputBinding:
      position: 4
      prefix: -sources
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output qcML file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
