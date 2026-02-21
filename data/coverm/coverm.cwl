cwlVersion: v1.2
class: CommandLineTool
baseCommand: coverm
label: coverm
doc: "A tool for calculating coverage of metagenomic assemblies (Note: The provided
  text is an error log and does not contain help documentation).\n\nTool homepage:
  https://github.com/wwood/coverm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coverm:0.7.0--hcb7b614_4
stdout: coverm.out
