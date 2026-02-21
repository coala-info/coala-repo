cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hifive
  - quasar-qc
label: hifive_quasar-qc
doc: "A tool for Hi-C quality control using the QuASAR (Quality Assessment of Spatial
  Agreement and Reliability) method. Note: The provided text contains system error
  messages regarding container execution and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/bxlab/hifive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifive:1.5.7--py27h24bf2e0_0
stdout: hifive_quasar-qc.out
