cwlVersion: v1.2
class: CommandLineTool
baseCommand: sctriangulate
label: sctriangulate
doc: "A tool for single-cell data integration and triangulation. (Note: The provided
  text is a container build error log and does not contain specific command-line argument
  definitions.)\n\nTool homepage: https://github.com/frankligy/scTriangulate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sctriangulate:0.13.0--pyhdfd78af_0
stdout: sctriangulate.out
