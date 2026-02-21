cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - metacherchant.jar
label: metacherchant_metacherchant.jar
doc: "Metagenomic tool for analyzing metabolic pathways (Note: The provided help text
  contains only container runtime error messages and no usage information).\n\nTool
  homepage: https://github.com/ctlab/metacherchant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacherchant:0.1.0--1
stdout: metacherchant_metacherchant.jar.out
