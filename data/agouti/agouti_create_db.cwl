cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agouti
  - create_db
label: agouti_create_db
doc: "Create a genomic annotation database from GTF or GFF3 files\n\nTool homepage:
  https://github.com/zywicki-lab/agouti"
inputs:
  - id: annotation
    type: File
    doc: input file with the genomic annotation in either GTF or GFF3
    inputBinding:
      position: 101
      prefix: --annotation
  - id: format
    type: string
    doc: format of the input file with the genomic annotation (GTF or GFF3)
    inputBinding:
      position: 101
      prefix: --format
  - id: infer_genes
    type:
      - 'null'
      - boolean
    doc: 'infer gene features. Use only with GTF files that do not have lines describing
      genes (warning: slow!)'
    inputBinding:
      position: 101
      prefix: --infer_genes
  - id: infer_transcripts
    type:
      - 'null'
      - boolean
    doc: 'infer transcript features. Use only with GTF files that do not have lines
      describing transcripts (warning: slow!)'
    inputBinding:
      position: 101
      prefix: --infer_transcripts
  - id: low_ram
    type:
      - 'null'
      - boolean
    doc: 'enable low-memory mode of the database creation process (warning: slow!)'
    inputBinding:
      position: 101
      prefix: --low-ram
outputs:
  - id: database
    type: File
    doc: name for the output database
    outputBinding:
      glob: $(inputs.database)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agouti:1.0.3--pyhdfd78af_0
