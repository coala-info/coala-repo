cwlVersion: v1.2
class: CommandLineTool
baseCommand: behst
label: behst
doc: "Genomic set enrichment analysis enhanced through integration of chromatin long-range
  interactions\n\nTool homepage: https://bitbucket.org/hoffmanlab/behst/overview"
inputs:
  - id: bedfile
    type: File
    doc: path to query genomic region file (BED format) regions
    inputBinding:
      position: 1
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: path to directory with reference data
    default: ~/.local/share/behst
    inputBinding:
      position: 102
      prefix: --data
  - id: gene_annotation_file
    type:
      - 'null'
      - File
    doc: path of gene annotation file (GTF format)
    inputBinding:
      position: 102
      prefix: --gene-annotation-file
  - id: interaction_file
    type:
      - 'null'
      - File
    doc: path to the chromatin interactions file (HICCUPS Format)
    inputBinding:
      position: 102
      prefix: --interaction-file
  - id: no_gprofiler
    type:
      - 'null'
      - boolean
    doc: If activated, generate the gene list and do not call g:ProfileR)
    inputBinding:
      position: 102
      prefix: --no-gprofiler
  - id: query_extension
    type:
      - 'null'
      - int
    doc: extend query regions by BP base pairs
    default: 24100
    inputBinding:
      position: 102
      prefix: --query-extension
  - id: target_extension
    type:
      - 'null'
      - int
    doc: extend target regions by BP base pairs
    default: 9400
    inputBinding:
      position: 102
      prefix: --target-extension
  - id: transcript_file
    type:
      - 'null'
      - File
    doc: path to the principal transcript file (BED format)
    inputBinding:
      position: 102
      prefix: --transcript-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/behst:3.8--0
stdout: behst.out
