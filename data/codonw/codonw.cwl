cwlVersion: v1.2
class: CommandLineTool
baseCommand: codonw
label: codonw
doc: "CodonW is a tool for the analysis of codon usage in genetic sequences. (Note:
  The provided help text contains only system error messages and does not list specific
  command-line arguments.)\n\nTool homepage: http://codonw.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/codonw:v1.4.4-4-deb_cv1
stdout: codonw.out
