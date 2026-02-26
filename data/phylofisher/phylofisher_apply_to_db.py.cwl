cwlVersion: v1.2
class: CommandLineTool
baseCommand: apply_to_db.py
label: phylofisher_apply_to_db.py
doc: "Apply parsing decisions and add new data to the database.\n\nTool homepage:
  https://github.com/TheBrownLab/PhyloFisher"
inputs:
  - id: fisher_dir
    type: Directory
    doc: Path to fisher output directory to use for dataset addition.
    inputBinding:
      position: 101
      prefix: --fisher_dir
  - id: input_dir
    type: Directory
    doc: Path to forest output directory to use for database addition.
    inputBinding:
      position: 101
      prefix: --input
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, where N is an integer.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: to_exclude
    type:
      - 'null'
      - File
    doc: Path to .txt file containing Unique IDs of taxa to exclude from dataset
      addition with one taxon per line.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
stdout: phylofisher_apply_to_db.py.out
