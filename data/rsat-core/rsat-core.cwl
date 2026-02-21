cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsat-core
label: rsat-core
doc: "Regulatory Sequence Analysis Tools (RSAT) core\n\nTool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core.out
