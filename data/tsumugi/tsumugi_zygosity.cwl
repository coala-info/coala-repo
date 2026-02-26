cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tsumugi
  - zygosity
label: tsumugi_zygosity
doc: "Keep or drop annotations based on zygosity.\n\nTool homepage: https://github.com/akikuno/TSUMUGI-dev"
inputs:
  - id: drop_zygosity
    type:
      - 'null'
      - string
    doc: Drop annotations with the specified zygosity
    inputBinding:
      position: 101
      prefix: --drop
  - id: input_pairwise
    type:
      - 'null'
      - File
    doc: Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz). If 
      omitted, data are read from STDIN.
    inputBinding:
      position: 101
      prefix: --in
  - id: keep_zygosity
    type:
      - 'null'
      - string
    doc: Keep ONLY annotations with the specified zygosity
    inputBinding:
      position: 101
      prefix: --keep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
stdout: tsumugi_zygosity.out
