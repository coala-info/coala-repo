cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncotator_initializeDatasource
label: oncotator_initializeDatasource
doc: "Initialize a datasource for Oncotator. (Note: The provided text is a system
  error log regarding container execution and does not contain usage information or
  argument definitions.)\n\nTool homepage: https://github.com/broadinstitute/oncotator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncotator:1.9.9.0--py_0
stdout: oncotator_initializeDatasource.out
