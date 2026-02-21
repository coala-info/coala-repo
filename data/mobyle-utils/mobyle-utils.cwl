cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobyle-utils
label: mobyle-utils
doc: 'A collection of utilities for the Mobyle portal. (Note: The provided help text
  contains only system error messages and no usage information.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mobyle-utils:v1.5.5dfsg-6-deb_cv1
stdout: mobyle-utils.out
