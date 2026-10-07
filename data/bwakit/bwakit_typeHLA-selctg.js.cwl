cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - typeHLA-selctg.js
label: bwakit_typeHLA-selctg.js
doc: "Select assembled contigs that overlap the exons of one HLA gene, from the
  contig-to-ALT alignment; prints the names of the selected contigs.\n\nTool homepage: https://github.com/lh3/bwa/tree/master/bwakit"
inputs:
  - id: hla_gene
    type: string
    doc: HLA gene name, for example HLA-A
    inputBinding:
      position: 1
  - id: hla_alt_exons_bed
    type: File
    doc: BED of HLA exons on the ALT haplotypes (HLA-ALT-exons.bed from resource-human-HLA)
    inputBinding:
      position: 2
  - id: ctg_to_alt_sam
    type: File
    doc: SAM (plain or gzipped) of contigs mapped to the HLA ALT haplotypes
    inputBinding:
      position: 3
  - id: min_ovlp
    type:
      - 'null'
      - int
    doc: minimum overlap between a contig and an exon [30]
    inputBinding:
      position: 4
outputs:
  - id: selected_contigs
    type: stdout
    doc: names of the selected contigs, one per line
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwakit:0.7.18.dev1--hdfd78af_0
stdout: bwakit_typeHLA-selctg.js.txt
