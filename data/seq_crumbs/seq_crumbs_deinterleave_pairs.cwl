cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_deinterleave_pairs
label: seq_crumbs_deinterleave_pairs
doc: "A tool to deinterleave paired-end sequencing reads. Note: The provided help
  text contains system error logs regarding a container build failure and does not
  list command-line arguments.\n\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_deinterleave_pairs.out
