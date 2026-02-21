cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyranges
label: pyranges
doc: "The provided text is a system error log from a container build process and does
  not contain help documentation or argument definitions for the pyranges tool.\n\n
  Tool homepage: http://github.com/endrebak/pyranges"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyranges:0.1.4--pyhdfd78af_0
stdout: pyranges.out
