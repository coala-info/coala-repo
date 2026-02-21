cwlVersion: v1.2
class: CommandLineTool
baseCommand: cat-bgen
label: bgen-cpp_cat-bgen
doc: "The provided text does not contain help information for the tool; it is a log
  of a container build failure due to insufficient disk space. cat-bgen is typically
  used to concatenate BGEN files.\n\nTool homepage: https://enkre.net/cgi-bin/code/bgen/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
stdout: bgen-cpp_cat-bgen.out
