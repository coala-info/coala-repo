cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio_code
label: bio_code
doc: "Biostar Workflows: https://www.biostarhandbook.com/\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of files to be written
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_code.out
