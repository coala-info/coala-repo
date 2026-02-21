cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpy2
label: rpy2
doc: "Python interface to the R language (Note: The provided text is a container build
  log and does not contain CLI help information or argument definitions).\n\nTool
  homepage: https://github.com/rpy2/rpy2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpy2:2.9.4--2
stdout: rpy2.out
