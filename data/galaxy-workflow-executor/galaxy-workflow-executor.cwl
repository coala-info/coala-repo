cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-workflow-executor
label: galaxy-workflow-executor
doc: "A tool for executing Galaxy workflows.\n\nTool homepage: https://github.com/ebi-gene-expression-group/galaxy-workflow-executor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-workflow-executor:0.2.6--pyh5e36f6f_0
stdout: galaxy-workflow-executor.out
