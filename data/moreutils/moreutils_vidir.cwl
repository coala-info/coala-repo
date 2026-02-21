cwlVersion: v1.2
class: CommandLineTool
baseCommand: vidir
label: moreutils_vidir
doc: "The provided text does not contain help information for the tool, but rather
  a system error log indicating a failure to build the container image due to lack
  of disk space. No arguments could be extracted from the input text.\n\nTool homepage:
  https://github.com/madx/moreutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_vidir.out
