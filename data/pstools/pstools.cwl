cwlVersion: v1.2
class: CommandLineTool
baseCommand: pstools
label: pstools
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/shilpagarg/pstools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
stdout: pstools.out
