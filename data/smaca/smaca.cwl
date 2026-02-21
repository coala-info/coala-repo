cwlVersion: v1.2
class: CommandLineTool
baseCommand: smaca
label: smaca
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/babelomics/SMAca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smaca:1.2.3--py311hc1104ee_6
stdout: smaca.out
