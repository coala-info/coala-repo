cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - footprint-discovery
label: rsat-core_footprint-discovery
doc: "A tool from the RSAT (Regulatory Sequence Analysis Tools) suite for footprint
  discovery. Note: The provided help text contains only system error messages and
  no usage information.\n\nTool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_footprint-discovery.out
