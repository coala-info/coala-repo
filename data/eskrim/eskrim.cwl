cwlVersion: v1.2
class: CommandLineTool
baseCommand: eskrim
label: eskrim
doc: "A tool for processing genomic data (description not provided in help text)\n
  \nTool homepage: https://forgemia.inra.fr/metagenopolis/eskrim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eskrim:1.0.9--pyhdfd78af_1
stdout: eskrim.out
