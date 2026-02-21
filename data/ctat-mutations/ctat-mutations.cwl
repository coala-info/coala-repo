cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctat-mutations
label: ctat-mutations
doc: "The provided text does not contain help information or usage instructions; it
  consists of system logs and a fatal error indicating a failure to build or pull
  the container image due to insufficient disk space.\n\nTool homepage: https://github.com/NCIP/ctat-mutations"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctat-mutations:2.0.1--py27_1
stdout: ctat-mutations.out
