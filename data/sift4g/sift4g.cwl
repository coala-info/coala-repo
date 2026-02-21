cwlVersion: v1.2
class: CommandLineTool
baseCommand: sift4g
label: sift4g
doc: "SIFT4G (Sorting Intolerant From Tolerant for Genomes) predicts whether an amino
  acid substitution affects protein function. Note: The provided text appears to be
  a container build error log rather than help text, so no arguments could be extracted.\n
  \nTool homepage: http://sift.bii.a-star.edu.sg/sift4g/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sift4g:2.0.0--h503566f_8
stdout: sift4g.out
