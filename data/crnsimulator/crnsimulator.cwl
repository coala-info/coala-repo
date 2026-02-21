cwlVersion: v1.2
class: CommandLineTool
baseCommand: crnsimulator
label: crnsimulator
doc: "A tool for simulating Chemical Reaction Networks (CRNs). Note: The provided
  help text contains only system error logs and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/bad-ants-fleet/crnsimulator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crnsimulator:0.9--pyh5bfb8f1_0
stdout: crnsimulator.out
