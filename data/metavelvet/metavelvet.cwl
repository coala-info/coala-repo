cwlVersion: v1.2
class: CommandLineTool
baseCommand: metavelvet
label: metavelvet
doc: "Meta-Velvet: An extension of Velvet assembler for metagenome assembly. (Note:
  The provided input text contained container runtime error messages rather than tool
  help text, so no arguments could be extracted.)\n\nTool homepage: https://github.com/hacchy/MetaVelvet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metavelvet:1.2.02--1
stdout: metavelvet.out
