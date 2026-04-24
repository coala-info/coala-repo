cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - export
label: treebest_export
doc: "Export a tree to a graphical format\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: tree
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: black_white_mode
    type:
      - 'null'
      - boolean
    doc: black/white mode
    inputBinding:
      position: 102
      prefix: -M
  - id: box_size
    type:
      - 'null'
      - float
    doc: box size
    inputBinding:
      position: 102
      prefix: -b
  - id: font_size
    type:
      - 'null'
      - int
    doc: font size
    inputBinding:
      position: 102
      prefix: -f
  - id: font_width
    type:
      - 'null'
      - float
    doc: font width
    inputBinding:
      position: 102
      prefix: -w
  - id: height
    type:
      - 'null'
      - int
    doc: height
    inputBinding:
      position: 102
      prefix: -y
  - id: margin
    type:
      - 'null'
      - int
    doc: margin
    inputBinding:
      position: 102
      prefix: -m
  - id: pseudo_length
    type:
      - 'null'
      - boolean
    doc: pseudo-length
    inputBinding:
      position: 102
      prefix: -p
  - id: show_species_name
    type:
      - 'null'
      - boolean
    doc: show species name
    inputBinding:
      position: 102
      prefix: -S
  - id: speciation_duplication_inference
    type:
      - 'null'
      - boolean
    doc: speciation/duplication inference
    inputBinding:
      position: 102
      prefix: -d
  - id: species_tree
    type:
      - 'null'
      - File
    doc: species tree
    inputBinding:
      position: 102
      prefix: -s
  - id: suppress_bootstrap
    type:
      - 'null'
      - boolean
    doc: suppress bootstrap value
    inputBinding:
      position: 102
      prefix: -B
  - id: width
    type:
      - 'null'
      - int
    doc: width
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_export.out
