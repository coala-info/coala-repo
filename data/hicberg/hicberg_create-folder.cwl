cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg create-folder
label: hicberg_create-folder
doc: "Create a folder to save results. Folder will be set as <output>/<name>.\n\n\
  Tool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Set if previous analysis files are deleted.
    inputBinding:
      position: 101
      prefix: --force
  - id: name
    type:
      - 'null'
      - string
    doc: Name of the output folder to create. If not set, 'sample' is used.
    inputBinding:
      position: 101
      prefix: --name
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder to save results. If not set, the current directory is 
      used.
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
stdout: hicberg_create-folder.out
