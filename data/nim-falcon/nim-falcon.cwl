cwlVersion: v1.2
class: CommandLineTool
baseCommand: nim-falcon
label: nim-falcon
doc: "A tool for genomic analysis (Note: The provided text is a container runtime
  error message and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/bio-nim/nim-falcon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nim-falcon:3.0.2--h4b1250d_2
stdout: nim-falcon.out
