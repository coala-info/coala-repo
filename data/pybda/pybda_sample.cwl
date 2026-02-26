cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybda_sample
label: pybda_sample
doc: "Subsample a data set down to a specified fraction from a CONFIG in a SPARK session.\n\
  \nTool homepage: https://github.com/cbg-ethz/pybda"
inputs:
  - id: config
    type: string
    doc: CONFIG
    inputBinding:
      position: 1
  - id: spark
    type: string
    doc: SPARK session
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybda:0.1.0--pyh5ca1d4c_0
stdout: pybda_sample.out
