cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd
label: ggd
doc: "Go Get Data (ggd) - A tool for managing and accessing genomic data packages.\n
  \nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd.out
