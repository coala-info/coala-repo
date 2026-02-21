cwlVersion: v1.2
class: CommandLineTool
baseCommand: viloca
label: viloca
doc: "VIral LOw-frequency CAlling (V-loCa) - A tool for detecting low-frequency variants
  in viral populations.\n\nTool homepage: https://github.com/cbg-ethz/VILOCA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viloca:1.1.0--pyhdfd78af_0
stdout: viloca.out
