cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmftools-gene-utils
label: hmftools-gene-utils
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/gene-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-gene-utils:1.3--hdfd78af_0
stdout: hmftools-gene-utils.out
