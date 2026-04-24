cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuna_merge
label: cuna_merge
doc: "Merge per-read modification calls.\n\nTool homepage: https://github.com/iris1901/CUNA"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: List of paths of per-read modification calls to merge. File paths 
      should be separated by space/whitespace. Use either --input or --list 
      argument, but not both.
    inputBinding:
      position: 101
      prefix: --input
  - id: length_cutoff
    type:
      - 'null'
      - int
    doc: Minimum cutoff for read length
    inputBinding:
      position: 101
      prefix: --length_cutoff
  - id: list
    type:
      - 'null'
      - File
    doc: A file containing paths to per-read modification calls to merge (one 
      per line). Use either --input or --list argument, but not both.
    inputBinding:
      position: 101
      prefix: --list
  - id: mod_t
    type:
      - 'null'
      - float
    doc: Probability threshold for a per-read prediction to be considered 
      modified.
    inputBinding:
      position: 101
      prefix: --mod_t
  - id: output
    type:
      - 'null'
      - Directory
    doc: Path to folder where intermediate and final files will be stored, 
      default is current working directory
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: qscore_cutoff
    type:
      - 'null'
      - float
    doc: Minimum cutoff for mean quality score of a read
    inputBinding:
      position: 101
      prefix: --qscore_cutoff
  - id: unmod_t
    type:
      - 'null'
      - float
    doc: Probability threshold for a per-read prediction to be considered 
      unmodified.
    inputBinding:
      position: 101
      prefix: --unmod_t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
stdout: cuna_merge.out
