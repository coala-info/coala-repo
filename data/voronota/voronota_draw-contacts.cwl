cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_draw-contacts
label: voronota_draw-contacts
doc: "Draws contacts in various formats.\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_contacts
    type:
      - 'null'
      - File
    doc: "list of contacts (line format: 'annotation1 annotation2 area distance tags
      adjuncts graphics')"
    inputBinding:
      position: 1
  - id: adjunct_gradient
    type:
      - 'null'
      - string
    doc: adjunct name to use for gradient-based coloring
    inputBinding:
      position: 102
      prefix: --adjunct-gradient
  - id: adjunct_gradient_blue
    type:
      - 'null'
      - float
    doc: blue adjunct gradient value
    inputBinding:
      position: 102
      prefix: --adjunct-gradient-blue
  - id: adjunct_gradient_red
    type:
      - 'null'
      - float
    doc: red adjunct gradient value
    inputBinding:
      position: 102
      prefix: --adjunct-gradient-red
  - id: adjuncts_rgb
    type:
      - 'null'
      - boolean
    doc: flag to use RGB color values from adjuncts
    inputBinding:
      position: 102
      prefix: --adjuncts-rgb
  - id: alpha
    type:
      - 'null'
      - float
    doc: alpha opacity value for drawing output
    inputBinding:
      position: 102
      prefix: --alpha
  - id: default_color
    type:
      - 'null'
      - string
    doc: default color for drawing output, in hex format, white is 0xFFFFFF
    inputBinding:
      position: 102
      prefix: --default-color
  - id: drawing_name
    type:
      - 'null'
      - string
    doc: graphics object name for drawing output
    inputBinding:
      position: 102
      prefix: --drawing-name
  - id: random_colors
    type:
      - 'null'
      - boolean
    doc: flag to use random color for each drawn contact
    inputBinding:
      position: 102
      prefix: --random-colors
  - id: use_labels
    type:
      - 'null'
      - boolean
    doc: flag to use labels in drawing if possible
    inputBinding:
      position: 102
      prefix: --use-labels
outputs:
  - id: drawing_for_pymol
    type:
      - 'null'
      - File
    doc: file path to output drawing as pymol script
    outputBinding:
      glob: $(inputs.drawing_for_pymol)
  - id: drawing_for_jmol
    type:
      - 'null'
      - File
    doc: file path to output drawing as jmol script
    outputBinding:
      glob: $(inputs.drawing_for_jmol)
  - id: drawing_for_scenejs
    type:
      - 'null'
      - File
    doc: file path to output drawing as scenejs script
    outputBinding:
      glob: $(inputs.drawing_for_scenejs)
  - id: drawing_for_chimera
    type:
      - 'null'
      - File
    doc: file path to output drawing as chimera bild script
    outputBinding:
      glob: $(inputs.drawing_for_chimera)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
