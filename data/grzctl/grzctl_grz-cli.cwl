cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grzctl
  - grz-cli
label: grzctl_grz-cli
doc: "The provided text contains error logs and environment information rather than
  help documentation. No arguments or tool descriptions could be extracted from the
  input.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_grz-cli.out
