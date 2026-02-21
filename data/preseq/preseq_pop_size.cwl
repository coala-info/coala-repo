cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preseq
  - pop_size
label: preseq_pop_size
doc: "The provided text does not contain help information for the tool; it is a log
  of a container execution failure.\n\nTool homepage: https://github.com/smithlabcode/preseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq_pop_size.out
