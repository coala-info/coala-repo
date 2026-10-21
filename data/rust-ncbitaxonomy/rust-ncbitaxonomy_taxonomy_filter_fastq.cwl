cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy_filter_fastq
label: rust-ncbitaxonomy_taxonomy_filter_fastq
doc: "Filter FASTQ files whose reads have been classified by Centrifuge or Kraken2,
  only retaining reads in taxa descending from given ancestor\n\nTool homepage: https://github.com/pvanheus/ncbitaxonomy"
inputs:
  - id: input_fastq
    type:
      type: array
      items: File
    doc: FASTQ file(s) with reads to filter
    inputBinding:
      position: 1
  - id: ancestor_taxid
    type: string
    doc: Taxonomy ID of the ancestor to use as ancestor filter
    inputBinding:
      position: 102
      prefix: --ancestor_taxid
  - id: centrifuge
    type:
      - 'null'
      - boolean
    doc: Filter using report from Centrifuge
    inputBinding:
      position: 102
      prefix: --centrifuge
  - id: db
    type:
      - 'null'
      - File
    doc: SQLite taxonomy database (made with taxonomy_util to_sqlite)
    inputBinding:
      position: 102
      prefix: --db
  - id: kraken2
    type:
      - 'null'
      - boolean
    doc: Filter using report from Kraken2
    inputBinding:
      position: 102
      prefix: --kraken2
  - id: output_dir
    type:
      - 'null'
      - boolean
    doc: Directory to deposited filtered output files in
    inputBinding:
      position: 102
      prefix: --output_dir
  - id: tax_report_filename
    type: File
    doc: Output from Kraken2 (default) or Centrifuge
    inputBinding:
      position: 102
      prefix: --tax_report_filename
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: filtered_fastq
    type:
      type: array
      items: File
    doc: Filtered FASTQ files (<name>.filtered.<ext>)
    outputBinding:
      glob: '*.filtered.*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
stdout: rust-ncbitaxonomy_taxonomy_filter_fastq.out
