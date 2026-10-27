cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - draw-contacts
label: voronota_draw-contacts
doc: "Draws contacts and writes visualization scripts.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_contacts
    type: File
    doc: "list of contacts with graphics (stdin)"
  - id: drawing_for_pymol_path
    type:
      - 'null'
      - string
    doc: "file path to output drawing as pymol script"
    inputBinding:
      position: 101
      prefix: --drawing-for-pymol
  - id: drawing_for_jmol_path
    type:
      - 'null'
      - string
    doc: "file path to output drawing as jmol script"
    inputBinding:
      position: 101
      prefix: --drawing-for-jmol
  - id: drawing_for_scenejs_path
    type:
      - 'null'
      - string
    doc: "file path to output drawing as scenejs script"
    inputBinding:
      position: 101
      prefix: --drawing-for-scenejs
  - id: drawing_for_chimera_path
    type:
      - 'null'
      - string
    doc: "file path to output drawing as chimera bild script"
    inputBinding:
      position: 101
      prefix: --drawing-for-chimera
  - id: drawing_name
    type:
      - 'null'
      - string
    doc: "graphics object name for drawing output"
    inputBinding:
      position: 101
      prefix: --drawing-name
  - id: default_color
    type:
      - 'null'
      - string
    doc: "default color for drawing output, in hex format, white is 0xFFFFFF"
    inputBinding:
      position: 101
      prefix: --default-color
  - id: adjunct_gradient
    type:
      - 'null'
      - string
    doc: "adjunct name to use for gradient-based coloring"
    inputBinding:
      position: 101
      prefix: --adjunct-gradient
  - id: adjunct_gradient_blue
    type:
      - 'null'
      - float
    doc: "blue adjunct gradient value"
    inputBinding:
      position: 101
      prefix: --adjunct-gradient-blue
  - id: adjunct_gradient_red
    type:
      - 'null'
      - float
    doc: "red adjunct gradient value"
    inputBinding:
      position: 101
      prefix: --adjunct-gradient-red
  - id: adjuncts_rgb
    type:
      - 'null'
      - boolean
    doc: "flag to use RGB color values from adjuncts"
    inputBinding:
      position: 101
      prefix: --adjuncts-rgb
  - id: random_colors
    type:
      - 'null'
      - boolean
    doc: "flag to use random color for each drawn contact"
    inputBinding:
      position: 101
      prefix: --random-colors
  - id: alpha
    type:
      - 'null'
      - float
    doc: "alpha opacity value for drawing output"
    inputBinding:
      position: 101
      prefix: --alpha
  - id: use_labels
    type:
      - 'null'
      - boolean
    doc: "flag to use labels in drawing if possible"
    inputBinding:
      position: 101
      prefix: --use-labels
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: drawing_for_pymol
    type:
      - 'null'
      - File
    doc: "file path to output drawing as pymol script"
    outputBinding:
      glob: $(inputs.drawing_for_pymol_path)
  - id: drawing_for_jmol
    type:
      - 'null'
      - File
    doc: "file path to output drawing as jmol script"
    outputBinding:
      glob: $(inputs.drawing_for_jmol_path)
  - id: drawing_for_scenejs
    type:
      - 'null'
      - File
    doc: "file path to output drawing as scenejs script"
    outputBinding:
      glob: $(inputs.drawing_for_scenejs_path)
  - id: drawing_for_chimera
    type:
      - 'null'
      - File
    doc: "file path to output drawing as chimera bild script"
    outputBinding:
      glob: $(inputs.drawing_for_chimera_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_contacts.path)
stdout: voronota_draw-contacts.out
