cwlVersion: v1.2
class: CommandLineTool
baseCommand: mseqtools
label: mseqtools
doc: "mseqtools (Note: The provided text contains container runtime error messages
  rather than tool help text, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/arumugamlab/mseqtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mseqtools:0.9.1--h577a1d6_4
stdout: mseqtools.out
