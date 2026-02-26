cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsumugi build-webapp
label: tsumugi_build-webapp
doc: "Builds a web application for visualizing Tsumugi results.\n\nTool homepage:
  https://github.com/akikuno/TSUMUGI-dev"
inputs:
  - id: genewise_annotations
    type: File
    doc: Path to the 'genewise_phenotype_annotations' file (JSONL or JSONL.gz).
    inputBinding:
      position: 101
      prefix: --genewise_annotations
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --out
  - id: pairwise_annotations
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
stdout: tsumugi_build-webapp.out
