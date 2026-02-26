cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oakvar
  - ov
  - module
  - update
label: oakvar_ov module update
doc: "updates modules.\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: module_name_patterns
    type:
      - 'null'
      - type: array
        items: string
    doc: Modules to update.
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress stodout output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Proceed without prompt
    inputBinding:
      position: 102
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov module update.out
