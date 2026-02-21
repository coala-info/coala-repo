cwlVersion: v1.2
class: CommandLineTool
baseCommand: verifyidintensity
label: verifyidintensity
doc: "The provided text contains container runtime logs and a fatal error message
  rather than the tool's help documentation. As a result, no arguments or functional
  descriptions could be extracted.\n\nTool homepage: https://genome.sph.umich.edu/wiki/VerifyIDintensity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verifyidintensity:0.0.1--h077b44d_6
stdout: verifyidintensity.out
