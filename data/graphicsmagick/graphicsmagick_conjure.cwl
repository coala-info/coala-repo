cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gm
  - conjure
label: graphicsmagick_conjure
doc: "Execute a Magick Scripting Language (MSL) XML script. Images read and written by
  the script are looked up in (and written to) the working directory.\n\nTool homepage:
  http://www.graphicsmagick.org/"
inputs:
  - id: debug
    type:
      - 'null'
      - string
    doc: display copious debugging information
    inputBinding:
      position: 1
      prefix: -debug
  - id: log
    type:
      - 'null'
      - string
    doc: format of debugging information
    inputBinding:
      position: 1
      prefix: -log
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print detailed information about the image
    inputBinding:
      position: 1
      prefix: -verbose
  - id: variables
    type:
      - 'null'
      - type: array
        items: string
    doc: Key value pairs defined for the script, each as an option and its value
      (for example -size 100x100 -color blue -foo bar)
    inputBinding:
      position: 2
  - id: script
    type: File
    doc: MSL script file
    inputBinding:
      position: 3
  - id: images
    type:
      - 'null'
      - type: array
        items: File
    doc: Image files the script reads (staged in the working directory)
outputs:
  - id: output_images
    type:
      type: array
      items: File
    doc: Images written by the script (all image files created in the working directory)
    outputBinding:
      glob:
        - "*.png"
        - "*.jpg"
        - "*.gif"
        - "*.tif"
        - "*.miff"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.images)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphicsmagick:1.3.46
stdout: graphicsmagick_conjure.out
