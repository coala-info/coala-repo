cwlVersion: v1.2
class: CommandLineTool
baseCommand: merfishtools
label: merfishtools
doc: "A tool for processing MERFISH (Multiplexed Error-Robust Fluorescence In Situ
  Hybridization) data.\n\nTool homepage: https://merfishtools.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
stdout: merfishtools.out
