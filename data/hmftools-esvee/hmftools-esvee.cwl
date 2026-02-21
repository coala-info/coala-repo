cwlVersion: v1.2
class: CommandLineTool
baseCommand: esvee
label: hmftools-esvee
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/esvee/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-esvee:1.2--hdfd78af_0
stdout: hmftools-esvee.out
