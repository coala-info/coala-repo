cwlVersion: v1.2
class: CommandLineTool
baseCommand: merfishtools gen-mhd4
label: merfishtools_gen-mhd4
doc: "Generate MERFISH MHD4 codebook with given parameters.\n\nTool homepage: https://merfishtools.github.io"
inputs:
  - id: not_expressed
    type:
      - 'null'
      - string
    doc: Regular expression pattern for features that should be marked as not 
      expressed. This is useful to correctly model, e.g., misidentification 
      probes.
    inputBinding:
      position: 101
      prefix: --not-expressed
  - id: onebits
    type: int
    doc: Number of 1-bits.
    inputBinding:
      position: 101
      prefix: --onebits
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
stdout: merfishtools_gen-mhd4.out
