cwlVersion: v1.2
class: CommandLineTool
baseCommand: unzip
label: unzip
doc: "The provided text does not contain help information for the unzip tool; it appears
  to be a container build error log.\n\nTool homepage: https://github.com/peazip/PeaZip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unzip:6.0--2
stdout: unzip.out
