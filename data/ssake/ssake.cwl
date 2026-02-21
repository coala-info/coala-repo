cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssake
label: ssake
doc: "SSAKE (Short Sequence Assembly by K-mer Extension) is a genomics tool for assembling
  short DNA sequences. Note: The provided text appears to be a container engine error
  log rather than help text, so no arguments could be extracted.\n\nTool homepage:
  https://github.com/warrenlr/SSAKE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ssake:v4.0-2-deb_cv1
stdout: ssake.out
