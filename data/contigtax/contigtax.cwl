cwlVersion: v1.2
class: CommandLineTool
baseCommand: contigtax
label: contigtax
doc: "A tool for taxonomical classification of metagenomic contigs.\n\nTool homepage:
  https://github.com/NBISweden/contigtax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
stdout: contigtax.out
