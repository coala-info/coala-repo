cwlVersion: v1.2
class: CommandLineTool
baseCommand: wb_view
label: connectome-workbench_wb_view
doc: "Display usage text, set graphics region size, logging level, disable splash
  screens, load scenes, change window style, load spec files, set window size and
  position.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: string
    doc: A single spec file, or multiple data files
    inputBinding:
      position: 1
  - id: graphics_size
    type:
      - 'null'
      - string
    doc: Set the size of the graphics region. If this option is used you WILL 
      NOT be able to change the size of the graphic region. It may be useful 
      when image captures of a particular size are desired.
    inputBinding:
      position: 102
      prefix: -graphics-size
  - id: logging
    type:
      - 'null'
      - string
    doc: 'Set the logging level. Valid Levels are: SEVERE, WARNING, INFO, CONFIG,
      FINE, FINER, FINEST, ALL, OFF'
    inputBinding:
      position: 102
      prefix: -logging
  - id: no_splash
    type:
      - 'null'
      - boolean
    doc: disable all splash screens
    inputBinding:
      position: 102
      prefix: -no-splash
  - id: scene_load
    type:
      - 'null'
      - type: array
        items: string
    doc: load the specified scene file and display the scene in the file that 
      matches by name or number. Name takes precedence over number. The scene 
      numbers start at one.
    inputBinding:
      position: 102
      prefix: -scene-load
  - id: spec_load_all
    type:
      - 'null'
      - boolean
    doc: load all files in the given spec file, don't show spec file dialog
    inputBinding:
      position: 102
      prefix: -spec-load-all
  - id: style
    type:
      - 'null'
      - string
    doc: 'change the window style to the specified style. The following styles are
      valid on this system: Windows, Fusion. The selected style is listed on the About
      wb_view dialog available from the File Menu (On Macs: wb_view Menu). Press the
      "More" button to see the selected style. Other styles may be available on other
      systems.'
    inputBinding:
      position: 102
      prefix: -style
  - id: window_pos
    type:
      - 'null'
      - string
    doc: Set the position of the browser window
    inputBinding:
      position: 102
      prefix: -window-pos
  - id: window_size
    type:
      - 'null'
      - string
    doc: Set the size of the browser window
    inputBinding:
      position: 102
      prefix: -window-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
stdout: connectome-workbench_wb_view.out
