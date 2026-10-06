cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_sp_manage_functional_annotation.pl
label: agat_agat_sp_manage_functional_annotation.pl
doc: "This tool allows managing functional annotations within a GFF file, such as
  adding information from BLAST or InterProScan results or cleaning existing annotations.\n\
  \ \nTool homepage: https://github.com/NBISweden/AGAT"
inputs:
  - id: blast
    type:
      - 'null'
      - File
    doc: Input blast file (tabulated format 6).
    inputBinding:
      position: 101
      prefix: --blast
  - id: clean_name
    type:
      - 'null'
      - boolean
    doc: Clean the Name attribute when it already exists, instead of appending
      the Name retrieved by --blast and --db.
    inputBinding:
      position: 101
      prefix: --clean_name
  - id: clean_product
    type:
      - 'null'
      - boolean
    doc: Clean the product attribute when it already exists.
    inputBinding:
      position: 101
      prefix: --clean_product
  - id: clean_dbxref
    type:
      - 'null'
      - boolean
    doc: Clean the Dbxref attribute when it already exists.
    inputBinding:
      position: 101
      prefix: --clean_dbxref
  - id: clean_ontology
    type:
      - 'null'
      - boolean
    doc: Clean the Ontology_term attribute when it already exists.
    inputBinding:
      position: 101
      prefix: --clean_ontology
  - id: db
    type:
      - 'null'
      - File
    doc: The fasta file used as DB for the blast. Gene names and products are
      taken from this file. Required with --blast.
    inputBinding:
      position: 101
      prefix: --db
  - id: blast_evalue
    type:
      - 'null'
      - float
    doc: Maximum e-value to keep the annotation from the blast file. Default 
      1e-6.
    inputBinding:
      position: 101
      prefix: --blast_evalue
  - id: gff
    type: File
    doc: Input GFF3 file that will be read.
    inputBinding:
      position: 101
      prefix: --gff
  - id: interpro
    type:
      - 'null'
      - File
    doc: Input interpro file (.tsv).
    inputBinding:
      position: 101
      prefix: --interpro
  - id: output_path
    type: string
    doc: Output folder name; it holds the annotated GFF and summary files.
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output folder with the annotated GFF3 file and summary files.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ return inputs.db ? [{"entry": inputs.db, "writable": true}] : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
