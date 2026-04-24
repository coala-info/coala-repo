cwlVersion: v1.2
class: CommandLineTool
baseCommand: qhull
label: qhull
doc: "Qhull computes the convex hull, Delaunay triangulation, Voronoi diagram, half-space
  intersection and the medial axis of points, line segments and triangles.\n\nTool
  homepage: https://github.com/qhull/qhull"
inputs:
  - id: run_id
    type:
      - 'null'
      - int
    doc: run-id
    inputBinding:
      position: 101
      prefix: run-id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhull:2015.2--h2d50403_0
stdout: qhull.out
