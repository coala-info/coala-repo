cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-taxonomy-majority-vote
label: autometa_autometa-taxonomy-majority-vote
doc: "Script to assign taxonomy via a modified majority voting algorithm.\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: lca
    type: File
    doc: "Path to LCA results table."
    inputBinding:
      position: 1
      prefix: --lca
  - id: output
    type: string
    doc: "Path to write voted taxid results table."
    inputBinding:
      position: 1
      prefix: --output
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: "Path to taxonomy database directory."
    inputBinding:
      position: 1
      prefix: --dbdir
  - id: dbtype
    type:
      - 'null'
      - string
    doc: "Taxonomy database to use (ncbi, gtdb) (default: ncbi)"
    inputBinding:
      position: 1
      prefix: --dbtype
  - id: orfs
    type:
      - 'null'
      - File
    doc: "Path to ORFs fasta containing amino-acid sequences (Only required for prodigal version < 2.6)"
    inputBinding:
      position: 1
      prefix: --orfs
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Add verbosity to logging stream."
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: votes_out
    type: File
    doc: "Voted taxid results table"
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
