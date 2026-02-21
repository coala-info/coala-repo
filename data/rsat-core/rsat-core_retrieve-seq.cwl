cwlVersion: v1.2
class: CommandLineTool
baseCommand: retrieve-seq
label: rsat-core_retrieve-seq
doc: "The provided text does not contain help information for the tool, but rather
  container runtime error messages. No arguments could be extracted.\n\nTool homepage:
  http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_retrieve-seq.out
