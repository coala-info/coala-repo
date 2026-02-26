cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - read-bioinfo-metadata
label: relecov-tools_read-bioinfo-metadata
doc: "Create the json compliant from the Bioinfo Metadata.\n\nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: input_folder
    type:
      - 'null'
      - Directory
    doc: Path to input files
    inputBinding:
      position: 101
      prefix: --input_folder
  - id: json_file
    type:
      - 'null'
      - File
    doc: json file containing lab metadata
    inputBinding:
      position: 101
      prefix: --json_file
  - id: json_schema_file
    type:
      - 'null'
      - string
    doc: Path to the JSON Schema file used for validation
    inputBinding:
      position: 101
      prefix: --json_schema_file
  - id: soft_validation
    type:
      - 'null'
      - boolean
    doc: If the module should continue even if any sample does not validate.
    inputBinding:
      position: 101
      prefix: --soft_validation
  - id: software_name
    type:
      - 'null'
      - string
    doc: Name of the software/pipeline used.
    inputBinding:
      position: 101
      prefix: --software_name
  - id: update
    type:
      - 'null'
      - boolean
    doc: If the output file already exists, ask if you want to update it.
    inputBinding:
      position: 101
      prefix: --update
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
