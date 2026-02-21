cwlVersion: v1.2
class: CommandLineTool
baseCommand: obirefidx
label: obitools4_obirefidx
doc: "The provided text does not contain help information for the tool, as it consists
  of container runtime error messages regarding disk space.\n\nTool homepage: https://obitools4.metabarcoding.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obirefidx.out
