cwlVersion: v1.2
class: CommandLineTool
baseCommand: inmoose
label: inmoose
doc: "The provided text is an error log from a container runtime and does not contain
  help documentation or usage instructions for the tool.\n\nTool homepage: https://github.com/epigenelabs/inmoose"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/inmoose:0.9.1--py311hc1104ee_0
stdout: inmoose.out
