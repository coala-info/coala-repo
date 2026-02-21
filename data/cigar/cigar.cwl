cwlVersion: v1.2
class: CommandLineTool
baseCommand: cigar
label: cigar
doc: "The provided text is an error log from a container runtime failure and does
  not contain help documentation or argument definitions for the 'cigar' tool.\n\n
  Tool homepage: https://github.com/brentp/cigar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cigar:0.1.3--py_0
stdout: cigar.out
