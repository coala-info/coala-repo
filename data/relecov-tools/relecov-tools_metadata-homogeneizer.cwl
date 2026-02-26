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
