cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAmultifold
label: viennarna_RNAmultifold
doc: "Predict secondary structures of multiple interacting RNA molecules. (Note: The
  provided help text contained only container runtime error messages and no usage
  information; arguments could not be extracted from the source text.)\n\nTool homepage:
  http://www.tbi.univie.ac.at/RNA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: viennarna_RNAmultifold.out
