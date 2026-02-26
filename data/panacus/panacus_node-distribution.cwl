cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panacus
  - node-distribution
label: panacus_node-distribution
doc: "Return the list of bins with there coverages, log10-lengths and log10-sizes.
  Due to this being the values for the centers of the hexagons shown in the html plot
  and not real values, some values might be negative.\n\nTool homepage: https://github.com/marschall-lab/panacus"
inputs:
  - id: gfa_file
    type: File
    doc: graph in GFA1 format, accepts also compressed (.gz) file
    inputBinding:
      position: 1
  - id: radius
    type:
      - 'null'
      - int
    doc: Radius of the hexagons used to bin
    default: 20
    inputBinding:
      position: 102
      prefix: --radius
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Set the number of threads used (default: use all threads)'
    default: 0
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Set the number of threads used (default: use all threads)'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
stdout: panacus_node-distribution.out
