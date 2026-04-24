cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grenedalf
  - citation
label: grenedalf_citation
doc: "Print references to be cited when using grenedalf.\n\nTool homepage: https://github.com/lczech/grenedalf"
inputs:
  - id: keys
    type:
      - 'null'
      - type: array
        items: string
    doc: Only print the citations for the given keys.
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: Print all relevant citations used by commands in grenedalf.
    inputBinding:
      position: 102
      prefix: --all
  - id: format
    type:
      - 'null'
      - string
    doc: Output format for citations.
    inputBinding:
      position: 102
      prefix: --format
  - id: list
    type:
      - 'null'
      - boolean
    doc: List all available citation keys.
    inputBinding:
      position: 102
      prefix: --list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
stdout: grenedalf_citation.out
