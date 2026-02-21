cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanolyse
label: nanolyse
doc: "A tool for removing DNA contaminant reads (e.g., lambda phage) from Nanopore
  sequencing data.\n\nTool homepage: https://github.com/wdecoster/NanoLyse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanolyse:1.2.1--pyhdfd78af_0
stdout: nanolyse.out
