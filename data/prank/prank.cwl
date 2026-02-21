cwlVersion: v1.2
class: CommandLineTool
baseCommand: prank
label: prank
doc: "PRANK is a probabilistic multiple alignment program for DNA, codon and amino-acid
  sequences. (Note: The provided help text contains only system error messages and
  no usage information.)\n\nTool homepage: https://github.com/n0xa/m5stick-nemo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prank:170427--h4ac6f70_0
stdout: prank.out
