cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - args_oap
  - make_db
label: args_oap_make_db
doc: "Create a database from a FASTA file (nucleotide or protein).\n\nTool homepage:
  https://github.com/xinehc/args_oap"
inputs:
  - id: infile
    type: File
    doc: Database FASTA file. Can be either nucleotide or protein.
    inputBinding:
      position: 101
      prefix: --infile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/args_oap:3.2.4--pyhdfd78af_0
stdout: args_oap_make_db.out
