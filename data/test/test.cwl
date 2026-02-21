cwlVersion: v1.2
class: CommandLineTool
baseCommand: test
label: test
doc: "The provided text appears to be execution logs rather than help text. It indicates
  a failure to build or handle a SIF (Singularity Image Format) file from a Docker
  URI for the tool 'test'.\n\nTool homepage: https://github.com/lh3/seqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/test:0.1--h73052cd_7
stdout: test.out
