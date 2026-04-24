cwlVersion: v1.2
class: CommandLineTool
baseCommand: mummerplot
label: mummer4_mummerplot
doc: "mummerplot generates plots of alignment data produced by mummer, nucmer, promer
  or show-tiling by using the GNU gnuplot utility. After generating the appropriate
  scripts and datafiles, mummerplot will attempt to run gnuplot to generate the plot.
  If this attempt fails, a warning will be output and the resulting .gp and .[frh]plot
  files will remain so that the user may run gnuplot independently. If the attempt
  succeeds, either an interactive gnuplot window will be spawned (default) or an additional
  output file will be generated (e.g., .ps or .png depending on the selected terminal
  with -t). Feel free to edit the resulting gnuplot script (.gp) and rerun gnuplot
  to change line thinkness, labels, colors, plot size etc.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: match_file
    type: File
    doc: "Set the alignment input to 'match file'\n                    Valid inputs
      are from mummer, nucmer, promer and\n                    show-tiling (.out,
      .cluster, .delta and .tiling)"
    inputBinding:
      position: 1
  - id: breaklen
    type:
      - 'null'
      - int
    doc: "Highlight alignments with breakpoints further than\n                   \
      \ breaklen nucleotides from the nearest sequence end"
    inputBinding:
      position: 102
      prefix: --breaklen
  - id: color
    type:
      - 'null'
      - boolean
    doc: "Color plot lines with a percent similarity gradient or\n               \
      \     turn off all plot color (default color by match dir)\n               \
      \     If the plot is very sparse, edit the .gp script to plot\n            \
      \        with 'linespoints' instead of 'lines'"
    inputBinding:
      position: 102
      prefix: --color
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: Generate a reference coverage plot (default for .tiling)
    inputBinding:
      position: 102
      prefix: --coverage
  - id: depend
    type:
      - 'null'
      - boolean
    doc: Print the dependency information and exit
    inputBinding:
      position: 102
      prefix: --depend
  - id: fat
    type:
      - 'null'
      - boolean
    doc: Layout sequences using fattest alignment only
    inputBinding:
      position: 102
      prefix: --fat
  - id: filter
    type:
      - 'null'
      - boolean
    doc: "Only display .delta alignments which represent the \"best\"\n          \
      \          hit to any particular spot on either sequence, i.e. a\n         \
      \           one-to-one mapping of reference and query subsequences"
    inputBinding:
      position: 102
      prefix: --filter
  - id: idq
    type:
      - 'null'
      - string
    doc: Plot a particular query sequence ID on the Y-axis
    inputBinding:
      position: 102
      prefix: --IdQ
  - id: idr
    type:
      - 'null'
      - string
    doc: Plot a particular reference sequence ID on the X-axis
    inputBinding:
      position: 102
      prefix: --IdR
  - id: layout
    type:
      - 'null'
      - boolean
    doc: "Layout a .delta multiplot in an intelligible fashion,\n                \
      \    this option requires the -R -Q options"
    inputBinding:
      position: 102
      prefix: --layout
  - id: list_terms
    type:
      - 'null'
      - boolean
    doc: List the available terminals
    inputBinding:
      position: 102
      prefix: --list-terms
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: "Color plot lines with a percent similarity gradient or\n               \
      \     turn off all plot color (default color by match dir)\n               \
      \     If the plot is very sparse, edit the .gp script to plot\n            \
      \        with 'linespoints' instead of 'lines'"
    inputBinding:
      position: 102
      prefix: --no-color
  - id: no_coverage
    type:
      - 'null'
      - boolean
    doc: Generate a reference coverage plot (default for .tiling)
    inputBinding:
      position: 102
      prefix: --no-coverage
  - id: prefix
    type:
      - 'null'
      - string
    doc: Set the prefix of the output files (default 'out')
    inputBinding:
      position: 102
      prefix: --prefix
  - id: qfile
    type:
      - 'null'
      - File
    doc: "Plot an ordered set of query sequences from Qfile\n                    Rfile/Qfile
      Can either be the original DNA multi-FastA\n                    files or lists
      of sequence IDs, lens and dirs [ /+/-]"
    inputBinding:
      position: 102
      prefix: --Qfile
  - id: qport
    type:
      - 'null'
      - int
    doc: "Specify the port to send query IDs and position on mouse\n             \
      \       double click in X11 plot window"
    inputBinding:
      position: 102
      prefix: --qport
  - id: rfile
    type:
      - 'null'
      - File
    doc: "Plot an ordered set of reference sequences from Rfile\n                \
      \    Rfile/Qfile Can either be the original DNA multi-FastA\n              \
      \      files or lists of sequence IDs, lens and dirs [ /+/-]"
    inputBinding:
      position: 102
      prefix: --Rfile
  - id: rport
    type:
      - 'null'
      - int
    doc: "Specify the port to send reference ID and position on\n                \
      \    mouse double click in X11 plot window"
    inputBinding:
      position: 102
      prefix: --rport
  - id: size
    type:
      - 'null'
      - string
    doc: "Set the output size to small, medium or large\n                    --small
      --medium --large (default 'small')"
    inputBinding:
      position: 102
      prefix: --size
  - id: snp
    type:
      - 'null'
      - boolean
    doc: Highlight SNP locations in each alignment
    inputBinding:
      position: 102
      prefix: --SNP
  - id: terminal
    type:
      - 'null'
      - string
    doc: "Set the output terminal, anything understood by \"set\n                \
      \    terminal\", e.g. png, ps) (default: interactive)"
    inputBinding:
      position: 102
      prefix: --terminal
  - id: title
    type:
      - 'null'
      - string
    doc: Specify the gnuplot plot title (default none)
    inputBinding:
      position: 102
  - id: xrange
    type:
      - 'null'
      - string
    doc: Set the xrange for the plot '[min:max]'
    inputBinding:
      position: 102
      prefix: --xrange
  - id: yrange
    type:
      - 'null'
      - string
    doc: Set the yrange for the plot '[min:max]'
    inputBinding:
      position: 102
      prefix: --yrange
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_mummerplot.out
