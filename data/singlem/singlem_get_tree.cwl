cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - singlem
  - get_tree
label: singlem_get_tree
doc: "Extract path to Newick tree file in a SingleM package.\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: singlem_packages
    type:
      - 'null'
      - type: array
        items: string
    doc: SingleM packages to use
    inputBinding:
      position: 101
      prefix: --singlem-packages
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
stdout: singlem_get_tree.out
