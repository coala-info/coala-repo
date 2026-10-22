cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - info
label: taxtastic_taxit_info
doc: "Show information about a reference package\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: seq_names
    type:
      - 'null'
      - boolean
    doc: 'Print a list of sequence names'
    inputBinding:
      position: 1
      prefix: --seq-names
  - id: tally
    type:
      - 'null'
      - boolean
    doc: 'Print a tally of sequences representing each taxon at rank RANK'
    inputBinding:
      position: 1
      prefix: --tally
  - id: lengths
    type:
      - 'null'
      - boolean
    doc: 'Print sequence lengths'
    inputBinding:
      position: 1
      prefix: --lengths
  - id: refpkg
    type: Directory
    doc: 'The reference package to operate on'
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_info.out
