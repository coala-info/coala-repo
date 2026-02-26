cwlVersion: v1.2
class: CommandLineTool
baseCommand: imagej
label: imagej
doc: "Image display and analysis program. Opens formats including:\nUNC, Analyze,
  Dicom, NIFTI, Tiff, Jpeg, Gif, PNG ...\n\nTool homepage: https://github.com/imagej/imagej2"
inputs:
  - id: images
    type:
      - 'null'
      - type: array
        items: File
    doc: Images to open
    inputBinding:
      position: 1
  - id: macro_arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: all following arguments are passed to macro
    inputBinding:
      position: 2
  - id: available_memory
    type:
      - 'null'
      - int
    doc: set available memory (default=4000 max=0)
    default: 4000
    inputBinding:
      position: 103
      prefix: -x
  - id: enable_plugin_compilation
    type:
      - 'null'
      - boolean
    doc: enable plugin compilation within imagej
    inputBinding:
      position: 103
      prefix: -c
  - id: macro_code
    type:
      - 'null'
      - string
    doc: execute macro code
    inputBinding:
      position: 103
      prefix: -e
  - id: macro_file
    type:
      - 'null'
      - File
    doc: run macro
    inputBinding:
      position: 103
      prefix: -m
  - id: macro_file_no_graphics
    type:
      - 'null'
      - File
    doc: run macro without graphics window
    inputBinding:
      position: 103
      prefix: -b
  - id: macro_input_image
    type:
      - 'null'
      - File
    doc: '"image" will be opened before macro is run'
    inputBinding:
      position: 103
      prefix: -i
  - id: menu_command
    type:
      - 'null'
      - string
    doc: run menu command
    inputBinding:
      position: 103
      prefix: -r
  - id: open_existing_panel
    type:
      - 'null'
      - boolean
    doc: open images in existing ImageJ panel if one exists
    inputBinding:
      position: 103
      prefix: -o
  - id: panel_number
    type:
      - 'null'
      - int
    doc: open images in existing ImageJ panel number <N>
    inputBinding:
      position: 103
      prefix: -p
  - id: use_development_version
    type:
      - 'null'
      - boolean
    doc: use development version
    inputBinding:
      position: 103
      prefix: -d
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose (vv or vvv increases verbosity)
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/imagej:v1.51idfsg-2-deb_cv1
stdout: imagej.out
