cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchorwave
  - gff2seq
label: anchorwave_gff2seq
doc: "Extract the longest CDS or exon sequences for each gene from a GFF/GTF file
  and a reference genome.\n\nTool homepage: https://github.com/baoxingsong/AnchorWave"
inputs:
  - id: input_genome
    type: File
    doc: reference genome sequence in fasta format
    inputBinding:
      position: 101
      prefix: -r
  - id: input_gff_file
    type: File
    doc: reference genome annotation in GFF/GTF format
    inputBinding:
      position: 101
      prefix: -i
  - id: min_exon_length
    type:
      - 'null'
      - int
    doc: minimum exon length to output
    default: 20
    inputBinding:
      position: 101
      prefix: -m
  - id: use_exon
    type:
      - 'null'
      - boolean
    doc: use exon records instead of CDS from the GFF file
    inputBinding:
      position: 101
      prefix: -x
outputs:
  - id: output_sequences
    type: File
    doc: output file of the longest CDS/exon for each gene
    outputBinding:
      glob: $(inputs.output_sequences)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anchorwave:1.2.6--h077b44d_0
