cwlVersion: v1.2
class: CommandLineTool
baseCommand: flux-simulator
label: flux-simulator_fluxsim
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error message indicating a failure to build
  a container image due to insufficient disk space.\n\nTool homepage: https://github.com/logstr/Fluxsim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flux-simulator:1.2.1--1
stdout: flux-simulator_fluxsim.out
