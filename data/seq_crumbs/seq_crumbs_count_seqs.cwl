cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_count_seqs
label: seq_crumbs_count_seqs
doc: "\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_count_seqs.out
