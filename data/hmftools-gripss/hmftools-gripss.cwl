cwlVersion: v1.2
class: CommandLineTool
baseCommand: gripss
label: hmftools-gripss
doc: "The provided text is a system error message (disk space exhaustion during container
  pull) and does not contain the help documentation for hmftools-gripss. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/gripss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-gripss:2.4--hdfd78af_0
stdout: hmftools-gripss.out
