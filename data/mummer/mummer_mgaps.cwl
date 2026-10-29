cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mgaps
label: mummer_mgaps
doc: "Cluster MUMs based on diagonals and separation. The input is read from stdin in the format produced by mummer and the clusters are written to stdout.\n\nTool homepage: https://github.com/mummer4/mummer"
inputs:
  - id: check_reverse_labels
    type:
      - 'null'
      - boolean
    doc: "Check that fasta header labels alternately have Reverse"
    inputBinding:
      position: 1
      prefix: "-C"
  - id: diag_diff
    type:
      - 'null'
      - int
    doc: "Fixed diagonal difference to join matches"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: use_extent
    type:
      - 'null'
      - boolean
    doc: "Use extent of match (end - start) rather than sum of piece lengths to determine length of cluster"
    inputBinding:
      position: 1
      prefix: "-e"
  - id: diag_factor
    type:
      - 'null'
      - float
    doc: "Fraction of separation for diagonal difference"
    inputBinding:
      position: 1
      prefix: "-f"
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of cluster match"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: max_separation
    type:
      - 'null'
      - int
    doc: "Maximum separation between matches in cluster"
    inputBinding:
      position: 1
      prefix: "-s"
  - id: mummer_output
    type: File
    doc: "Match list in the format produced by mummer (read from stdin)"
outputs:
  - id: stdout_out
    type: stdout
    doc: "MUM clusters (gaps file)"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stdout: mummer_mgaps.gaps
stderr: mummer_mgaps.log
stdin: $(inputs.mummer_output.path)
