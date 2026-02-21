cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsidx
label: rsidx
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/fetch attempt.\n\nTool homepage: https://github.com/bioforensics/rsidx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsidx:0.3.1--pyhdfd78af_0
stdout: rsidx.out
