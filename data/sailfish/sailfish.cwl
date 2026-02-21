cwlVersion: v1.2
class: CommandLineTool
baseCommand: sailfish
label: sailfish
doc: "Sailfish is a tool for estimating the abundance of isoforms from RNA-seq data.
  (Note: The provided text is a container build error log and does not contain help
  documentation or argument definitions.)\n\nTool homepage: https://github.com/rust-sailfish/sailfish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sailfish:0.10.1--1
stdout: sailfish.out
