cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - quotas
label: nebulizer_quotas
doc: "List quotas in Galaxy instance.\n\n  Prints details of quotas in GALAXY instance.\n\
  \nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: GALAXY instance
    inputBinding:
      position: 1
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: "use a long listing format that includes lists\n                        \
      \         of associated users and groups."
    inputBinding:
      position: 102
      prefix: --long
  - id: name
    type:
      - 'null'
      - string
    doc: "list only quotas with matching name. Can\n                             \
      \    include glob-style wild-cards."
    inputBinding:
      position: 102
      prefix: --name
  - id: status
    type:
      - 'null'
      - string
    doc: "list quotas with the specified status; can be\n                        \
      \         one of 'active', 'deleted', 'all' (default:\n                    \
      \             'active')"
    default: active
    inputBinding:
      position: 102
      prefix: --status
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_quotas.out
