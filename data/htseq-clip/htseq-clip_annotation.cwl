cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-clip annotation
label: htseq-clip_annotation
doc: "annotation: flattens (to BED format) the given annotation file (in GFF format)\n\
  \nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: annotation_file
    type: File
    doc: GFF formatted annotation file, supports gzipped (.gz) files
    inputBinding:
      position: 101
      prefix: --gff
  - id: gene_id_attribute
    type:
      - 'null'
      - string
    doc: Gene id attribute in GFF file
    inputBinding:
      position: 101
      prefix: --geneid
  - id: gene_name_attribute
    type:
      - 'null'
      - string
    doc: Gene name attribute in GFF file
    inputBinding:
      position: 101
      prefix: --genename
  - id: gene_type_attribute
    type:
      - 'null'
      - string
    doc: Gene type attribute in GFF file
    inputBinding:
      position: 101
      prefix: --genetype
  - id: split_exons
    type:
      - 'null'
      - boolean
    doc: use this flag to split exons into exonic features such as 5'UTR, CDS 
      and 3' UTR
    inputBinding:
      position: 101
      prefix: --splitExons
  - id: unsorted
    type:
      - 'null'
      - boolean
    doc: use this flag if the GFF file is unsorted
    inputBinding:
      position: 101
      prefix: --unsorted
  - id: verbose_level
    type:
      - 'null'
      - string
    doc: Verbose level
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file (.bed[.gz], default: print to console)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
