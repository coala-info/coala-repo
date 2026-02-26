cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - count_rna
label: alfred_count_rna
doc: "RNA-seq counting tool for GTF/GFF3 or BED files\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: aligned_bam
    type: File
    doc: Input aligned BAM file
    inputBinding:
      position: 1
  - id: ambiguous
    type:
      - 'null'
      - boolean
    doc: count ambiguous readsd
    inputBinding:
      position: 102
      prefix: --ambiguous
  - id: bed
    type:
      - 'null'
      - File
    doc: bed file with columns chr, start, end, name [, score, strand, 
      gene_biotype]
    inputBinding:
      position: 102
      prefix: --bed
  - id: feature
    type:
      - 'null'
      - string
    doc: gtf/gff3 feature
    default: exon
    inputBinding:
      position: 102
      prefix: --feature
  - id: gtf
    type:
      - 'null'
      - File
    doc: gtf/gff3 file
    inputBinding:
      position: 102
      prefix: --gtf
  - id: id
    type:
      - 'null'
      - string
    doc: gtf/gff3 attribute
    default: gene_id
    inputBinding:
      position: 102
      prefix: --id
  - id: map_qual
    type:
      - 'null'
      - int
    doc: min. mapping quality
    default: 10
    inputBinding:
      position: 102
      prefix: --map-qual
  - id: normalize
    type:
      - 'null'
      - string
    doc: normalization [raw|fpkm|fpkm_uq]
    default: raw
    inputBinding:
      position: 102
      prefix: --normalize
  - id: stranded
    type:
      - 'null'
      - int
    doc: 'strand-specific counting (0: unstranded, 1: stranded, 2: reverse stranded)'
    default: 0
    inputBinding:
      position: 102
      prefix: --stranded
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
