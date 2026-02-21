cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pggb
  - smoothxg
label: pggb_smoothxg
doc: "Note: The provided input text is an error log from a container build process
  and does not contain CLI help documentation or argument definitions.\n\nTool homepage:
  https://github.com/pangenome/pggb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
stdout: pggb_smoothxg.out
