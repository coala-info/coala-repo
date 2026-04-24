cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicore createdb
label: unicore_createdb
doc: "Create Foldseek database from amino acid sequences\n\nTool homepage: https://github.com/steineggerlab/unicore"
inputs:
  - id: input
    type: File
    doc: Input directory with fasta files or a single fasta file
    inputBinding:
      position: 1
  - id: model
    type: string
    doc: ProstT5 model
    inputBinding:
      position: 2
  - id: afdb_lookup
    type:
      - 'null'
      - string
    doc: Use AFDB lookup for foldseek createdb. Useful for large databases
    inputBinding:
      position: 103
      prefix: --afdb-lookup
  - id: custom_lookup
    type:
      - 'null'
      - string
    doc: Use custom lookup database, accepts any Foldseek database to reference 
      against
    inputBinding:
      position: 103
      prefix: --custom-lookup
  - id: gpu
    type:
      - 'null'
      - boolean
    doc: Use GPU for foldseek createdb
    inputBinding:
      position: 103
      prefix: --gpu
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    inputBinding:
      position: 103
      prefix: --keep
  - id: max_len
    type:
      - 'null'
      - int
    doc: Set maximum sequence length threshold
    inputBinding:
      position: 103
      prefix: --max-len
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite output database
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use; 0 to use all
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug)'
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: output
    type: Directory
    doc: Output foldseek database
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
