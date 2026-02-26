cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3-to-ddbj
label: gff3toddbj_gff3-to-ddbj
doc: "Converts GFF3 files to DDBJ format.\n\nTool homepage: https://github.com/yamaton/gff3toddbj"
inputs:
  - id: config_filter_file
    type:
      - 'null'
      - File
    doc: A set of Feature-Qualifier pairs allowed in the output. See 
      https://www.ddbj.nig.ac.jp/assets/files/pdf/ddbj/fq-e.pdf
    inputBinding:
      position: 101
      prefix: --config_filter
  - id: config_rename_file
    type:
      - 'null'
      - File
    doc: Rename setting for features and qualifiers
    inputBinding:
      position: 101
      prefix: --config_rename
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gff3_file
    type:
      - 'null'
      - File
    doc: Input GFF3 file
    inputBinding:
      position: 101
      prefix: --gff3
  - id: log
    type:
      - 'null'
      - string
    doc: '[debug] Choose log level from (DEBUG, INFO, WARNING, ERROR) (default: INFO).'
    default: INFO
    inputBinding:
      position: 101
      prefix: --log
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: Input metadata in TOML describing COMMON and other entries
    inputBinding:
      position: 101
      prefix: --metadata
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix of locus_tag. See 
      https://www.ddbj.nig.ac.jp/ddbj/locus_tag-e.html
    inputBinding:
      position: 101
      prefix: --prefix
  - id: transl_table
    type:
      - 'null'
      - int
    doc: Genetic Code ID. 1 by default, and 11 for bacteria. See 
      https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi
    default: 1
    inputBinding:
      position: 101
      prefix: --transl_table
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify annotation file name as output
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
