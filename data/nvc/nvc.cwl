cwlVersion: v1.2
class: CommandLineTool
baseCommand: nvc
label: nvc
doc: "The provided text does not contain help information for the tool 'nvc'. It contains
  system log messages and a fatal error related to a container runtime (Apptainer/Singularity)
  failing to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/blankenberg/nvc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nvc:0.0.4--py27h24bf2e0_1
stdout: nvc.out
