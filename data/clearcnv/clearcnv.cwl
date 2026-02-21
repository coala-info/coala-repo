cwlVersion: v1.2
class: CommandLineTool
baseCommand: clearcnv
label: clearcnv
doc: "The provided text appears to be a system error log regarding a container image
  build failure ('no space left on device') rather than the tool's help text. Consequently,
  no command-line arguments could be extracted.\n\nTool homepage: https://github.com/bihealth/clear-cnv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
stdout: clearcnv.out
