cwlVersion: v1.2
class: CommandLineTool
baseCommand: edit-bgen
label: bgen-cpp_edit-bgen
doc: "The provided text does not contain help information or usage instructions. It
  is a log of a failed container build/execution due to insufficient disk space.\n
  \nTool homepage: https://enkre.net/cgi-bin/code/bgen/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
stdout: bgen-cpp_edit-bgen.out
