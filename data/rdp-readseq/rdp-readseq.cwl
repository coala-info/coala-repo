cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdp-readseq
label: rdp-readseq
doc: The provided text does not contain help information or usage instructions for
  rdp-readseq; it is a log of a failed container image retrieval.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
stdout: rdp-readseq.out
