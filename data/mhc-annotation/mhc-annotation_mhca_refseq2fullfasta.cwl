cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhca
  - refseq2fullfasta
label: mhc-annotation_mhca_refseq2fullfasta
doc: "Make a RefSeq 'full fasta' (with exon boundaries) from a genome reference and a RefSeq gene table.\
  \ Needs samtools faidx.\n\nTool homepage: https://github.com/DiltheyLab/MHC-annotation"
inputs:
  - id: reference
    type: File
    doc: Genome reference file, usually hg38 in fasta format (with .fai index).
    secondaryFiles:
      - .fai
    inputBinding:
      position: 1
  - id: refseq_genes
    type: File
    doc: RefSeq tab-separated file.
    inputBinding:
      position: 2
  - id: outfile
    type: string
    doc: Output fasta file.
    inputBinding:
      position: 3
outputs:
  - id: out_fasta
    type: File
    doc: Output fasta file.
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
