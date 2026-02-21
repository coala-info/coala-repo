cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAeval
label: viennarna_RNAeval
doc: "Calculate the free energy of RNA sequences with a given secondary structure.
  (Note: The provided text appears to be a container build log error rather than help
  text; no arguments could be extracted from the input.)\n\nTool homepage: http://www.tbi.univie.ac.at/RNA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: viennarna_RNAeval.out
