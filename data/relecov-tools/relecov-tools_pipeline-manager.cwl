cwlVersion: v1.2
class: CommandLineTool
baseCommand: relecov-tools pipeline-manager
label: relecov-tools_pipeline-manager
doc: "Create the symbolic links for the samples which are validated to prepare for
  bioinformatics pipeline execution.\n\nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: folder_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Folder basenames to process. Target folders names should match the 
      given dates. E.g. ... -f folder1 -f folder2 -f folder3
    inputBinding:
      position: 101
      prefix: --folder_names
  - id: input_folder
    type:
      - 'null'
      - Directory
    doc: select input folder where are located the sample files
    inputBinding:
      position: 101
      prefix: --input
  - id: skip_db_upload
    type:
      - 'null'
      - boolean
    doc: Skip the database upload step. This is useful for testing purposes.
    inputBinding:
      position: 101
      prefix: --skip_db_upload
  - id: templates_root
    type:
      - 'null'
      - Directory
    doc: Path to folder containing the pipeline templates from buisciii-tools
    inputBinding:
      position: 101
      prefix: --templates_root
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
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
