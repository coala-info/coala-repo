cwlVersion: v1.2
class: CommandLineTool
baseCommand: drprg
label: drprg
doc: "Drug Resistance Prediction with Reference Graphs. (Note: The provided input
  text contains container runtime error logs rather than the tool's help text. The
  following structure represents the base tool identified in the logs.)\n\nTool homepage:
  https://github.com/mbhall88/drprg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drprg:0.1.1--h5076881_1
stdout: drprg.out
