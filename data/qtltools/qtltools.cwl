cwlVersion: v1.2
class: CommandLineTool
baseCommand: qtltools
label: qtltools
doc: "The provided text does not contain help information for qtltools; it is a log
  of a failed container build/fetch process.\n\nTool homepage: https://github.com/qtltools/qtltools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qtltools:v1.1dfsg-1-deb_cv1
stdout: qtltools.out
