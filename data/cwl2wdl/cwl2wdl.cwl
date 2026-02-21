cwlVersion: v1.2
class: CommandLineTool
baseCommand: cwl2wdl
label: cwl2wdl
doc: "A tool for converting Common Workflow Language (CWL) to Workflow Description
  Language (WDL).\n\nTool homepage: https://github.com/adamstruck/cwl2wdl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cwl2wdl:0.1dev44--py36_1
stdout: cwl2wdl.out
