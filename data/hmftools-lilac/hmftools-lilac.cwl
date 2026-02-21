cwlVersion: v1.2
class: CommandLineTool
baseCommand: lilac
label: hmftools-lilac
doc: "The provided text does not contain help information or usage instructions. It
  is an error log reporting a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/lilac/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-lilac:1.7.3--hdfd78af_0
stdout: hmftools-lilac.out
