cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-build
label: centrifuge-core_centrifuge-build
doc: "The provided text is an error log from a container build process and does not
  contain the help documentation for centrifuge-build. Under normal circumstances,
  centrifuge-build is used to build Centrifuge indices from reference sequences.\n
  \nTool homepage: https://github.com/infphilo/centrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
stdout: centrifuge-core_centrifuge-build.out
