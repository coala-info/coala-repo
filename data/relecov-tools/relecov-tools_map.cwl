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
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_folder)
  - id: output_folder_alt
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_folder_alt)
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.out_folder)
  - id: output_location
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_location)
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_path)
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.out_dir)
  - id: output
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
