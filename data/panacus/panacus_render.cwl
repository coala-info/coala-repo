cwlVersion: v1.2
class: CommandLineTool
baseCommand: panacus render
label: panacus_render
doc: "Render an html report from one or more JSON result files\n\nTool homepage: https://github.com/marschall-lab/panacus"
inputs:
  - id: json_files
    type:
      type: array
      items: File
    doc: Specifies one or more JSON files
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Set the number of threads used (default: use all threads)'
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Set the number of threads used (default: use all threads)'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
stdout: panacus_render.out
