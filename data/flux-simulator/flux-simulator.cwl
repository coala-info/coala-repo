cwlVersion: v1.2
class: CommandLineTool
baseCommand: flux-simulator
label: flux-simulator
doc: "The Flux Simulator is a tool for simulating RNA-Seq experiments. (Note: The
  provided text contained only system error messages and no help documentation; no
  arguments could be extracted from the input.)\n\nTool homepage: https://github.com/logstr/Fluxsim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flux-simulator:1.2.1--1
stdout: flux-simulator.out
