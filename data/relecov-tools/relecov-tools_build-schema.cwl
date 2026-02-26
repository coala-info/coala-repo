cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - build-schema
label: relecov-tools_build-schema
doc: "Generates and updates JSON Schema files from Excel-based database definitions.\n\
  \nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: diff
    type:
      - 'null'
      - boolean
    doc: Prints a changelog/diff between the base and incoming versions of the 
      schema.
    inputBinding:
      position: 101
      prefix: --diff
  - id: draft_version
    type:
      - 'null'
      - string
    doc: "Version of the JSON schema specification to be used. Example: '2020-12'.
      See: https://json-schema.org/specification-links"
    inputBinding:
      position: 101
      prefix: --draft_version
  - id: excel_template
    type:
      - 'null'
      - File
    doc: Path to the excel template file. This file is used to get version 
      history of the excel template (stored in assets/Relecov_metadata_*.xlsx)
    inputBinding:
      position: 101
      prefix: --excel_template
  - id: input_file
    type: File
    doc: Path to the Excel document containing the database definition. This 
      file must have a .xlsx extension.
    inputBinding:
      position: 101
      prefix: --input_file
  - id: non_interactive
    type:
      - 'null'
      - boolean
    doc: Run the script without user interaction, using default values.
    inputBinding:
      position: 101
      prefix: --non-interactive
  - id: project
    type:
      - 'null'
      - string
    doc: Specficy the project to build the metadata template.
    inputBinding:
      position: 101
      prefix: --project
  - id: schema_base
    type:
      - 'null'
      - File
    doc: Path to the base schema file. This file is used as a reference to 
      compare it with the schema generated using this module.
    default: installed schema in 'relecov-tools 
      /relecov_tools/schema/relecov_schema.json'
    inputBinding:
      position: 101
      prefix: --schema_base
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
