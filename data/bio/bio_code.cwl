cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bio
  - code
label: bio_code
doc: "Biostar Workflows: https://www.biostarhandbook.com/\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: update
    type:
      - 'null'
      - boolean
    doc: update existing files
    inputBinding:
      position: 1
      prefix: --update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: code_dir
    type: Directory
    doc: Biostar Handbook code folder
    outputBinding:
      glob: src
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_code.out
