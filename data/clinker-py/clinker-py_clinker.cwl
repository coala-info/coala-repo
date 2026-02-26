cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinker
label: clinker-py_clinker
doc: "Automatic creation of publication-ready gene cluster comparison figures.\n\n\
  Tool homepage: https://github.com/gamcil/clinker"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Gene cluster GenBank files
    inputBinding:
      position: 1
  - id: as_separate_clusters
    type:
      - 'null'
      - boolean
    doc: Records will be parsed into separate clusters. Enable this option when 
      the GenBank file you downloaded from NCBI contains multiple sequences.
    inputBinding:
      position: 102
      prefix: --as_separate_clusters
  - id: colour_map
    type:
      - 'null'
      - File
    doc: 2-column CSV file containing gene functions and colours (e.g. 
      GENE_001,#FF0000).
    inputBinding:
      position: 102
      prefix: --colour_map
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
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: dont_set_origin
    type:
      - 'null'
      - boolean
    doc: Don't fix features which cross the origin in circular sequences 
      (GenBank format only)
    inputBinding:
      position: 102
      prefix: --dont_set_origin
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite previous output file
    inputBinding:
      position: 102
      prefix: --force
  - id: gene_functions
    type:
      - 'null'
      - File
    doc: 2-column CSV file containing gene functions, used to build gene groups 
      from same function instead of sequence similarity (e.g. 
      GENE_001,PKS-NRPS).
    inputBinding:
      position: 102
      prefix: --gene_functions
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
    inputBinding:
      position: 102
      prefix: --json_indent
  - id: matrix_out
    type:
      - 'null'
      - File
    doc: Save cluster similarity matrix to file
    inputBinding:
      position: 102
      prefix: --matrix_out
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
      - File
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
      - File
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
    dockerPull: quay.io/biocontainers/clinker-py:0.0.32--pyhdfd78af_0
