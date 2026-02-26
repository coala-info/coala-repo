cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - quota_del
label: nebulizer_quota_del
doc: "Deletes QUOTA from GALAXY.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: Galaxy instance identifier
    inputBinding:
      position: 1
  - id: quota
    type: string
    doc: Quota identifier
    inputBinding:
      position: 2
  - id: yes
    type:
      - 'null'
      - boolean
    doc: don't ask for confirmation of deletions.
    inputBinding:
      position: 103
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_quota_del.out
