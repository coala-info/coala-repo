cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastlink
label: fastlink
doc: "The provided text is an error log from a container build process and does not
  contain the help text or usage information for the fastlink tool. Fastlink is a
  suite of programs for genetic linkage analysis, but no arguments could be extracted
  from the input provided.\n\nTool homepage: https://github.com/kosukeimai/fastLink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastlink:v4.1P-fix100dfsg-2-deb_cv1
stdout: fastlink.out
