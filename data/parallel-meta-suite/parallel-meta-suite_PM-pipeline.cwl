cwlVersion: v1.2
class: CommandLineTool
baseCommand: PM-pipeline
label: parallel-meta-suite_PM-pipeline
doc: "Parallel-META Suite pipeline (Note: The provided help text only contains environment
  error messages and does not list specific command-line arguments).\n\nTool homepage:
  https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h9948957_5
stdout: parallel-meta-suite_PM-pipeline.out
