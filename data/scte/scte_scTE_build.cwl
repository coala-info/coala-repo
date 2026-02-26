cwlVersion: v1.2
class: CommandLineTool
baseCommand: scTE_build
label: scte_scTE_build
doc: "Build genome annotation index for scTE\n\nTool homepage: https://github.com/JiekaiLab/scTE"
inputs:
  - id: gene_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Gtf file for genes annotation. Need the -te option. Mutalluy exclusive 
      to -x option
    inputBinding:
      position: 101
      prefix: -gene
  - id: genome
    type: string
    doc: 'Possible Genomes: mm10 (mouse), hg38 (human)'
    inputBinding:
      position: 101
      prefix: --genome
  - id: mode
    type:
      - 'null'
      - string
    doc: 'How to count TEs expression: inclusive (inclued all reads that can map to
      TEs), or exclusive (exclued the reads that can map to the exon of protein coding
      genes and lncRNAs), or nointron (exclude the reads that can map to the exons
      and intron of genes).'
    default: exclusive
    inputBinding:
      position: 101
      prefix: --mode
  - id: out
    type:
      - 'null'
      - string
    doc: Output file prefix
    default: the genome name
    inputBinding:
      position: 101
      prefix: --out
  - id: te_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Six columns bed file for transposable elements annotation. Need the 
      -gene option.
    inputBinding:
      position: 101
      prefix: -te
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scte:1.0.0--pyhdfd78af_0
stdout: scte_scTE_build.out
