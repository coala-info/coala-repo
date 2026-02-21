cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAfold
label: viennarna_RNAfold
doc: "The provided text contains system logs and a fatal error message regarding a
  container build failure. It does not contain the help text or usage information
  for the tool. Consequently, no arguments could be extracted.\n\nTool homepage: http://www.tbi.univie.ac.at/RNA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: viennarna_RNAfold.out
