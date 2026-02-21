cwlVersion: v1.2
class: CommandLineTool
baseCommand: sharg
label: sharg
doc: "The provided text does not contain help information for the tool 'sharg'. It
  consists of system logs and a fatal error message regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/seqan/sharg-parser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sharg:1.2.1--hd63eeec_0
stdout: sharg.out
