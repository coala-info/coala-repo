cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyensembl
label: pyensembl_install
doc: "Manipulate pyensembl's local cache.\n\nTool homepage: https://github.com/openvax/pyensembl"
inputs:
  - id: command
    type: string
    doc: "\"install\" will download and index any data that is not\n             \
      \           currently downloaded or indexed. \"delete-all-files\"\n        \
      \                will delete all data associated with a genome\n           \
      \             annotation. \"delete-index-files\" deletes all files\n       \
      \                 other than the original GTF and FASTA files for a\n      \
      \                  genome. \"list\" will show you all installed Ensembl\n  \
      \                      genomes."
    inputBinding:
      position: 1
  - id: gtf
    type:
      - 'null'
      - File
    doc: Path to GTF file
    inputBinding:
      position: 102
      prefix: --gtf
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Force download and indexing even if files already\n                    \
      \    exist locally"
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: protein_fasta
    type:
      - 'null'
      - File
    doc: Path to protein FASTA file
    inputBinding:
      position: 102
      prefix: --protein-fasta
  - id: reference_name
    type:
      - 'null'
      - string
    doc: Name for the reference genome
    inputBinding:
      position: 102
      prefix: --reference-name
  - id: release
    type:
      - 'null'
      - type: array
        items: int
    doc: Ensembl release number
    inputBinding:
      position: 102
      prefix: --release
  - id: species
    type:
      - 'null'
      - type: array
        items: string
    doc: Species to install
    inputBinding:
      position: 102
      prefix: --species
  - id: transcript_fasta
    type:
      - 'null'
      - File
    doc: Path to transcript FASTA file
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
stdout: pyensembl_install.out
