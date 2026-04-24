cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi bin
label: odgi_bin
doc: "Binning of pangenome sequence and path information in the graph.\n\nTool homepage:
  https://github.com/vgteam/odgi"
inputs:
  - id: aggregate_delim
    type:
      - 'null'
      - boolean
    doc: Aggregate on path prefix delimiter. Argument depends on 
      -D,--path-delim=[STRING].
    inputBinding:
      position: 101
      prefix: --aggregate-delim
  - id: bin_width
    type:
      - 'null'
      - int
    doc: The bin width specifies the size of each bin.
    inputBinding:
      position: 101
      prefix: --bin-width
  - id: haplo_blocker
    type:
      - 'null'
      - boolean
    doc: 'Write a TSV to stdout formatted in a way ready for HaploBlocker: Each row
      corresponds to a node. Each column corresponds to a path. Each value is the
      coverage of a specific node of a specific path.'
    inputBinding:
      position: 101
      prefix: --haplo-blocker
  - id: haplo_blocker_min_depth
    type:
      - 'null'
      - int
    doc: 'Specify the minimum depth a path needs to have in a bin to actually report
      that bin (default: 1).'
    inputBinding:
      position: 101
      prefix: --haplo-blocker-min-depth
  - id: haplo_blocker_min_paths
    type:
      - 'null'
      - int
    doc: 'Specify the minimum number of paths that need to be present in the bin to
      actually report that bin (default: 1).'
    inputBinding:
      position: 101
      prefix: --haplo-blocker-min-paths
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this FILE. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: json
    type:
      - 'null'
      - boolean
    doc: 'Print bins and links to stdout in pseudo JSON format. Each line is a valid
      JSON object, but the whole file is not a valid JSON! First, each bin including
      its pangenome sequence is printed to stdout per line. Second, for each path
      in the graph, its traversed bins including metainformation: **bin** (bin identifier),
      **mean.cov** (mean coverage of the path in this bin), **mean.inv** (mean inversion
      rate of this path in this bin), **mean.pos** (mean nucleotide position of this
      path in this bin), and an array of ranges determining the nucleotide position
      of the path in this bin. Switching first and last nucleotide in a range represents
      a complement reverse orientation of that particular sequence.'
    inputBinding:
      position: 101
      prefix: --json
  - id: no_gap_links
    type:
      - 'null'
      - boolean
    doc: "Don't include gap links in the output. We divide links into 2 classes: 1.
      The links which help to follow complex variations. They need to be drawn, else
      one could not follow the sequence of a path. 2. The links helping to follow
      simple variations. These links are called gap-links. Such links solely connecting
      a path from left to right may not berelevant to understand a path's traveral
      through the bins. Therfore, when this option is set, the gap-links are left
      out saving disk space."
    inputBinding:
      position: 101
      prefix: --no-gap-links
  - id: no_seqs
    type:
      - 'null'
      - boolean
    doc: If -j,--json is set, no nucleotide sequences will be printed to stdout 
      in order to save disk space.
    inputBinding:
      position: 101
      prefix: --no-seqs
  - id: num_bins
    type:
      - 'null'
      - int
    doc: The number of bins the pangenome sequence should be chopped up to.
    inputBinding:
      position: 101
      prefix: --num-bins
  - id: path_delim
    type:
      - 'null'
      - string
    doc: Annotate rows by prefix and suffix of this delimiter.
    inputBinding:
      position: 101
      prefix: --path-delim
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_bin.out
