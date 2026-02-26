cwlVersion: v1.2
class: CommandLineTool
baseCommand: automappa
label: automappa
doc: "A tool for mapping and analyzing genomic data.\n\nTool homepage: https://github.com/WiscEvan/Automappa"
inputs:
  - id: root_upload_folder
    type: Directory
    doc: The root folder for uploading data.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/automappa:2.2.1--pyhdfd78af_0
stdout: automappa.out
