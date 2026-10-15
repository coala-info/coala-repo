cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxrls]
label: phyx_pxrls
doc: |-
  Taxon relabelling for alignments.
  This will take fasta, phylip, and nexus formats from a file or STDIN.
  Two ordered lists of taxa, -c (current) and -n (new) must be provided.
  Results are written in fasta format.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input seq file"
    inputBinding:
      prefix: -s
  - id: cnames
    type: File
    doc: "file containing current taxon labels (one per line)"
    inputBinding:
      prefix: -c
  - id: nnames
    type: File
    doc: "file containing new taxon labels (one per line)"
    inputBinding:
      prefix: -n
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
  - id: verbose
    type: ['null', boolean]
    doc: "make the output more verbose"
    inputBinding:
      prefix: -v
outputs:
  - id: out_file
    type: File
    doc: "relabelled alignment (fasta)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
