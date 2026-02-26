cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybda
  - dimension-reduction
label: pybda_dimension-reduction
doc: "Computes a dimension reduction from a CONFIG in a SPARK session.\n\nTool homepage:
  https://github.com/cbg-ethz/pybda"
inputs:
  - id: config
    type: string
    doc: Configuration file for dimension reduction
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
stdout: pybda_dimension-reduction.out
