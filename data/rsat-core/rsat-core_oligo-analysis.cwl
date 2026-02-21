cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligo-analysis
label: rsat-core_oligo-analysis
doc: "The provided text is a system error log from a container build process and does
  not contain help information or usage instructions for the tool.\n\nTool homepage:
  http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_oligo-analysis.out
