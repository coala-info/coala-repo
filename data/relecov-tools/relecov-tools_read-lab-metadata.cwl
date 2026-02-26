cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - read-lab-metadata
label: relecov-tools_read-lab-metadata
doc: "Create the json compliant to the relecov schema from the Metadata file.\n\n\
  Tool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: files_folder
    type:
      - 'null'
      - Directory
    doc: Path to folder where samples files are located
    inputBinding:
      position: 101
      prefix: --files-folder
  - id: metadata_file
    type: File
    doc: file containing metadata
    inputBinding:
      position: 101
      prefix: --metadata_file
  - id: project
    type:
      - 'null'
      - string
    doc: Project configuration key defined under read_lab_metadata.projects
    inputBinding:
      position: 101
      prefix: --project
  - id: sample_list_file
    type:
      - 'null'
      - File
    doc: Json with the additional metadata to add to the received user metadata
    inputBinding:
      position: 101
      prefix: --sample_list_file
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
