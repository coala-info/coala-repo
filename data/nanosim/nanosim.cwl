cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanosim
label: nanosim
doc: "NanoSim is a fast and memory-efficient nanopore read simulator.\n\nTool homepage:
  https://github.com/bcgsc/NanoSim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
stdout: nanosim.out
