cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastp
label: ncbi-blast-plus_blastp
doc: "Protein-Protein BLAST\n\nTool homepage: https://github.com/ncbi/blast_plus_docs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-blast-plus:v2.8.1-1-deb_cv1
stdout: ncbi-blast-plus_blastp.out
