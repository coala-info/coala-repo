cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigeon
label: wigeon
doc: "A tool for sequence alignment and database searching.\n\nTool homepage: https://github.com/alexmaybar/wigeonDB"
inputs:
  - id: db_fasta
    type:
      - 'null'
      - File
    doc: db in fasta format (megablast formatted)
    inputBinding:
      position: 101
      prefix: --db_FASTA
  - id: db_nast
    type:
      - 'null'
      - File
    doc: db in NAST format
    inputBinding:
      position: 101
      prefix: --db_NAST
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode.
    inputBinding:
      position: 101
      prefix: --DEBUG
  - id: exec_dir
    type:
      - 'null'
      - Directory
    doc: cd to exec_dir before running
    inputBinding:
      position: 101
      prefix: --exec_dir
  - id: num_top_hits
    type:
      - 'null'
      - int
    doc: uses only the single best match.
    inputBinding:
      position: 101
      prefix: --num_top_hits
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Generate plots.
    inputBinding:
      position: 101
      prefix: --plot
  - id: query_nast
    type: File
    doc: multi-fasta file containing query sequences in alignment format
    inputBinding:
      position: 101
      prefix: --query_NAST
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/wigeon:v20101212dfsg1-2-deb_cv1
stdout: wigeon.out
