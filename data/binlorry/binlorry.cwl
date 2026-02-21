cwlVersion: v1.2
class: CommandLineTool
baseCommand: binlorry
label: binlorry
doc: "A tool for collecting and summarizing metagenomic binning results (Note: The
  provided text is a system error log and does not contain help documentation; therefore,
  no arguments could be extracted).\n\nTool homepage: https://github.com/rambaut/binlorry"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binlorry:1.3.1--py_0
stdout: binlorry.out
