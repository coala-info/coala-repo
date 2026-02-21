cwlVersion: v1.2
class: CommandLineTool
baseCommand: cell-types-analysis
label: cell-types-analysis
doc: "The provided text is an error log from a container build process and does not
  contain help information or a description of the tool's functionality.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
stdout: cell-types-analysis.out
