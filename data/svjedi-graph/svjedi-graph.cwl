cwlVersion: v1.2
class: CommandLineTool
baseCommand: svjedi-graph
label: svjedi-graph
doc: "A tool for structural variant genotyping using variation graphs. Note: The provided
  text contains installation/container logs rather than help documentation, so specific
  arguments could not be extracted.\n\nTool homepage: https://github.com/SandraLouise/SVJedi-graph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svjedi-graph:1.2.1--hdfd78af_0
stdout: svjedi-graph.out
