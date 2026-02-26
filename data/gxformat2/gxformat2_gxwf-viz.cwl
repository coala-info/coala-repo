cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxwf-viz
label: gxformat2_gxwf-viz
doc: "This script converts an executable Galaxy workflow (in either format - Format
  2 or native .ga) into a format for visualization with Cytoscape (https://cytoscape.org/).
  If the target output path ends with .html this script will output a HTML page with
  the workflow visualized using cytoscape.js. Otherwise, this script will output a
  JSON description of the workflow elements for consumption by Cytoscape.\n\nTool
  homepage: https://github.com/jmchilton/gxformat2"
inputs:
  - id: input
    type: File
    doc: input workflow path (.ga/gxwf.yml)
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - File
    doc: output viz path (.json/.html)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxformat2:0.22.0--pyhdfd78af_0
stdout: gxformat2_gxwf-viz.out
