cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-workflow-executor_generate_params_from_workflow.py
label: galaxy-workflow-executor_generate_params_from_workflow.py
doc: "A tool to generate parameters from a Galaxy workflow. Note: The provided help
  text contains execution logs and error messages rather than usage instructions,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/ebi-gene-expression-group/galaxy-workflow-executor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-workflow-executor:0.2.6--pyh5e36f6f_0
stdout: galaxy-workflow-executor_generate_params_from_workflow.py.out
