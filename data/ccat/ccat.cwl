cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccat
label: ccat
doc: "Colorizing cat (Note: The provided help text contains only system execution
  errors and does not list tool-specific usage or arguments).\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccat:3.0--2
stdout: ccat.out
