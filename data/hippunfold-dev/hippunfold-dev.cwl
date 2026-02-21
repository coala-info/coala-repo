cwlVersion: v1.2
class: CommandLineTool
baseCommand: hippunfold-dev
label: hippunfold-dev
doc: "Automated hippocampal unfolding and processing. (Note: The provided help text
  contains only container execution error logs and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/khanlab/hippunfold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hippunfold-dev:2.0.0--pyh7e72e81_0
stdout: hippunfold-dev.out
