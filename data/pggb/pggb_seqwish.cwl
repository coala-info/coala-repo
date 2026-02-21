cwlVersion: v1.2
class: CommandLineTool
baseCommand: pggb
label: pggb_seqwish
doc: "The provided text is an error log from a container build process and does not
  contain help text or usage information for the tool.\n\nTool homepage: https://github.com/pangenome/pggb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
stdout: pggb_seqwish.out
