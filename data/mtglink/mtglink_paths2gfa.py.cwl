cwlVersion: v1.2
class: CommandLineTool
baseCommand: paths2gfa.py
label: mtglink_paths2gfa.py
doc: "Convert a file containing the paths between scaffolds to a GFA file.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: fasta
    type: File
    doc: "FASTA file containing the sequences of the scaffolds (reference genome)"
    inputBinding:
      prefix: "-fa"
  - id: paths
    type: File
    doc: "File containing the paths between scaffolds (format: xxx.paths.txt)"
    inputBinding:
      prefix: "-paths"
  - id: out_gfa
    type: string
    doc: "Name of the output GFA file"
    inputBinding:
      prefix: "-out"
outputs:
  - id: gfa_out
    type: File
    doc: Output GFA file
    outputBinding:
      glob: $(inputs.out_gfa)
  - id: flanking_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: Scaffold FASTA files referenced by the GFA
    outputBinding:
      glob: '*.fasta'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
