cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctdopts_build
label: ctdopts_build
doc: "The provided text appears to be an error log from a container build process
  rather than CLI help text. No arguments or options could be extracted.\n\nTool homepage:
  https://github.com/WorkflowConversion/CTDopts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ctdopts:v1.2-3-deb-py3_cv1
stdout: ctdopts_build.out
