cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta2bed.py
label: mtglink_fasta2bed.py
doc: "Convert a FASTA file to a BED file containing the 'N's coordinates for each scaffold.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: fasta
    type: File
    doc: "FASTA file containing the sequences of the scaffolds (reference genome)"
    inputBinding:
      prefix: "-fa"
  - id: out_bed
    type: string
    doc: "Name of the output BED file"
    inputBinding:
      prefix: "-out"
outputs:
  - id: bed
    type: File
    doc: BED file with the coordinates of the N regions
    outputBinding:
      glob: $(inputs.out_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
