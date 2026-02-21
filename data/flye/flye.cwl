cwlVersion: v1.2
class: CommandLineTool
baseCommand: flye
label: flye
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error messages.\n\nTool homepage: https://github.com/fenderglass/Flye/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flye:2.9.6--py310h275bdba_0
stdout: flye.out
