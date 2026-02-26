cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
label: seq-seq-pan_genome
doc: "A tool for pan-genome analysis and sequence alignment manipulation.\n\nTool
  homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to execute. Choices: blockcountsplit, extract, join, maf,
      map, mapall, merge, realign, reconstruct, remove, resolve, separate, split,
      xmfa'
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
stdout: seq-seq-pan_genome.out
