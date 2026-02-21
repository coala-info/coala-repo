cwlVersion: v1.2
class: CommandLineTool
baseCommand: tefinder
label: tefinder
doc: "The provided text is a container build log and does not contain help documentation
  or usage instructions for the tefinder tool. As a result, no arguments could be
  extracted.\n\nTool homepage: https://forgemia.inra.fr/urgi-anagen/te_finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tefinder:2.32--h9948957_1
stdout: tefinder.out
