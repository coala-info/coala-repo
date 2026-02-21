cwlVersion: v1.2
class: CommandLineTool
baseCommand: apscale
label: apscale
doc: "Advanced Pipeline for SCalable mAnuAL Evaluation (Note: The provided text contains
  container build logs and error messages rather than tool help text, so specific
  arguments could not be extracted).\n\nTool homepage: https://github.com/DominikBuchner/apscale"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apscale:4.3.0--pyhdfd78af_0
stdout: apscale.out
