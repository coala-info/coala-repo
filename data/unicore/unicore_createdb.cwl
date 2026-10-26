cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - createdb
label: unicore_createdb
doc: |-
  Create Foldseek database from amino acid sequences

  Tool homepage: https://github.com/steineggerlab/unicore
inputs:
  - id: input
    type: 
      - File
      - Directory
    doc: "Input directory with fasta files or a single fasta file"
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output foldseek database (prefix)"
    inputBinding:
      position: 2
  - id: model
    type: Directory
    doc: "ProstT5 model (directory with the ProstT5 weights, e.g. made with foldseek databases ProstT5)"
    inputBinding:
      position: 3
  - id: keep
    type: ['null', boolean]
    doc: "Keep intermediate files"
    inputBinding:
      position: 10
      prefix: --keep
  - id: overwrite
    type: ['null', boolean]
    doc: "Force overwrite output database"
    inputBinding:
      position: 10
      prefix: --overwrite
  - id: max_len
    type: ['null', int]
    doc: "Set maximum sequence length threshold"
    inputBinding:
      position: 10
      prefix: --max-len
  - id: gpu
    type: ['null', boolean]
    doc: "Use GPU for foldseek createdb"
    inputBinding:
      position: 10
      prefix: --gpu
  - id: afdb_lookup
    type: ['null', string]
    doc: "Use AFDB lookup for foldseek createdb. Useful for large databases"
    inputBinding:
      position: 10
      prefix: --afdb-lookup
  - id: custom_lookup
    type: ['null', string]
    doc: "Use custom lookup database, accepts any Foldseek database to reference against"
    inputBinding:
      position: 10
      prefix: --custom-lookup
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use; 0 to use all (default 0)"
    inputBinding:
      position: 10
      prefix: --threads
  - id: verbosity
    type: ['null', int]
    doc: "Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) (default 3)"
    inputBinding:
      position: 10
      prefix: --verbosity
outputs:
  - id: database_files
    type:
      type: array
      items: File
    doc: Foldseek database files written with the output prefix
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
