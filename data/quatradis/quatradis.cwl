cwlVersion: v1.2
class: CommandLineTool
baseCommand: quatradis
label: quatradis
doc: "The provided text is an error log from a container build process and does not
  contain the help documentation or usage instructions for the quatradis tool.\n\n
  Tool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis.out
