cwlVersion: v1.2
class: CommandLineTool
baseCommand: qdelaunay
label: qhull_qdelaunay
doc: "The provided text does not contain help information for qhull_qdelaunay; it
  is an error log from a container build process. qdelaunay is typically used to compute
  the Delaunay triangulation of a set of points.\n\nTool homepage: https://github.com/qhull/qhull"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhull:2015.2--h2d50403_0
stdout: qhull_qdelaunay.out
