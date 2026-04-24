cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyensembl
  - delete-index-files
label: pyensembl_delete-index-files
doc: "Deletes all files other than the original GTF and FASTA files for a genome.\n\
  \nTool homepage: https://github.com/openvax/pyensembl"
inputs:
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Force download and indexing even if files already exist locally
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: release
    type: int
    doc: Ensembl release number
    inputBinding:
      position: 101
      prefix: --release
  - id: species
    type:
      - 'null'
      - type: array
        items: string
    doc: Species to install data for
    inputBinding:
      position: 101
      prefix: --species
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyensembl:2.3.13--pyh7cba7a3_0
stdout: pyensembl_delete-index-files.out
