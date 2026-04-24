cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyensembl
label: pyensembl_delete-all-files
doc: "Manipulate pyensembl's local cache.\n\nTool homepage: https://github.com/openvax/pyensembl"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to execute. Options include: install, delete, delete-sequence-cache,
      delete-all-files, delete-index-files, list.'
    inputBinding:
      position: 1
  - id: gtf
    type:
      - 'null'
      - File
    doc: Path or URL to the GTF file when installing from source files.
    inputBinding:
      position: 102
      prefix: --gtf
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Force download and indexing even if files already exist locally.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: protein_fasta
    type:
      - 'null'
      - File
    doc: Path or URL to the protein FASTA file when installing from source 
      files.
    inputBinding:
      position: 102
      prefix: --protein-fasta
  - id: reference_name
    type:
      - 'null'
      - string
    doc: Name for the reference genome when installing from source files.
    inputBinding:
      position: 102
      prefix: --reference-name
  - id: release
    type:
      - 'null'
      - type: array
        items: int
    doc: Ensembl release number(s) to install or manage.
    inputBinding:
      position: 102
      prefix: --release
  - id: species
    type:
      - 'null'
      - type: array
        items: string
    doc: Species for which to install or manage data.
    inputBinding:
      position: 102
      prefix: --species
  - id: transcript_fasta
    type:
      - 'null'
      - File
    doc: Path or URL to the transcript FASTA file when installing from source 
      files.
    inputBinding:
      position: 102
      prefix: --transcript-fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyensembl:2.3.13--pyh7cba7a3_0
stdout: pyensembl_delete-all-files.out
