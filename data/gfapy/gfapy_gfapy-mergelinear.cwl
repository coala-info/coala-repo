cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfapy-mergelinear
label: gfapy_gfapy-mergelinear
doc: "A tool from the gfapy package, likely used for merging linear paths in GFA files.
  Note: The provided help text contains only container runtime error messages and
  no usage information.\n\nTool homepage: https://github.com/ggonnella/gfapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfapy:1.2.3--pyhdfd78af_0
stdout: gfapy_gfapy-mergelinear.out
