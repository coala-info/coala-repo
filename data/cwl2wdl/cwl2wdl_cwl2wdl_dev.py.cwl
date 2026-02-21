cwlVersion: v1.2
class: CommandLineTool
baseCommand: cwl2wdl_cwl2wdl_dev.py
label: cwl2wdl_cwl2wdl_dev.py
doc: "A tool to convert Common Workflow Language (CWL) to Workflow Description Language
  (WDL). Note: The provided text appears to be a container build error log rather
  than help documentation, so no arguments could be extracted.\n\nTool homepage: https://github.com/adamstruck/cwl2wdl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cwl2wdl:0.1dev44--py36_1
stdout: cwl2wdl_cwl2wdl_dev.py.out
