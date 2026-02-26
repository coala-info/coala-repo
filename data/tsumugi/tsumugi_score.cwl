cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsumugi_score
label: tsumugi_score
doc: "Filter genes based on the similarity score per KO or shared between KO pairs.\n\
  \nTool homepage: https://github.com/akikuno/TSUMUGI-dev"
inputs:
  - id: max
    type:
      - 'null'
      - int
    doc: Maximum number threshold
    inputBinding:
      position: 101
      prefix: --max
  - id: min
    type:
      - 'null'
      - int
    doc: Minimum number threshold
    inputBinding:
      position: 101
      prefix: --min
  - id: path_pairwise
    type:
      - 'null'
      - File
    doc: Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz). If 
      omitted, data are read from STDIN.
    inputBinding:
      position: 101
      prefix: --in
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
stdout: tsumugi_score.out
