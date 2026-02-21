cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifive
label: hifive
doc: "HiFive is a suite of tools for handling Hi-C and 5C data.\n\nTool homepage:
  https://github.com/bxlab/hifive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifive:1.5.7--py27h24bf2e0_0
stdout: hifive.out
