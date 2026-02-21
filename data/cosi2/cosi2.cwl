cwlVersion: v1.2
class: CommandLineTool
baseCommand: cosi2
label: cosi2
doc: "A coalescent simulator for populations with complex histories.\n\nTool homepage:
  https://www.broadinstitute.org/mpg/cosi2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cosi2:2.3.0rc3--py35_0
stdout: cosi2.out
