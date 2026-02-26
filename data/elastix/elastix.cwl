cwlVersion: v1.2
class: CommandLineTool
baseCommand: elastix
label: elastix
doc: "elastix registers a moving image to a fixed image.\nThe registration-process
  is specified in the parameter file.\n\nTool homepage: https://github.com/SuperElastix/elastix"
inputs:
  - id: fixed_image
    type: File
    doc: fixed image
    inputBinding:
      position: 101
      prefix: -f
  - id: fixed_image_mask
    type:
      - 'null'
      - File
    doc: mask for fixed image
    inputBinding:
      position: 101
      prefix: -fMask
  - id: initial_transform_parameter_file
    type:
      - 'null'
      - File
    doc: parameter file for initial transform
    inputBinding:
      position: 101
      prefix: -t0
  - id: moving_image
    type: File
    doc: moving image
    inputBinding:
      position: 101
      prefix: -m
  - id: moving_image_mask
    type:
      - 'null'
      - File
    doc: mask for moving image
    inputBinding:
      position: 101
      prefix: -mMask
  - id: parameter_file
    type:
      type: array
      items: File
    doc: parameter file, elastix handles 1 or more "-p"
    inputBinding:
      position: 101
      prefix: -p
  - id: priority
    type:
      - 'null'
      - string
    doc: set the process priority to high, abovenormal, normal (default), 
      belownormal, or idle (Windows only option)
    inputBinding:
      position: 101
      prefix: -priority
  - id: threads
    type:
      - 'null'
      - int
    doc: set the maximum number of threads of elastix
    inputBinding:
      position: 101
      prefix: -threads
outputs:
  - id: output_directory
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/elastix:v4.9.0-1-deb_cv1
