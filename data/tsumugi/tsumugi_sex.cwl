cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsumugi sex
label: tsumugi_sex
doc: "Keep or drop annotations based on sexual dimorphism.\n\nTool homepage: https://github.com/akikuno/TSUMUGI-dev"
inputs:
  - id: drop_sex
    type:
      - 'null'
      - string
    doc: Drop annotations with the specified sexual dimorphism
    inputBinding:
      position: 101
      prefix: --drop
  - id: input_file
    type:
      - 'null'
      - File
    doc: Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz). If 
      omitted, data are read from STDIN.
    inputBinding:
      position: 101
      prefix: --in
  - id: keep_sex
    type:
      - 'null'
      - string
    doc: Keep ONLY annotations with the specified sexual dimorphism
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
stdout: tsumugi_sex.out
