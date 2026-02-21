cwlVersion: v1.2
class: CommandLineTool
baseCommand: vuegen_quarto
label: vuegen_quarto
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build or execution attempt.\n
  \nTool homepage: https://github.com/Multiomics-Analytics-Group/vuegen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vuegen:0.5.1--pyhdfd78af_0
stdout: vuegen_quarto.out
