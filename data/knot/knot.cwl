cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot
label: knot
doc: "The provided text does not contain help information for the tool 'knot'. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to lack of disk space.\n\nTool homepage: https://github.com/Lojii/Knot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot:1.0.0--1
stdout: knot.out
