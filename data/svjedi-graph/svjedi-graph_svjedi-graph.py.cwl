cwlVersion: v1.2
class: CommandLineTool
baseCommand: svjedi-graph.py
label: svjedi-graph_svjedi-graph.py
doc: "A tool for structural variant genotyping using a variation graph. (Note: The
  provided text is a container build error log and does not contain help documentation;
  arguments could not be extracted.)\n\nTool homepage: https://github.com/SandraLouise/SVJedi-graph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svjedi-graph:1.2.1--hdfd78af_0
stdout: svjedi-graph_svjedi-graph.py.out
