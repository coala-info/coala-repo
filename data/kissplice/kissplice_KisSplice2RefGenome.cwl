cwlVersion: v1.2
class: CommandLineTool
baseCommand: kissplice_KisSplice2RefGenome
label: kissplice_KisSplice2RefGenome
doc: "A tool from the KisSplice suite (Note: The provided text contains container
  runtime error logs rather than the tool's help documentation).\n\nTool homepage:
  http://kissplice.prabi.fr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kissplice:2.6.5--h077b44d_1
stdout: kissplice_KisSplice2RefGenome.out
