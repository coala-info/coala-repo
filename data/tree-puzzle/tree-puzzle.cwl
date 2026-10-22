cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree-puzzle
label: tree-puzzle
doc: "TREE-PUZZLE reconstructs phylogenetic trees from molecular sequences by maximum likelihood, using quartet puzzling, and computes pairwise maximum likelihood distances and branch lengths. The program is menu driven: the menu keystrokes are read from standard input (the default file only sends y to accept the default settings).\n\nTool homepage: http://www.tree-puzzle.de"
inputs:
  - id: infile
    type: File
    doc: Filename of multiple sequence alignment in PHYLIP format
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: user_tree_file
    type:
      - 'null'
      - File
    doc: Filename of the treefile in PHYLIP format
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: prefix
    type:
      - 'null'
      - string
    doc: "use XXX as filename prefix instead of Infilename of Infilename or UserTreeFilename"
    inputBinding:
      prefix: -prefix=
      separate: false
      position: 0
  - id: consmrel
    type:
      - 'null'
      - boolean
    doc: "perform consensus step below 50% to first incongruence, that is a relative mayority consensus is built."
    inputBinding:
      prefix: -consmrel
      position: 0
  - id: randseed
    type:
      - 'null'
      - int
    doc: use the given number as random number seed, for debug purposes only
    inputBinding:
      prefix: -randseed
      separate: false
      position: 0
  - id: menu_commands
    type: File
    default:
      class: File
      basename: menu_commands.txt
      contents: "y\n"
    doc: Menu keystrokes sent to the program on standard input, one per line. The last line must be y to start the run.
stdin: $(inputs.menu_commands.path)
outputs:
  - id: puzzle_report
    type: File
    doc: Puzzle report file
    outputBinding:
      glob: "*.puzzle"
  - id: distances
    type:
      - 'null'
      - File
    doc: Likelihood distances
    outputBinding:
      glob: "*.dist"
  - id: tree
    type:
      - 'null'
      - File
    doc: Phylip tree file
    outputBinding:
      glob: "*.tree"
  - id: consensus_tree
    type:
      - 'null'
      - File
    doc: Consensus tree file
    outputBinding:
      glob: "*.ctree"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.infile)
      - $(inputs.user_tree_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tree-puzzle:v5.2-11-deb_cv1
