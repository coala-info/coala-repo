cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - metadata-homogeneizer
label: relecov-tools_metadata-homogeneizer
doc: "Parse institution metadata lab to the one used in relecov\n\nTool homepage:
  https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Folder where are located the additional files
    inputBinding:
      position: 101
      prefix: --directory
  - id: institution
    type:
      - 'null'
      - string
    doc: select one of the available institution options
    inputBinding:
      position: 101
      prefix: --institution
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
