cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-stxtyper
label: ncbi-stxtyper
doc: "Note: The provided text is an error log indicating a failure to build the container
  image due to insufficient disk space ('no space left on device') and does not contain
  the actual help text or argument definitions for the tool.\n\nTool homepage: https://github.com/ncbi/stxtyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-stxtyper:1.0.45--h9948957_0
stdout: ncbi-stxtyper.out
