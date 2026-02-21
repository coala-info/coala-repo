cwlVersion: v1.2
class: CommandLineTool
baseCommand: qconvex
label: qhull_qconvex
doc: "The provided text does not contain the help documentation for qhull_qconvex.
  It contains error logs related to a Singularity/Apptainer image build failure.\n
  \nTool homepage: https://github.com/qhull/qhull"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhull:2015.2--h2d50403_0
stdout: qhull_qconvex.out
