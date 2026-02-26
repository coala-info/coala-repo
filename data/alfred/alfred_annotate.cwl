cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - annotate
label: alfred_annotate
doc: "Annotate peaks with GTF/GFF3, BED, or motif information.\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: peaks_bed
    type: File
    doc: Input peaks BED file
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: bed file
    inputBinding:
      position: 102
      prefix: --bed
  - id: distance
    type:
      - 'null'
      - int
    doc: 'max. distance (0: overlapping features only)'
    default: 0
    inputBinding:
      position: 102
      prefix: --distance
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: exclude overlapping hits of the same motif
    inputBinding:
      position: 102
      prefix: --exclude
  - id: feature
    type:
      - 'null'
      - string
    doc: gtf/gff3 feature
    default: gene
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
    default: gene_name
    inputBinding:
      position: 102
      prefix: --id
  - id: motif
    type:
      - 'null'
      - File
    doc: motif file in jaspar or raw format
    inputBinding:
      position: 102
      prefix: --motif
  - id: nearest
    type:
      - 'null'
      - boolean
    doc: nearest feature only
    inputBinding:
      position: 102
      prefix: --nearest
  - id: quantile
    type:
      - 'null'
      - float
    doc: motif quantile score [0,1]
    default: 0.949999988
    inputBinding:
      position: 102
      prefix: --quantile
  - id: reference
    type:
      - 'null'
      - File
    doc: reference file
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: outgene
    type:
      - 'null'
      - File
    doc: gene/motif-level output
    outputBinding:
      glob: $(inputs.outgene)
  - id: outfile
    type:
      - 'null'
      - File
    doc: annotated peaks output
    outputBinding:
      glob: $(inputs.outfile)
  - id: position_output
    type:
      - 'null'
      - File
    doc: gzipped output file of motif hits
    outputBinding:
      glob: $(inputs.position_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
