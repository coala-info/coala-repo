cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagraph
label: metagraph_the
doc: "metagraph is a tool for constructing, manipulating, and querying sequence graphs.\n\
  \nTool homepage: https://github.com/ratschlab/metagraph"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., build, clean, transform, align, annotate,
      relax_brwt, transform_anno, assemble, query, server_query, stats)
    inputBinding:
      position: 1
  - id: advanced
    type:
      - 'null'
      - boolean
    doc: show other advanced and legacy options
    inputBinding:
      position: 102
      prefix: --advanced
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagraph:0.5.0--haea4672_0
stdout: metagraph_the.out
