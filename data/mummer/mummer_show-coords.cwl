cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - show-coords
label: mummer_show-coords
doc: "Show the coordinates, percent identity and other information about the alignments in a delta file from nucmer or promer.\n\nTool homepage: https://github.com/mummer4/mummer"
inputs:
  - id: merge_overlaps
    type:
      - 'null'
      - boolean
    doc: "Merges overlapping alignments regardless of match dir or frame and does not display any identity information"
    inputBinding:
      position: 1
      prefix: "-b"
  - id: btab
    type:
      - 'null'
      - boolean
    doc: "Switch output to btab format"
    inputBinding:
      position: 1
      prefix: "-B"
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: "Include percent coverage information in the output"
    inputBinding:
      position: 1
      prefix: "-c"
  - id: direction
    type:
      - 'null'
      - boolean
    doc: "Display the alignment direction in the additional FRM columns (default for promer)"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: deprecated_g
    type:
      - 'null'
      - boolean
    doc: "Deprecated option. Please use delta-filter instead"
    inputBinding:
      position: 1
      prefix: "-g"
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: "Do not print the output header"
    inputBinding:
      position: 1
      prefix: "-H"
  - id: min_identity
    type:
      - 'null'
      - float
    doc: "Set minimum percent identity to display"
    inputBinding:
      position: 1
      prefix: "-I"
  - id: knockout
    type:
      - 'null'
      - boolean
    doc: "Knockout (do not display) alignments that overlap another alignment in a different frame by more than 50 percent of their length, AND have a smaller percent similarity or are less than 75 percent of the size of the other alignment (promer only)"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: lengths
    type:
      - 'null'
      - boolean
    doc: "Include the sequence length information in the output"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: min_length
    type:
      - 'null'
      - long
    doc: "Set minimum alignment length to display"
    inputBinding:
      position: 1
      prefix: "-L"
  - id: annotate_overlaps
    type:
      - 'null'
      - boolean
    doc: "Annotate maximal alignments between two sequences, i.e. overlaps between reference and query sequences"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: sort_query
    type:
      - 'null'
      - boolean
    doc: "Sort output lines by query IDs and coordinates"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: sort_reference
    type:
      - 'null'
      - boolean
    doc: "Sort output lines by reference IDs and coordinates"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: tab
    type:
      - 'null'
      - boolean
    doc: "Switch output to tab-delimited format"
    inputBinding:
      position: 1
      prefix: "-T"
  - id: delta_file
    type: File
    doc: "Delta alignment file from nucmer or promer"
    inputBinding:
      position: 100
outputs:
  - id: stdout_out
    type: stdout
    doc: "List of alignment coordinates"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stdout: mummer_show-coords.coords
stderr: mummer_show-coords.log
