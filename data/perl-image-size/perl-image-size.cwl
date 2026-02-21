cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-image-size
label: perl-image-size
doc: "A tool to determine the size of images in several common formats.\n\nTool homepage:
  https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-image-size:3.300--0
stdout: perl-image-size.out
