cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicbrowser
label: hicbrowser
doc: "A tool for visualizing Hi-C data. Note: The provided help text contains only
  system error messages regarding container execution and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/maxplanck-ie/HiCBrowser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicbrowser:1.0--py27_1
stdout: hicbrowser.out
