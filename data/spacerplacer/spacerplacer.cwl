cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacerplacer
label: spacerplacer
doc: "The provided text contains container runtime logs and a fatal error message
  rather than the tool's help documentation. No arguments or descriptions could be
  extracted.\n\nTool homepage: https://github.com/fbaumdicker/SpacerPlacer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerplacer:1.0.1--pyhdfd78af_0
stdout: spacerplacer.out
