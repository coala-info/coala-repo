cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-velvetg
label: metavelvet_velvetg
doc: "A tool for metagenome assembly (Note: The provided help text contains only system
  error messages regarding container execution and does not list command-line arguments).\n
  \nTool homepage: https://github.com/hacchy/MetaVelvet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metavelvet:1.2.02--1
stdout: metavelvet_velvetg.out
