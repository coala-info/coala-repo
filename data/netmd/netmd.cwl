cwlVersion: v1.2
class: CommandLineTool
baseCommand: netmd
label: netmd
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a SIF container due to insufficient
  disk space.\n\nTool homepage: https://github.com/mazzalab/NetMD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netmd:1.0.3--pyh3c853c9_0
stdout: netmd.out
