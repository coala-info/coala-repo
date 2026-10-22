cwlVersion: v1.2
class: CommandLineTool
baseCommand: BuildDatabaseFa.pl
label: trust4_BuildDatabaseFa
doc: "Build the receptor gene reference fasta (coordinates and sequence of V/D/J/C genes) from a genome fasta, a GTF annotation and a list of gene names. The fasta goes to standard output.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: reference
    type: File
    doc: "genome reference fasta"
    inputBinding:
      position: 1
  - id: annotation
    type: File
    doc: "annotation in GTF format (needs gene_name and transcript_name attributes)"
    inputBinding:
      position: 2
  - id: gene_name_list
    type: File
    doc: "text file with one interesting gene name per line"
    inputBinding:
      position: 3
outputs:
  - id: database
    type: stdout
    doc: "Gene reference fasta (standard output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: database.fa
