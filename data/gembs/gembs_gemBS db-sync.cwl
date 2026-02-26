cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - db-sync
label: gembs_gemBS db-sync
doc: "Synchronize database with filesystem\n\nTool homepage: https://github.com/heathsc/gemBS"
inputs:
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Confirm operation
    inputBinding:
      position: 101
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
stdout: gembs_gemBS db-sync.out
