cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqchromloader
label: seqchromloader
doc: "The provided text is a system error log regarding a failed container build (no
  space left on device) and does not contain help information or argument definitions
  for the tool.\n\nTool homepage: https://github.com/yztxwd/seqchromloader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqchromloader:0.9.1--pyhdfd78af_0
stdout: seqchromloader.out
