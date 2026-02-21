cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapgl
label: mapgl
doc: "A tool for mapping genomic locations between assemblies (Note: The provided
  help text contains only system error messages and no usage information).\n\nTool
  homepage: https://github.com/adadiehl/mapGL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapgl:1.3.1--pyh5ca1d4c_0
stdout: mapgl.out
