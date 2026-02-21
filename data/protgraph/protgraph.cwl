cwlVersion: v1.2
class: CommandLineTool
baseCommand: protgraph
label: protgraph
doc: "A tool for protein graph construction and analysis (Note: The provided text
  was a container execution log and did not contain help documentation; no arguments
  could be extracted).\n\nTool homepage: https://github.com/mpc-bioinformatics/ProtGraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protgraph:0.3.12--pyhdfd78af_0
stdout: protgraph.out
