cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmpress
label: infernal_cmpress
doc: "prepare a covariance model database for cmscan\n\nTool homepage: http://eddylab.org/infernal"
inputs:
  - id: cmfile
    type: File
    doc: The covariance model file to press
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: force; overwrite any previous press files
    inputBinding:
      position: 102
      prefix: -F
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmpress.out
