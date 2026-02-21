cwlVersion: v1.2
class: CommandLineTool
baseCommand: vclean
label: vclean
doc: "The provided text does not contain help information or documentation for the
  tool 'vclean'. It appears to be a log of a failed container build or execution environment
  setup.\n\nTool homepage: https://github.com/TsumaR/vclean"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vclean:0.2.1--pyhdfd78af_0
stdout: vclean.out
