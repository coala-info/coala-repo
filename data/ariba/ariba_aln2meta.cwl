cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - aln2meta
label: ariba_aln2meta
doc: "Make metadata input to prepareref, using multialignment and SNPs\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
inputs:
  - id: aln_fasta
    type: File
    doc: "Multi-fasta file of alignments"
    inputBinding:
      position: 10
  - id: variants_tsv
    type: File
    doc: "TSV file of variants information"
    inputBinding:
      position: 11
  - id: coding
    type: string
    doc: "Sequences are coding or noncoding. Must be one of: coding noncoding"
    inputBinding:
      position: 12
  - id: outprefix
    type: string
    doc: "Prefix of output filenames"
    default: aln2meta
    inputBinding:
      position: 13
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: "Number of genetic code to use. Currently supported 1,4,11 [11]"
    inputBinding:
      position: 1
      prefix: --genetic_code
  - id: variant_only
    type:
      - 'null'
      - boolean
    doc: "Use this to flag all sequences as variant only. By default they are considered to be presence/absence"
    inputBinding:
      position: 1
      prefix: --variant_only
outputs:
  - id: fasta
    type: File
    doc: Reference sequences for prepareref (outprefix.fa)
    outputBinding:
      glob: $(inputs.outprefix).fa
  - id: metadata
    type: File
    doc: Metadata TSV for prepareref (outprefix.tsv)
    outputBinding:
      glob: $(inputs.outprefix).tsv
  - id: clusters
    type: File
    doc: Cluster file for prepareref --cdhit_clusters (outprefix.cluster)
    outputBinding:
      glob: $(inputs.outprefix).cluster
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
