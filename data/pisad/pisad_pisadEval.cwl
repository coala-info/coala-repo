cwlVersion: v1.2
class: CommandLineTool
baseCommand: pisadEval
label: pisad_pisadEval
doc: "Optional options:\n\nTool homepage: https://github.com/ZhantianXu/PISAD"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to run.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
stdout: pisad_pisadEval.out
