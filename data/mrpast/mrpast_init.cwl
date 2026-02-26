cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast init
label: mrpast_init
doc: "Initialize a mrpast model.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: from_demes
    type:
      - 'null'
      - File
    doc: Convert a Demes YAML file into a mrpast model.
    inputBinding:
      position: 101
      prefix: --from-demes
  - id: from_old_mrpast
    type:
      - 'null'
      - File
    doc: Convert an old matrix-based mrpast YAML file into a current mrpast 
      model.
    inputBinding:
      position: 101
      prefix: --from-old-mrpast
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_init.out
