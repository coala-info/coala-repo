cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsumugi_count
label: tsumugi_count
doc: "Filter genes based on the number of detected phenotypes per KO or shared between
  KO pairs.\n\nTool homepage: https://github.com/akikuno/TSUMUGI-dev"
inputs:
  - id: genewise
    type:
      - 'null'
      - boolean
    doc: Filter by number of phenotypes per KO mouse
    inputBinding:
      position: 101
      prefix: --genewise
  - id: genewise_annotations
    type:
      - 'null'
      - File
    doc: Path to the 'genewise_phenotype_annotations' file (JSONL or JSONL.gz). 
      Required when using '-g/--genewise' to determine genes that were measured.
    inputBinding:
      position: 101
      prefix: --genewise_annotations
  - id: input_pairwise
    type:
      - 'null'
      - File
    doc: Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz). If 
      omitted, data are read from STDIN.
    inputBinding:
      position: 101
      prefix: --in
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
  - id: pairwise
    type:
      - 'null'
      - boolean
    doc: Filter by number of shared phenotypes between KO pairs
    inputBinding:
      position: 101
      prefix: --pairwise
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
stdout: tsumugi_count.out
