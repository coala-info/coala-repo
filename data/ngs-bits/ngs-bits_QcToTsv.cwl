cwlVersion: v1.2
class: CommandLineTool
baseCommand: QcToTsv
label: ngs-bits_QcToTsv
doc: "Converts qcML files to a TSV file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input qcML files.
    inputBinding:
      position: 101
      prefix: -in
  - id: obo_file
    type:
      - 'null'
      - File
    doc: OBO file to use. If unset, uses the default file compiled into 
      ngs-bits.
    default: ''
    inputBinding:
      position: 101
      prefix: -obo
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: tool_definition_xml
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output TSV file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
