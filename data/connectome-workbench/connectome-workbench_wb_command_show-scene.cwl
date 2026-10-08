cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -show-scene
label: connectome-workbench_wb_command_show-scene
doc: 'Render content of browser windows displayed in a scene into image file(s). The
  image file name should be similar to "capture.png". If there is only one image to
  render, the image name will not change. If there is more than one image to render,
  an index will be inserted into the image name: "capture_01.png", "capture_02.png"
  etc.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.scene_file)
      - $(inputs.scene_data_files)
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: set_map_yoke_rec
        type: record
        fields:
          - name: map_yoking_roman_numeral
            type: string
            doc: Roman numeral identifying the map yoking group (I, II, III, IV, V,
              VI, VII, VIII, IX, X)
            inputBinding:
              position: 1
          - name: map_index
            type: int
            doc: Map index for yoking group. Indices start at 1 (one)
            inputBinding:
              position: 2
      - name: conn_db_login_rec
        type: record
        fields:
          - name: username
            type: string
            doc: Connectome DB Username
            inputBinding:
              position: 1
          - name: password
            type: string
            doc: Connectome DB Password
            inputBinding:
              position: 2
inputs:
  - id: scene_file
    type: File
    doc: scene file
    inputBinding:
      position: 1
  - id: scene_name_or_number
    type: string
    doc: name or number (starting at one) of the scene in the scene file
    inputBinding:
      position: 2
  - id: image_file_name
    type: string
    doc: output image file name
    inputBinding:
      position: 3
  - id: image_width
    type: int
    doc: width of output image(s)
    inputBinding:
      position: 4
  - id: image_height
    type: int
    doc: height of output image(s)
    inputBinding:
      position: 5
  - id: use_window_size
    type:
      - 'null'
      - boolean
    doc: Override image size with window size
    inputBinding:
      position: 6
      prefix: -use-window-size
  - id: no_scene_colors
    type:
      - 'null'
      - boolean
    doc: Do not use background and foreground colors in scene
    inputBinding:
      position: 6
      prefix: -no-scene-colors
  - id: set_map_yoke
    type:
      - 'null'
      - set_map_yoke_rec
    doc: Override selected map index for a map yoking group.
    inputBinding:
      position: 6
      prefix: -set-map-yoke
  - id: conn_db_login
    type:
      - 'null'
      - conn_db_login_rec
    doc: Login for scenes with files in Connectome Database
    inputBinding:
      position: 6
      prefix: -conn-db-login
  - id: scene_data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: data files the scene refers to (surfaces, metrics, borders, ...); they are staged next to the scene file so its relative paths resolve
outputs:
  - id: images
    type: File[]
    doc: the rendered image file(s)
    outputBinding:
      glob: $(inputs.image_file_name.replace(/\.[^.]*$/, "") + "*")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
