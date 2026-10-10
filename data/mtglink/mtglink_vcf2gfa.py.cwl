cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2gfa.py
label: mtglink_vcf2gfa.py
doc: "Convert a VCF file containing insertion coordinates to a GFA file (GFA 2.0). Insertions can be filtered by the sizes of the flanking contigs and extended on both sides.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: vcf
    type: File
    doc: "VCF file containing the insertions coordinates (format: xxx.vcf)"
    inputBinding:
      prefix: "-vcf"
  - id: fasta
    type: File
    doc: "FASTA file of the reference genome"
    inputBinding:
      prefix: "-fa"
  - id: contigs_size
    type: ['null', int]
    doc: "Minimum size of the flanking contigs of the insertion to treat as a target"
    inputBinding:
      prefix: "-contigs"
  - id: ext_size
    type: ['null', int]
    doc: "Size of the extension of the Indel (bp): extend the Indel by this many bp on both sides [default: 50]"
    inputBinding:
      prefix: "-extension"
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
    doc: Flanking FASTA files referenced by the GFA
    outputBinding:
      glob: '*.fasta'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
