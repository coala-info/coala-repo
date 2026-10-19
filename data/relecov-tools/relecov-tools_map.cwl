cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - map
label: relecov-tools_map
doc: "Convert data between phage plus schema to ENA, GISAID, or any other schema\n\
  \nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: destination_schema
    type:
      - 'null'
      - string
    doc: schema to be mapped
    inputBinding:
      position: 101
      prefix: --destination_schema
  - id: json_data
    type:
      - 'null'
      - File
    doc: File with the json data to convert
    inputBinding:
      position: 101
      prefix: --json_data
  - id: origin_schema
    type:
      - 'null'
      - File
    doc: File with the origin (relecov) schema
    inputBinding:
      position: 101
      prefix: --origin_schema
  - id: schema_file
    type:
      - 'null'
      - File
    doc: file with the custom schema
    inputBinding:
      position: 101
      prefix: --schema_file
  - id: output_dir_path
    type: string
    inputBinding:
      position: 110
      prefix: --output_dir
    doc: Directory where the generated output will be saved
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
