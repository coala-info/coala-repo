cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - guidescan
  - index
label: guidescan_index
doc: "Builds an genomic index over a FASTA file.\n\nTool homepage: https://github.com/pritykinlab/guidescan-cli"
inputs:
  - id: genome
    type: File
    doc: Genome in FASTA format
    inputBinding:
      position: 1
  - id: index
    type:
      - 'null'
      - string
    doc: Genomic index prefix.
    inputBinding:
      position: 102
      prefix: --index
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guidescan:2.2.1--h4ac6f70_2
stdout: guidescan_index.out
