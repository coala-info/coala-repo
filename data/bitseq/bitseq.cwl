cwlVersion: v1.2
class: CommandLineTool
baseCommand: bitseq
label: bitseq
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/BitSeq/BitSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bitseq:v0.7.5dfsg-4-deb_cv1
stdout: bitseq.out
