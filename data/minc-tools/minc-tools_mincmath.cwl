cwlVersion: v1.2
class: CommandLineTool
baseCommand: mincmath
label: minc-tools_mincmath
doc: "Perform simple arithmetic operations on MINC files (e.g., addition, subtraction,
  multiplication, division).\n\nTool homepage: https://github.com/BIC-MNI/minc"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more input MINC files.
    inputBinding:
      position: 1
  - id: add
    type:
      - 'null'
      - boolean
    doc: Add the input volumes.
    inputBinding:
      position: 102
      prefix: -add
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Overwrite an existing file.
    inputBinding:
      position: 102
      prefix: -clobber
  - id: constant
    type:
      - 'null'
      - float
    doc: Specify a constant to use in the operation.
    inputBinding:
      position: 102
      prefix: -constant
  - id: div
    type:
      - 'null'
      - boolean
    doc: Divide the input volumes.
    inputBinding:
      position: 102
      prefix: -div
  - id: mult
    type:
      - 'null'
      - boolean
    doc: Multiply the input volumes.
    inputBinding:
      position: 102
      prefix: -mult
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet operation (no progress reporting).
    inputBinding:
      position: 102
      prefix: -quiet
  - id: sub
    type:
      - 'null'
      - boolean
    doc: Subtract the input volumes.
    inputBinding:
      position: 102
      prefix: -sub
  - id: two
    type:
      - 'null'
      - boolean
    doc: Create a MINC 2.0 output file.
    inputBinding:
      position: 102
      prefix: '-2'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose operation (print progress reporting).
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_file
    type: File
    doc: Output MINC file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
