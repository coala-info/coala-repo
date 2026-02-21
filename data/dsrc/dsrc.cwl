cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsrc
label: dsrc
doc: "DNA Sequence Read Compressor (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/refresh-bio/DSRC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsrc:2015.06.04--h077b44d_10
stdout: dsrc.out
