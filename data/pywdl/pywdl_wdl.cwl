cwlVersion: v1.2
class: CommandLineTool
baseCommand: wdl
label: pywdl_wdl
doc: "Workflow Description Language (WDL)\n\nTool homepage: https://github.com/broadinstitute/pywdl"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Open the floodgates
    inputBinding:
      position: 101
      prefix: --debug
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Don't colorize output
    inputBinding:
      position: 101
      prefix: --no-color
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pywdl:1.0.22--py_1
stdout: pywdl_wdl.out
