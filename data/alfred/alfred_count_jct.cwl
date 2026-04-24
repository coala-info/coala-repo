cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - count_jct
label: alfred_count_jct
doc: "Count exon-exon junction reads from aligned BAM files using GTF/GFF3 or BED
  annotations.\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: aligned_bam
    type: File
    doc: Input aligned BAM file
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: bed file with columns chr, start, end, name [, score, strand]
    inputBinding:
      position: 102
      prefix: --bed
  - id: feature
    type:
      - 'null'
      - string
    doc: gtf/gff3 feature
    inputBinding:
      position: 102
      prefix: --feature
  - id: gtf
    type: File
    doc: gtf/gff3 file
    inputBinding:
      position: 102
      prefix: --gtf
  - id: id
    type:
      - 'null'
      - string
    doc: gtf/gff3 attribute
    inputBinding:
      position: 102
      prefix: --id
  - id: map_qual
    type:
      - 'null'
      - int
    doc: min. mapping quality
    inputBinding:
      position: 102
      prefix: --map-qual
  - id: stranded
    type:
      - 'null'
      - int
    doc: 'strand-specific counting (0: unstranded, 1: stranded, 2: reverse stranded)'
    inputBinding:
      position: 102
      prefix: --stranded
outputs:
  - id: outintra
    type:
      - 'null'
      - File
    doc: intra-gene exon-exon junction reads
    outputBinding:
      glob: $(inputs.outintra)
  - id: outinter
    type:
      - 'null'
      - File
    doc: inter-gene exon-exon junction reads
    outputBinding:
      glob: $(inputs.outinter)
  - id: outnovel
    type:
      - 'null'
      - File
    doc: output file for not annotated intra-chromosomal junction reads
    outputBinding:
      glob: $(inputs.outnovel)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
