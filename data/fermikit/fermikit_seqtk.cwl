cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqtk
label: fermikit_seqtk
doc: "A toolkit for processing sequences.\n\nTool homepage: https://github.com/lh3/fermikit"
inputs:
  - id: command
    type: string
    doc: 'The command to execute. Available commands: seq, size, comp, sample, subseq,
      fqchk, mergepe, split, trimfq, hety, gc, mutfa, mergefa, famask, dropse, rename,
      randbase, cutN, gap, listhet, hpc, telo'
    inputBinding:
      position: 1
  - id: arguments
    type:
      type: array
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
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_seqtk.out
