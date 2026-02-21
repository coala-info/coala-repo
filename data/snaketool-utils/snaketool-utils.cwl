cwlVersion: v1.2
class: CommandLineTool
baseCommand: snaketool-utils
label: snaketool-utils
doc: "A utility tool for Snaketool workflows (Note: The provided text appears to be
  a container build log rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/beardymcjohnface/snaketool-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snaketool-utils:0.0.5--pyhdfd78af_0
stdout: snaketool-utils.out
