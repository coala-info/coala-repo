cwlVersion: v1.2
class: CommandLineTool
baseCommand: cramino
label: nanopack_Cramino
doc: "A tool for CRAM/BAM/SAM statistics (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/wdecoster/nanopack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
stdout: nanopack_Cramino.out
