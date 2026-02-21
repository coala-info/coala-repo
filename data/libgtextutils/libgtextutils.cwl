cwlVersion: v1.2
class: CommandLineTool
baseCommand: libgtextutils
label: libgtextutils
doc: "The provided text is an error message indicating a failure to pull or build
  the container image due to insufficient disk space ('no space left on device'),
  rather than help text for the tool itself. As a result, no command-line arguments
  or usage instructions could be extracted.\n\nTool homepage: https://github.com/agordon/libgtextutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libgtextutils:0.7--hdbdd923_13
stdout: libgtextutils.out
