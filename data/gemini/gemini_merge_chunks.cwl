cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini merge_chunks
label: gemini_merge_chunks
doc: "Merge multiple chunked databases into a single database.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: annotation_type
    type:
      - 'null'
      - string
    doc: The annotations to be used with the input vcf.
    inputBinding:
      position: 101
      prefix: -t
  - id: chunkdbs
    type:
      - 'null'
      - type: array
        items: File
    doc: List of chunked databases to merge.
    inputBinding:
      position: 101
      prefix: --chunkdb
  - id: db
    type:
      - 'null'
      - string
    doc: The name of the final database to be loaded.
    inputBinding:
      position: 101
      prefix: --db
  - id: index
    type:
      - 'null'
      - boolean
    doc: Create all database indexes. If multiple merges are used to create a 
      database, only the last merge should create the indexes.
    inputBinding:
      position: 101
      prefix: --index
  - id: skip_pls
    type:
      - 'null'
      - boolean
    doc: dont create columns for phred-scaled genotype likelihoods
    inputBinding:
      position: 101
      prefix: --skip-pls
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Local (non-NFS) temp directory to use for working around SQLite locking
      issues on NFS drives.
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: vcf
    type:
      - 'null'
      - File
    doc: Original VCF file, for retrieving extra annotation fields.
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_merge_chunks.out
