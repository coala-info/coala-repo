cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-unicode-map
label: perl-unicode-map
doc: "The provided text is an error log indicating a failure to pull or run the container
  due to insufficient disk space and does not contain help text or usage information
  for the tool.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-unicode-map:0.112--pl5321h9948957_9
stdout: perl-unicode-map.out
