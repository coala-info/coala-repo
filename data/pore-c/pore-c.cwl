cwlVersion: v1.2
class: CommandLineTool
baseCommand: pore-c
label: pore-c
doc: "A tool for Pore-C data analysis (Note: The provided text is a container build
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://github.com/nanoporetech/pore-c"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
stdout: pore-c.out
