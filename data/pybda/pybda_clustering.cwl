cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybda
  - clustering
label: pybda_clustering
doc: "Do a clustering fit from a CONFIG in a SPARK session.\n\nTool homepage: https://github.com/cbg-ethz/pybda"
inputs:
  - id: config
    type: string
    doc: Configuration file for clustering
    inputBinding:
      position: 1
  - id: spark
    type: string
    doc: Spark session identifier
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybda:0.1.0--pyh5ca1d4c_0
stdout: pybda_clustering.out
