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
  - id: output_dir_path
    type: string
    inputBinding:
      position: 107
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
