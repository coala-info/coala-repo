cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthomcl
label: orthomcl
doc: "OrthoMCL is a genome-scale algorithm for grouping proteins into orthologous
  clusters. (Note: The provided text is a system error message regarding container
  image creation and does not contain command-line usage or argument definitions.)\n
  \nTool homepage: http://orthomcl.org/orthomcl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthomcl:2.0.9--pl5.22.0_0
stdout: orthomcl.out
