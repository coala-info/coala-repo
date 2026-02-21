cwlVersion: v1.2
class: CommandLineTool
baseCommand: ska2
label: ska2
doc: "Split K-mer Analysis (SKA) for genomic distance and SNP phylogeny\n\nTool homepage:
  https://github.com/bacpop/ska.rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
stdout: ska2.out
