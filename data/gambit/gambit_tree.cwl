cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gambit
label: gambit_tree
doc: "Estimate a relatedness tree for a set of genomes and output in Newick format.\n\
  \nTool homepage: https://github.com/jlumpe/gambit"
inputs:
  - id: db
    type:
      - 'null'
      - Directory
    doc: Directory containing GAMBIT database files (global option, given before the subcommand).
    inputBinding:
      position: 1
      prefix: --db
  - id: genomes
    type:
      type: array
      items: File
    doc: Genomes to process
    inputBinding:
      position: 3
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use.
    inputBinding:
      position: 102
      prefix: --cores
  - id: kmer_prefix_length
    type:
      - 'null'
      - int
    doc: Number of nucleotides to recognize AFTER prefix.
    inputBinding:
      position: 102
      prefix: -k
  - id: ldir
    type:
      - 'null'
      - Directory
    doc: Parent directory of paths in LISTFILE.
    inputBinding:
      position: 102
      prefix: --ldir
  - id: listfile
    type:
      - 'null'
      - File
    doc: File containing paths to genomes files, one per line.
    inputBinding:
      position: 102
      prefix: -l
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Don't show progress meter.
    inputBinding:
      position: 102
      prefix: --no-progress
  - id: prefix
    type:
      - 'null'
      - string
    doc: K-mer prefix.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress meter.
    inputBinding:
      position: 102
      prefix: --progress
  - id: sigfile
    type:
      - 'null'
      - File
    doc: GAMBIT signatures file.
    inputBinding:
      position: 102
      prefix: --sigfile
arguments:
  - position: 2
    valueFrom: tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
stdout: gambit_tree.out
