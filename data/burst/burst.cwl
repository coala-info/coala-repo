cwlVersion: v1.2
class: CommandLineTool
baseCommand: burst
label: burst
doc: "\nTool homepage: https://github.com/knights-lab/BURST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/burst:v1.0--0
stdout: burst.out
