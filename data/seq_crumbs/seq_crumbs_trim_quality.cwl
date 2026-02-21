cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_trim_quality
label: seq_crumbs_trim_quality
doc: "A tool for quality trimming of sequences (Note: The provided help text contains
  system error messages regarding container extraction and does not list specific
  command-line arguments).\n\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_trim_quality.out
