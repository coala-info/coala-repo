cwlVersion: v1.2
class: CommandLineTool
baseCommand: roary2fripan.py
label: roary2fripan.py
doc: Script to format Roary output for FriPan
inputs:
  - id: output_prefix
    type: string
    doc: Specify output prefix
    inputBinding:
      position: 1
  - id: input_file
    type:
      - 'null'
      - File
    doc: Specify Roary output
    inputBinding:
      position: 102
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/roary2fripan.py:0.1--py27_0
stdout: roary2fripan.py.out
