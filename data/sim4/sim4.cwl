cwlVersion: v1.2
class: CommandLineTool
baseCommand: sim4
label: sim4
doc: "sim4 is a tool for aligning an expressed DNA sequence (EST, cDNA, mRNA) with
  a genomic sequence for the gene, allowing for introns and small sequence errors.\n\
  \nTool homepage: https://github.com/sb-ai-lab/Sim4Rec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sim4:v0.0.20121010-5-deb_cv1
stdout: sim4.out
