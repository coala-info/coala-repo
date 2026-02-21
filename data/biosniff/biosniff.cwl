cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosniff
label: biosniff
doc: "A tool for scanning or analyzing biological data.\n\nTool homepage: http://github.com/cokelaer/biosniff/"
inputs:
  - id: input
    type: File
    doc: Input file or directory to be processed
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biosniff:1.0.0--pyh7cba7a3_0
stdout: biosniff.out
