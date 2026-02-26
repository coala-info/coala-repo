cwlVersion: v1.2
class: CommandLineTool
baseCommand: smudgeplot_extract
label: smudgeplot_extract
doc: "Extract kmer pair sequences from a FastK k-mer database.\n\nTool homepage: https://github.com/KamilSJaron/smudgeplot"
inputs:
  - id: infile
    type: File
    doc: Input FastK database (.ktab) file.
    inputBinding:
      position: 1
  - id: sma
    type: File
    doc: Input annotated k-mer pair file (.sma).
    inputBinding:
      position: 2
  - id: output_pattern
    type:
      - 'null'
      - string
    doc: The pattern used to name the output (kmerpairs).
    inputBinding:
      position: 103
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 4
    inputBinding:
      position: 103
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory where all temporary files will be stored
    default: /tmp
    inputBinding:
      position: 103
      prefix: -tmp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_extract.out
