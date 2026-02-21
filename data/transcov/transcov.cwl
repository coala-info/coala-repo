cwlVersion: v1.2
class: CommandLineTool
baseCommand: transcov
label: transcov
doc: "A tool for transcriptome coverage analysis (Note: The provided text is a system
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://github.com/hogfeldt/transcov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
stdout: transcov.out
