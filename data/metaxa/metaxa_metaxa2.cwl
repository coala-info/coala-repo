cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2
label: metaxa_metaxa2
doc: "Metaxa2 is a tool for automated identification and classification of ribosomal
  RNA sequences (12S, 16S, 18S, 23S, 25S, 28S, and ITS) from different taxonomic groups.\n
  \nTool homepage: http://microbiology.se/software/metaxa2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
stdout: metaxa_metaxa2.out
