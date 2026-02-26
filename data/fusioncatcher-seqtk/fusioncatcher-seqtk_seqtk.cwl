cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqtk
label: fusioncatcher-seqtk_seqtk
doc: "A toolkit for processing sequences.\n\nTool homepage: https://github.com/ndaniel/seqtk"
inputs:
  - id: command
    type: string
    doc: "The command to execute. Available commands:\nseq, comp, sample, subseq,
      fqchk, mergepe, trimfq, hety, gc, mutfa, mergefa, famask, dropse, rename, randbase,
      cutN, listhet"
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusioncatcher-seqtk:1.2--h577a1d6_7
stdout: fusioncatcher-seqtk_seqtk.out
