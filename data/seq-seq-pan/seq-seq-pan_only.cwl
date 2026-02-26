cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
label: seq-seq-pan_only
doc: "A tool for pan-genome analysis. Note: 'only' is not a valid subcommand; valid
  subcommands include blockcountsplit, extract, join, maf, map, mapall, merge, realign,
  reconstruct, remove, resolve, separate, split, and xmfa.\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (choose from 'blockcountsplit', 'extract', 
      'join', 'maf', 'map', 'mapall', 'merge', 'realign', 'reconstruct', 
      'remove', 'resolve', 'separate', 'split', 'xmfa')
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
stdout: seq-seq-pan_only.out
