cwlVersion: v1.2
class: CommandLineTool
baseCommand: moss_union_candidates.py
label: moss_union_candidates.py
doc: "A tool within the MOSS (Multi-Omics Sequence Search) pipeline, likely used for
  unioning candidate files.\n\nTool homepage: https://github.com/elkebir-group/Moss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moss:0.1.1--h84372a0_6
stdout: moss_union_candidates.py.out
