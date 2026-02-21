cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoQC
label: nanopack_NanoQC
doc: "The provided text is an error log indicating a failure to pull or build the
  container image ('no space left on device') and does not contain help documentation
  or usage instructions. Consequently, no arguments could be extracted.\n\nTool homepage:
  https://github.com/wdecoster/nanopack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
stdout: nanopack_NanoQC.out
