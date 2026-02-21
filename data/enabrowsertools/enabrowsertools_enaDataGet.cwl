cwlVersion: v1.2
class: CommandLineTool
baseCommand: enaDataGet
label: enabrowsertools_enaDataGet
doc: "The provided text does not contain help information for the tool; it contains
  system log messages and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: https://github.com/enasequence/enaBrowserTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enabrowsertools:1.7.2--hdfd78af_0
stdout: enabrowsertools_enaDataGet.out
