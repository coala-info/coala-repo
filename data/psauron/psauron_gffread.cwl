cwlVersion: v1.2
class: CommandLineTool
baseCommand: psauron_gffread
label: psauron_gffread
doc: "The provided text does not contain help information for the tool; it appears
  to be a container runtime error log.\n\nTool homepage: https://github.com/salzberg-lab/PSAURON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psauron:1.1.0--pyhdfd78af_0
stdout: psauron_gffread.out
