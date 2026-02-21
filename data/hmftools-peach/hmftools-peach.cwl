cwlVersion: v1.2
class: CommandLineTool
baseCommand: peach
label: hmftools-peach
doc: "The provided text does not contain help information or usage instructions. It
  contains container runtime log messages and a fatal error indicating a failure to
  build the SIF image due to lack of disk space.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/peach/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-peach:2.0.0--hdfd78af_1
stdout: hmftools-peach.out
