cwlVersion: v1.2
class: CommandLineTool
baseCommand: orange
label: hmftools-orange
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/orange/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-orange:4.1.3--hdfd78af_0
stdout: hmftools-orange.out
