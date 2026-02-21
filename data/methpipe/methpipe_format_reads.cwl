cwlVersion: v1.2
class: CommandLineTool
baseCommand: format_reads
label: methpipe_format_reads
doc: "The provided text is an error log indicating a failure to build the container
  image (no space left on device) and does not contain help information or argument
  definitions.\n\nTool homepage: https://github.com/smithlabcode/methpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
stdout: methpipe_format_reads.out
