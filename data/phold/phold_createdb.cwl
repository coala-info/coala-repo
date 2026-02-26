cwlVersion: v1.2
class: CommandLineTool
baseCommand: phold_createdb
label: phold_createdb
doc: "Creates foldseek DB from AA FASTA and 3Di FASTA input files\n\nTool homepage:
  https://github.com/gbouras13/phold"
inputs:
  - id: fasta_3di
    type: File
    doc: Path to input 3Di FASTA file of proteins
    inputBinding:
      position: 101
      prefix: --fasta_3di
  - id: fasta_aa
    type: File
    doc: Path to input Amino Acid FASTA file of proteins
    inputBinding:
      position: 101
      prefix: --fasta_aa
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: output_phold_foldseek_db
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for Foldseek database
    default: phold_foldseek_db
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use with Foldseek
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
stdout: phold_createdb.out
