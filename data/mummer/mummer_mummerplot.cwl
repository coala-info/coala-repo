cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mummerplot
label: mummer_mummerplot
doc: "Generate plots of alignment data produced by mummer, nucmer, promer or show-tiling by using the GNU gnuplot utility. It writes a gnuplot script and data files, then tries to run gnuplot to draw the plot.\n\nTool homepage: https://github.com/mummer4/mummer"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: breaklen
    type:
      - 'null'
      - int
    doc: "Highlight alignments with breakpoints further than breaklen nucleotides from the nearest sequence end"
    inputBinding:
      position: 1
      prefix: "-b"
  - id: color
    type:
      - 'null'
      - boolean
    doc: "Color plot lines with a percent similarity gradient or turn off all plot color (default color by match dir)"
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--color" : "--nocolor"))'
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: "Generate a reference coverage plot (default for .tiling)"
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--coverage" : "--nocoverage"))'
  - id: depend
    type:
      - 'null'
      - boolean
    doc: "Print the dependency information and exit"
    inputBinding:
      position: 1
      prefix: "--depend"
  - id: filter
    type:
      - 'null'
      - boolean
    doc: "Only display .delta alignments which represent the best hit to any particular spot on either sequence, i.e. a one-to-one mapping of reference and query subsequences"
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--filter" : "--nofilter"))'
  - id: layout
    type:
      - 'null'
      - boolean
    doc: "Layout a .delta multiplot in an intelligible fashion, this option requires the -R -Q options"
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--layout" : "--nolayout"))'
  - id: fat
    type:
      - 'null'
      - boolean
    doc: "Layout sequences using fattest alignment only"
    inputBinding:
      position: 1
      prefix: "--fat"
  - id: prefix
    type: string
    default: out
    doc: "Set the prefix of the output files (default out)"
    inputBinding:
      position: 1
      prefix: "-p"
  - id: reverse_video
    type:
      - 'null'
      - boolean
    doc: "Reverse video for x11 plots"
    inputBinding:
      position: 1
      prefix: "-rv"
  - id: id_ref
    type:
      - 'null'
      - string
    doc: "Plot a particular reference sequence ID on the X-axis"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: id_qry
    type:
      - 'null'
      - string
    doc: "Plot a particular query sequence ID on the Y-axis"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: ref_file
    type:
      - 'null'
      - File
    doc: "Plot an ordered set of reference sequences from this file (the original DNA multi-FASTA file or a list of sequence IDs, lens and dirs)"
    inputBinding:
      position: 1
      prefix: "-R"
  - id: qry_file
    type:
      - 'null'
      - File
    doc: "Plot an ordered set of query sequences from this file (the original DNA multi-FASTA file or a list of sequence IDs, lens and dirs)"
    inputBinding:
      position: 1
      prefix: "-Q"
  - id: rport
    type:
      - 'null'
      - int
    doc: "Specify the port to send reference ID and position on mouse double click in X11 plot window"
    inputBinding:
      position: 1
      prefix: "--rport"
  - id: qport
    type:
      - 'null'
      - int
    doc: "Specify the port to send query IDs and position on mouse double click in X11 plot window"
    inputBinding:
      position: 1
      prefix: "--qport"
  - id: size
    type:
      - 'null'
      - string
    doc: "Set the output size to small, medium or large (default small)"
    inputBinding:
      position: 1
      prefix: "-s"
  - id: small
    type:
      - 'null'
      - boolean
    doc: "Set the output size to small"
    inputBinding:
      position: 1
      prefix: "--small"
  - id: medium
    type:
      - 'null'
      - boolean
    doc: "Set the output size to medium"
    inputBinding:
      position: 1
      prefix: "--medium"
  - id: large
    type:
      - 'null'
      - boolean
    doc: "Set the output size to large"
    inputBinding:
      position: 1
      prefix: "--large"
  - id: snp
    type:
      - 'null'
      - boolean
    doc: "Highlight SNP locations in each alignment"
    inputBinding:
      position: 1
      prefix: "--SNP"
  - id: terminal
    type:
      - 'null'
      - string
    doc: "Set the output terminal to x11, postscript or png (default x11)"
    inputBinding:
      position: 1
      prefix: "-t"
  - id: x11
    type:
      - 'null'
      - boolean
    doc: "Set the output terminal to x11"
    inputBinding:
      position: 1
      prefix: "--x11"
  - id: postscript
    type:
      - 'null'
      - boolean
    doc: "Set the output terminal to postscript"
    inputBinding:
      position: 1
      prefix: "--postscript"
  - id: png
    type:
      - 'null'
      - boolean
    doc: "Set the output terminal to png"
    inputBinding:
      position: 1
      prefix: "--png"
  - id: title
    type:
      - 'null'
      - string
    doc: "Specify the gnuplot plot title (default none)"
    inputBinding:
      position: 1
      prefix: "--title"
  - id: xrange
    type:
      - 'null'
      - string
    doc: "Set the xrange for the plot [min:max]"
    inputBinding:
      position: 1
      prefix: "-x"
  - id: yrange
    type:
      - 'null'
      - string
    doc: "Set the yrange for the plot [min:max]"
    inputBinding:
      position: 1
      prefix: "-y"
  - id: match_file
    type: File
    doc: "Alignment input from mummer, nucmer, promer or show-tiling (.out, .cluster, .delta and .tiling)"
    inputBinding:
      position: 100
outputs:
  - id: plot_files
    type: File[]
    doc: "Plot files: gnuplot script (.gp), data files (.fplot, .rplot, .hplot) and the plot image when gnuplot can render it"
    outputBinding:
      glob: "$(inputs.prefix).*"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stderr: mummer_mummerplot.log
