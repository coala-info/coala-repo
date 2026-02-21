cwlVersion: v1.2
class: CommandLineTool
baseCommand: sfs
label: sfs
doc: "The provided text contains execution logs for a container build rather than
  help documentation. No CLI arguments or tool descriptions could be extracted.\n\n
  Tool homepage: https://github.com/malthesr/sfs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
stdout: sfs.out
