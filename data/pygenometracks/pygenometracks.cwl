cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygenometracks
label: pygenometracks
doc: "A tool for generating highly customizable publication-ready plots of genomic
  data.\n\nTool homepage: //github.com/maxplanck-ie/pyGenomeTracks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenometracks:3.9--pyhdfd78af_0
stdout: pygenometracks.out
