cwlVersion: v1.2
class: CommandLineTool
baseCommand: readseq
label: readseq
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: http://iubio.bio.indiana.edu/soft/molbio/readseq/java/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/readseq:2.1.30--1
stdout: readseq.out
