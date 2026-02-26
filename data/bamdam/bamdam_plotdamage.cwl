cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdam_plotdamage
label: bamdam_plotdamage
doc: "Plot damage patterns from substitution files.\n\nTool homepage: https://github.com/bdesanctis/bamdam"
inputs:
  - id: in_subs
    type:
      - 'null'
      - type: array
        items: File
    doc: Input subs file(s)
    inputBinding:
      position: 101
      prefix: --in_subs
  - id: in_subs_list
    type:
      - 'null'
      - File
    doc: Path to a text file contaning input subs files, one per line
    inputBinding:
      position: 101
      prefix: --in_subs_list
  - id: tax
    type: string
    doc: Taxonomic node ID (required)
    inputBinding:
      position: 101
      prefix: --tax
  - id: udg
    type:
      - 'null'
      - boolean
    doc: Plot CpG and non-CpG lines separately. Requires a subs file(s) that was
      made with the udg flag.
    inputBinding:
      position: 101
      prefix: --udg
  - id: ymax
    type:
      - 'null'
      - float
    doc: Maximum for y axis (optional)
    inputBinding:
      position: 101
      prefix: --ymax
outputs:
  - id: outplot
    type:
      - 'null'
      - File
    doc: Filename for the output plot, ending in .png or .pdf
    outputBinding:
      glob: $(inputs.outplot)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
