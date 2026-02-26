cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
label: seq-seq-pan_genomes
doc: "A tool for pan-genome analysis and sequence processing.\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to execute. Valid choices: blockcountsplit, extract, join,
      maf, map, mapall, merge, realign, reconstruct, remove, resolve, separate, split,
      xmfa'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
stdout: seq-seq-pan_genomes.out
