cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadbit
label: tadbit
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a container build error log.\n\nTool homepage: http://sgt.cnag.cat/3dg/tadbit/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadbit:1.0.1--py310h2a84d7f_1
stdout: tadbit.out
