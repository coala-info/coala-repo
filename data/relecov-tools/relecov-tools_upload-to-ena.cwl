cwlVersion: v1.2
class: CommandLineTool
baseCommand: relecov-tools upload-to-ena
label: relecov-tools_upload-to-ena
doc: "parse data to create xml files to upload to ena\n\nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: action
    type:
      - 'null'
      - string
    doc: select one of the available options
    inputBinding:
      position: 101
      prefix: --action
  - id: center
    type:
      - 'null'
      - string
    doc: center name
    inputBinding:
      position: 101
      prefix: --center
  - id: dev
    type:
      - 'null'
      - boolean
    doc: Test submission
    inputBinding:
      position: 101
      prefix: --dev
  - id: ena_json
    type:
      - 'null'
      - string
    doc: where the validated json is
    inputBinding:
      position: 101
      prefix: --ena_json
  - id: metadata_types
    type:
      - 'null'
      - type: array
        items: string
    doc: List of metadata xml types to submit
    inputBinding:
      position: 101
      prefix: --metadata_types
  - id: password
    type:
      - 'null'
      - string
    doc: password for the user to login
    inputBinding:
      position: 101
      prefix: --password
  - id: template_path
    type:
      - 'null'
      - string
    doc: Path to ENA templates folder
    inputBinding:
      position: 101
      prefix: --template_path
  - id: upload_fastq
    type:
      - 'null'
      - boolean
    doc: Upload fastq files
    inputBinding:
      position: 101
      prefix: --upload_fastq
  - id: user
    type:
      - 'null'
      - string
    doc: user name for login to ena
    inputBinding:
      position: 101
      prefix: --user
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
