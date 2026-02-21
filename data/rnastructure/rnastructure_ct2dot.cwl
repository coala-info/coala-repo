cwlVersion: v1.2
class: CommandLineTool
baseCommand: ct2dot
label: rnastructure_ct2dot
doc: "A tool from the RNAstructure package to convert CT files to dot-bracket notation.
  (Note: The provided help text contains only container runtime error messages and
  no argument definitions.)\n\nTool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
stdout: rnastructure_ct2dot.out
