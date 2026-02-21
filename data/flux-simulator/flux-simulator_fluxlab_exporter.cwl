cwlVersion: v1.2
class: CommandLineTool
baseCommand: flux-simulator
label: flux-simulator_fluxlab_exporter
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error indicating a failure to build
  the container image due to lack of disk space.\n\nTool homepage: https://github.com/logstr/Fluxsim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flux-simulator:1.2.1--1
stdout: flux-simulator_fluxlab_exporter.out
