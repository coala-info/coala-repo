cwlVersion: v1.2
class: CommandLineTool
baseCommand: daisyblast
label: daisyblast
doc: "A tool for protein sequence alignment and analysis (Note: The provided text
  contains container build errors rather than help documentation).\n\nTool homepage:
  https://github.com/erinyoung/daisyblast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daisyblast:0.2.0--pyhdfd78af_0
stdout: daisyblast.out
