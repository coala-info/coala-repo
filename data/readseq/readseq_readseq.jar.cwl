cwlVersion: v1.2
class: CommandLineTool
baseCommand: readseq
label: readseq_readseq.jar
doc: "A tool for converting biological sequence formats. (Note: The provided text
  is a container execution error log and does not contain usage instructions or argument
  definitions.)\n\nTool homepage: http://iubio.bio.indiana.edu/soft/molbio/readseq/java/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/readseq:2.1.30--1
stdout: readseq_readseq.jar.out
