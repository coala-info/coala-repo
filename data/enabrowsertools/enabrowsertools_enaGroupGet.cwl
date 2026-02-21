cwlVersion: v1.2
class: CommandLineTool
baseCommand: enaGroupGet
label: enabrowsertools_enaGroupGet
doc: "A tool from the enabrowsertools suite. Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  arguments or usage instructions.\n\nTool homepage: https://github.com/enasequence/enaBrowserTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enabrowsertools:1.7.2--hdfd78af_0
stdout: enabrowsertools_enaGroupGet.out
