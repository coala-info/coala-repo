cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropletutils-scripts
label: dropletutils-scripts
doc: "A collection of scripts for processing single-cell RNA-seq data using the DropletUtils
  package. (Note: The provided help text contains system error messages and does not
  list specific command-line arguments.)\n\nTool homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropletutils-scripts:0.0.5--hdfd78af_1
stdout: dropletutils-scripts.out
