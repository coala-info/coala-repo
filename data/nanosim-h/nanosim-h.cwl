cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanosim-h
label: nanosim-h
doc: "A simulator for Oxford Nanopore reads (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/karel-brinda/NanoSim-H"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim-h:1.1.0.4--pyr341h24bf2e0_0
stdout: nanosim-h.out
