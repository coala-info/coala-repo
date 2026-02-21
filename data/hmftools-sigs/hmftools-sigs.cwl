cwlVersion: v1.2
class: CommandLineTool
baseCommand: sigs
label: hmftools-sigs
doc: "The provided text contains system error messages and logs related to a container
  environment failure (no space left on device) rather than the tool's help documentation.
  As a result, no arguments or tool descriptions could be extracted from the input.\n
  \nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/sigs/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-sigs:1.2.1--hdfd78af_1
stdout: hmftools-sigs.out
