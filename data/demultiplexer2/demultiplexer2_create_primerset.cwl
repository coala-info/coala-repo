cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - demultiplexer2
  - create_primerset
label: demultiplexer2_create_primerset
doc: "Create a primerset\n\nTool homepage: https://github.com/DominikBuchner/demultiplexer2"
inputs:
  - id: n_primers
    type: int
    doc: Define the number of forward and reverse primers in the primerset.
    inputBinding:
      position: 101
      prefix: --n_primers
  - id: name
    type: string
    doc: Define the name for the primerset to create.
    inputBinding:
      position: 101
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0
stdout: demultiplexer2_create_primerset.out
