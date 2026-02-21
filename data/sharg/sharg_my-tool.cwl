cwlVersion: v1.2
class: CommandLineTool
baseCommand: sharg_my-tool
label: sharg_my-tool
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process due to insufficient disk space.\n\n
  Tool homepage: https://github.com/seqan/sharg-parser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sharg:1.2.1--hd63eeec_0
stdout: sharg_my-tool.out
