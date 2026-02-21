cwlVersion: v1.2
class: CommandLineTool
baseCommand: quasirecomb
label: quasirecomb
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build/fetch process.\n\nTool homepage: https://github.com/cbg-ethz/QuasiRecomb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasirecomb:1.2--0
stdout: quasirecomb.out
