cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscenic
label: pyscenic
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/fetch process.\n\nTool homepage: https://github.com/aertslab/pySCENIC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscenic:0.12.1--pyhdfd78af_1
stdout: pyscenic.out
