cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapely
label: shapely
doc: "A Python package for manipulation and analysis of planar geometric objects (Note:
  The provided text is a container build error log and does not contain CLI help information).\n
  \nTool homepage: https://github.com/shapely/shapely"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapely:2.0.4
stdout: shapely.out
