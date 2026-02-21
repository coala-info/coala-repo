cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-workflow-executor_run_galaxy_workflow.py
label: galaxy-workflow-executor_run_galaxy_workflow.py
doc: "A tool to run Galaxy workflows. (Note: The provided text appears to be an execution
  error log rather than help text, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/galaxy-workflow-executor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-workflow-executor:0.2.6--pyh5e36f6f_0
stdout: galaxy-workflow-executor_run_galaxy_workflow.py.out
