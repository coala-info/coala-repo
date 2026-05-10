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
  - id: out_dir_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `out_dir_path`
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: out_folder_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `out_folder_path`
    inputBinding:
      position: 103
      prefix: --out-folder
  - id: output_path2
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path2`
    inputBinding:
      position: 104
      prefix: --output
  - id: output_dir_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 105
      prefix: --output-dir
  - id: output_folder_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `output_folder_path`
    inputBinding:
      position: 106
      prefix: --output-folder
  - id: output_location_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_location_path`
    inputBinding:
      position: 107
      prefix: --output-location
  - id: output_path_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path_path`
    inputBinding:
      position: 108
      prefix: --output-path
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
