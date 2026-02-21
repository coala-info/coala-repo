cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaapler
label: dnaapler
doc: "A tool for reorienting circular genomes (Note: The provided help text contains
  only container runtime error messages and does not list specific tool arguments).\n
  \nTool homepage: https://github.com/gbouras13/dnaapler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
stdout: dnaapler.out
