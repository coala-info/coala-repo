cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - magcluster
  - clinker
label: magcluster_clinker
doc: "magcluster clinker\n\nTool homepage: https://github.com/runjiaji/magcluster"
inputs:
  - id: gbkfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Gene cluster GenBank files
    inputBinding:
      position: 1
  - id: decimals
    type:
      - 'null'
      - int
    doc: Number of decimal places in output
    default: 2
    inputBinding:
      position: 102
      prefix: --decimals
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Character to delimit output by
    default: human readable
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite previous output file
    inputBinding:
      position: 102
      prefix: --force
  - id: hide_aln_headers
    type:
      - 'null'
      - boolean
    doc: Hide alignment cluster name headers
    inputBinding:
      position: 102
      prefix: --hide_aln_headers
  - id: hide_link_headers
    type:
      - 'null'
      - boolean
    doc: Hide alignment column headers
    inputBinding:
      position: 102
      prefix: --hide_link_headers
  - id: identity
    type:
      - 'null'
      - float
    doc: Minimum alignment sequence identity
    default: 0.3
    inputBinding:
      position: 102
      prefix: --identity
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of alignments to run in parallel (0 to use the number of CPUs)
    default: 0
    inputBinding:
      position: 102
      prefix: --jobs
  - id: json_indent
    type:
      - 'null'
      - int
    doc: Number of spaces to indent JSON
    default: none
    inputBinding:
      position: 102
      prefix: --json_indent
  - id: no_align
    type:
      - 'null'
      - boolean
    doc: Do not align clusters
    inputBinding:
      position: 102
      prefix: --no_align
  - id: plot
    type:
      - 'null'
      - string
    doc: Plot cluster alignments using clustermap.js. If a path is given, 
      clinker will generate a portable HTML file at that path. Otherwise, the 
      plot will be served dynamically using Python's HTTP server.
    inputBinding:
      position: 102
      prefix: --plot
  - id: ranges
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Scaffold extraction ranges. If a range is specified, only features within
      the range will be extracted from the scaffold. Ranges should be formatted like:
      scaffold:start-end (e.g. scaffold_1:15000-40000)'
    inputBinding:
      position: 102
      prefix: --ranges
  - id: session
    type:
      - 'null'
      - string
    doc: Path to clinker session
    inputBinding:
      position: 102
      prefix: --session
  - id: use_file_order
    type:
      - 'null'
      - boolean
    doc: Display clusters in order of input files
    inputBinding:
      position: 102
      prefix: --use_file_order
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Save alignments to file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magcluster:0.2.5--pyhdfd78af_0
