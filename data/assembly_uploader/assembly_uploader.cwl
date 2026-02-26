cwlVersion: v1.2
class: CommandLineTool
baseCommand: assembly_uploader
label: assembly_uploader
doc: "Upload assembled sequences to a remote repository.\n\nTool homepage: https://github.com/EBI-Metagenomics/assembly_uploader"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more assembly files to upload.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files in the repository if they have the same name.
    inputBinding:
      position: 102
      prefix: --force
  - id: password
    type:
      - 'null'
      - string
    doc: Password for authentication with the repository.
    inputBinding:
      position: 102
      prefix: --password
  - id: repository_url
    type: string
    doc: URL of the remote repository.
    inputBinding:
      position: 102
      prefix: --repository-url
  - id: username
    type:
      - 'null'
      - string
    doc: Username for authentication with the repository.
    inputBinding:
      position: 102
      prefix: --username
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Local directory to store uploaded file metadata.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblycomparator2:2.7.1--hdfd78af_2
