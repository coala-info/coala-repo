cwlVersion: v1.2
class: CommandLineTool
baseCommand: smudgeplot cutoff
label: smudgeplot_cutoff
doc: "Calculate meaningful values for lower kmer histogram cutoff.\n\nTool homepage:
  https://github.com/KamilSJaron/smudgeplot"
inputs:
  - id: infile
    type: File
    doc: Name of the input kmer histogram file
    default: kmer.hist
    inputBinding:
      position: 1
  - id: boundary
    type: string
    doc: Which bounary to compute L (lower) or U (upper).
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_cutoff.out
