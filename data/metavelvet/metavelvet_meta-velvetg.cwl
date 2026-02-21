cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-velvetg
label: metavelvet_meta-velvetg
doc: "Meta-Velvet is an extension of Velvet for metagenome assembly. meta-velvetg
  is the graph processing step that identifies and separates sub-graphs of individual
  species.\n\nTool homepage: https://github.com/hacchy/MetaVelvet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metavelvet:1.2.02--1
stdout: metavelvet_meta-velvetg.out
