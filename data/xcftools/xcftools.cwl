cwlVersion: v1.2
class: CommandLineTool
baseCommand: xcftools
label: xcftools
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container build process.\n\nTool homepage:
  https://github.com/j-jorge/xcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xcftools:1.0.7--0
stdout: xcftools.out
