cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_estshift
label: bart_estshift
doc: "Estimate shift in spectral data\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: flags
    type: string
    doc: Flags for the estimation
    inputBinding:
      position: 1
  - id: arg1
    type: string
    doc: First argument
    inputBinding:
      position: 2
  - id: arg2
    type: string
    doc: Second argument
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_estshift.out
