cwlVersion: v1.2
class: CommandLineTool
baseCommand: womtool
label: womtool
doc: "A tool for working with Workflow Description Language (WDL) files, including
  syntax validation, graph generation, and input template creation.\n\nTool homepage:
  https://cromwell.readthedocs.io/en/develop/WOMtool/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/womtool:61--hdfd78af_0
stdout: womtool.out
