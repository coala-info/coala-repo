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
  - id: drawing_for_chimera_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `drawing_for_chimera_path`
    inputBinding:
      position: 103
      prefix: --drawing-for-chimera
  - id: drawing_for_jmol_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `drawing_for_jmol_path`
    inputBinding:
      position: 104
      prefix: --drawing-for-jmol
  - id: drawing_for_pymol_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `drawing_for_pymol_path`
    inputBinding:
      position: 105
      prefix: --drawing-for-pymol
  - id: drawing_for_scenejs_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `drawing_for_scenejs_path`
    inputBinding:
      position: 106
      prefix: --drawing-for-scenejs
outputs:
  - id: drawing_for_pymol
    type:
      - 'null'
      - File
    doc: file path to output drawing as pymol script
    outputBinding:
      glob: $(inputs.drawing_for_pymol_path)
  - id: drawing_for_jmol
    type:
      - 'null'
      - File
    doc: file path to output drawing as jmol script
    outputBinding:
      glob: $(inputs.drawing_for_jmol_path)
  - id: drawing_for_scenejs
    type:
      - 'null'
      - File
    doc: file path to output drawing as scenejs script
    outputBinding:
      glob: $(inputs.drawing_for_scenejs_path)
  - id: drawing_for_chimera
    type:
      - 'null'
      - File
    doc: file path to output drawing as chimera bild script
    outputBinding:
      glob: $(inputs.drawing_for_chimera_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
