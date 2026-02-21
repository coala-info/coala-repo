cwlVersion: v1.2
class: CommandLineTool
baseCommand: NanoLyse
label: nanopack_NanoLyse
doc: "The provided text is an error log regarding a container build failure and does
  not contain help information or argument definitions for the tool.\n\nTool homepage:
  https://github.com/wdecoster/nanopack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
stdout: nanopack_NanoLyse.out
