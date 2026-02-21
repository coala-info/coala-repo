cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmftools-redux
label: hmftools-redux
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding disk space during a container image
  conversion.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/redux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-redux:1.2.3--hdfd78af_0
stdout: hmftools-redux.out
