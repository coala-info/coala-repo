cwlVersion: v1.2
class: CommandLineTool
baseCommand: qvoronoi
label: qhull_qvoronoi
doc: "The provided text does not contain help information for qhull_qvoronoi; it appears
  to be a log of a failed container build process. No arguments could be extracted.\n
  \nTool homepage: https://github.com/qhull/qhull"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhull:2015.2--h2d50403_0
stdout: qhull_qvoronoi.out
