cwlVersion: v1.2
class: CommandLineTool
baseCommand: emu build-database
label: emu_build-database
doc: "Builds a custom database for EMU.\n\nTool homepage: https://gitlab.com/treangenlab/emu"
inputs:
  - id: db_name
    type: string
    doc: custom database name
    inputBinding:
      position: 1
  - id: ncbi_taxonomy
    type:
      - 'null'
      - Directory
    doc: path to directory containing both a names.dmp and nodes.dmp file
    inputBinding:
      position: 102
      prefix: --ncbi-taxonomy
  - id: seq2tax
    type: File
    doc: path to tsv mapping species tax id to fasta sequence headers
    inputBinding:
      position: 102
      prefix: --seq2tax
  - id: sequences
    type: File
    doc: path to fasta of database sequences
    inputBinding:
      position: 102
      prefix: --sequences
  - id: taxonomy_list
    type:
      - 'null'
      - File
    doc: path to .tsv file mapping full lineage to corresponding taxid
    inputBinding:
      position: 102
      prefix: --taxonomy-list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emu:3.6.1--hdfd78af_0
stdout: emu_build-database.out
