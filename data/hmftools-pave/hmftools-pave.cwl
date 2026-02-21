cwlVersion: v1.2
class: CommandLineTool
baseCommand: pave
label: hmftools-pave
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image building (no space
  left on device).\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/pave"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-pave:1.8.2--hdfd78af_0
stdout: hmftools-pave.out
