cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert-seq
label: rsat-core_convert-seq
doc: "A tool from the RSAT (Regulatory Sequence Analysis Tools) suite used for converting
  sequence formats. Note: The provided help text contains only container runtime logs
  and does not list specific arguments.\n\nTool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_convert-seq.out
