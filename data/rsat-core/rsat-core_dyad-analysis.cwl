cwlVersion: v1.2
class: CommandLineTool
baseCommand: dyad-analysis
label: rsat-core_dyad-analysis
doc: "A tool from the Regulatory Sequence Analysis Tools (RSAT) suite for dyad analysis.
  Note: The provided text contains container build errors and does not list specific
  CLI arguments.\n\nTool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_dyad-analysis.out
