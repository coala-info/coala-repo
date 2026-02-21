cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preseq
  - gc_extrap
label: preseq_gc_extrap
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/smithlabcode/preseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq_gc_extrap.out
