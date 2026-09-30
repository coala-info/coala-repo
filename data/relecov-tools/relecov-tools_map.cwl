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
  - id: output_path2
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path2`
    inputBinding:
      position: 104
      prefix: --output
  - id: output_folder_alt_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_folder_alt_path`
    inputBinding:
      position: 107
      prefix: --output-folder-alt
  - id: out_dir_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 108
      prefix: --out_dir
  - id: out_folder_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 109
      prefix: --out-folder
  - id: output_dir_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 110
      prefix: --output_dir
  - id: output_folder_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 111
      prefix: --output_folder
  - id: output_location_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 112
      prefix: --output_location
  - id: output_path_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 113
      prefix: --output_path
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_folder_path)
  - id: output_folder_alt
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_folder_alt_path)
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.out_folder_path)
  - id: output_location
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_location_path)
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_path_path)
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.out_dir_path)
  - id: output
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_path2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
