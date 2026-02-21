cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_guess_seq_format
label: seq_crumbs_guess_seq_format
doc: "Guess the sequence format of a file. (Note: The provided help text contains
  container build error logs rather than tool usage information; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_guess_seq_format.out
