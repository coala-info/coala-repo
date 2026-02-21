cwlVersion: v1.2
class: CommandLineTool
baseCommand: linearfold
label: linearfold
doc: "Linear-time RNA secondary structure prediction\n\nTool homepage: https://github.com/LinearFold/LinearFold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linearfold:1.0.1.dev20220829--h9948957_2
stdout: linearfold.out
