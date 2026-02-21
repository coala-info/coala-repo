cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabolishmm
label: metabolishmm
doc: "Metabolishmm is a tool for searching and summarizing metabolic genes in genomes
  or metagenomes. (Note: The provided input text contains system error messages regarding
  container execution and does not include the actual help documentation for the tool.)\n
  \nTool homepage: https://github.com/elizabethmcd/metabolisHMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolishmm:2.22--pyhdfd78af_0
stdout: metabolishmm.out
