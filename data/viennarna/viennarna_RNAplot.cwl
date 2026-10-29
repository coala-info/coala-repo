cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAplot
label: viennarna_RNAplot
doc: |-
  Draw RNA secondary structures (PostScript, SVG, GML, XRNA or SSV) from sequence and structure.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: infile
    type:
      - 'null'
      - File
    doc: Read a file instead of reading from stdin.
    inputBinding:
      position: 10
      prefix: --infile=
      separate: false
  - id: msa
    type:
      - 'null'
      - boolean
    doc: Input is multiple sequence alignment in Stockholm 1.0 format.
    inputBinding:
      position: 10
      prefix: --msa
  - id: mis
    type:
      - 'null'
      - boolean
    doc: Output "most informative sequence" instead of simple consensus
    inputBinding:
      position: 10
      prefix: --mis
  - id: jobs
    type:
      - 'null'
      - int
    doc: Split batch input into jobs and start processing in parallel using multiple threads.
    inputBinding:
      position: 10
      prefix: --jobs=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Specify output file format. (possible values="eps", "svg", "gml", "xrna", "ssv" default=`eps')
    inputBinding:
      position: 10
      prefix: --output-format=
      separate: false
  - id: pre
    type:
      - 'null'
      - string
    doc: Add annotation macros to postscript file, and add the postscript code in "string" just before
      the code to draw the structure. This is an easy way to add annotation.
    inputBinding:
      position: 10
      prefix: --pre=
      separate: false
  - id: post
    type:
      - 'null'
      - string
    doc: Same as --pre but in contrast to adding the annotation macros. E.g to mark position 15 with circle
      use --post="15 cmark".
    inputBinding:
      position: 10
      prefix: --post=
      separate: false
  - id: auto_id
    type:
      - 'null'
      - boolean
    doc: Automatically generate an ID for each sequence.
    inputBinding:
      position: 10
      prefix: --auto-id
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: Prefix for automatically generated IDs (as used in output file names).
    inputBinding:
      position: 10
      prefix: --id-prefix=
      separate: false
  - id: covar
    type:
      - 'null'
      - boolean
    doc: Annotate covariance of base pairs in consensus structure.
    inputBinding:
      position: 10
      prefix: --covar
  - id: aln
    type:
      - 'null'
      - boolean
    doc: Produce a colored and structure annotated alignment in PostScript format in the file "aln.ps"
      in the current directory.
    inputBinding:
      position: 10
      prefix: --aln
  - id: layout_type
    type:
      - 'null'
      - int
    doc: Choose the plotting layout algorithm. (possible values="0", "1", "2", "3", "4" default=`1')
    inputBinding:
      position: 10
      prefix: --layout-type=
      separate: false
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s) with sequence and structure (for example RNAfold output)
    inputBinding:
      position: 100
outputs:
  - id: plot_files
    type:
      type: array
      items: File
    doc: Structure plots
    outputBinding:
      glob:
        - '*.ps'
        - '*.eps'
        - '*.svg'
        - '*.gml'
        - '*.xrna'
        - '*.ssv'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
