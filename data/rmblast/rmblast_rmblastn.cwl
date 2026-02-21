cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmblastn
label: rmblast_rmblastn
doc: "RMBlast is a RepeatMasker-compatible version of the standard NCBI BLAST suite.
  Note: The provided help text contains a fatal error from the container runtime and
  does not list specific tool arguments.\n\nTool homepage: https://www.repeatmasker.org/rmblast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmblast:2.14.1--hdb21ba3_2
stdout: rmblast_rmblastn.out
