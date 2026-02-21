cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicbrowser_runBrowser
label: hicbrowser_runBrowser
doc: "A tool for browsing Hi-C data (Note: The provided help text contains only system
  error logs and no usage information).\n\nTool homepage: https://github.com/maxplanck-ie/HiCBrowser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicbrowser:1.0--py27_1
stdout: hicbrowser_runBrowser.out
