cwlVersion: v1.2
class: CommandLineTool
baseCommand: smudgeplot
label: smudgeplot
doc: "A tool for estimating ploidy and genome structure from k-mer frequencies.\n\n
  Tool homepage: https://github.com/KamilSJaron/smudgeplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot.out
