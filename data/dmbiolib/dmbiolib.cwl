cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmbiolib
label: dmbiolib
doc: "A bioinformatics library tool. (Note: The provided text contains container runtime
  error messages rather than the tool's help documentation.)\n\nTool homepage: https://github.com/damienmarsic/dmbiolib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmbiolib:0.4.3--pyhdfd78af_0
stdout: dmbiolib.out
