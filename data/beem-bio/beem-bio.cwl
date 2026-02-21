cwlVersion: v1.2
class: CommandLineTool
baseCommand: beem-bio
label: beem-bio
doc: "Biomass Estimation using Expectation-Maximization (Note: The provided text is
  a container build error log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/kad-ecoli/BeEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beem-bio:1.0.1--h9948957_0
stdout: beem-bio.out
