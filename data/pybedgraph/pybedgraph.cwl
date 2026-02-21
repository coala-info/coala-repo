cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybedgraph
label: pybedgraph
doc: "The provided text is a container engine error log and does not contain help
  documentation or usage instructions for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: https://github.com/TheJacksonLaboratory/pyBedGraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybedgraph:0.5.43--py311h8ddd9a4_6
stdout: pybedgraph.out
