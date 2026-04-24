cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaffold2fasta
label: sga_scaffold2fasta
doc: "Write out a fasta file for the scaffolds indicated in SCAFFOLDFILE\n\nTool homepage:
  https://github.com/jts/sga"
inputs:
  - id: scaffold_file
    type: File
    doc: SCAFFOLDFILE
    inputBinding:
      position: 1
  - id: asqg_file
    type:
      - 'null'
      - File
    doc: "read the contig string graph from FILE. This supercedes --contig-file\n\
      \                                       this is usually the output from the
      sga-assemble step"
    inputBinding:
      position: 102
      prefix: --asqg-file
  - id: contig_file
    type:
      - 'null'
      - File
    doc: read the contig sequences from FILE
    inputBinding:
      position: 102
      prefix: --contig-file
  - id: distanceFactor
    type:
      - 'null'
      - float
    doc: "Accept a walk as correctly resolving a gap if the walk length is within
      T standard \n                                       deviations from the estimated
      distance (default: 3.0f)"
    inputBinding:
      position: 102
      prefix: --distanceFactor
  - id: graph_resolve
    type:
      - 'null'
      - string
    doc: "if an ASQG file is present, attempt to resolve the links\n             \
      \                          between contigs using walks through the graph. The
      MODE parameter\n                                       is a string describing
      the algorithm to use.\n                                       The MODE parameter
      must be one of best-any|best-unique|unique|none.\n                         \
      \              best-any: The walk with length closest to the estimated\n   \
      \                                    distance between the contigs will be chosen
      to resolve the gap.\n                                       If multiple best
      walks are found, the tie is broken arbitrarily.\n                          \
      \             best-unique: as above but if there is a tie no walk will be chosen.\n\
      \                                       unique: only resolve the gap if there
      is a single walk between the contigs\n                                     \
      \  none: do not resolve gaps using the graph\n                             \
      \          The most conservative most is unique, then best-unique with best-any
      being the most\n                                       aggressive. The default
      is unique"
    inputBinding:
      position: 102
      prefix: --graph-resolve
  - id: min_gap_length
    type:
      - 'null'
      - int
    doc: "separate contigs by at least N bases. All predicted gaps less\n        \
      \                               than N will be extended to N (default: 25)"
    inputBinding:
      position: 102
      prefix: --min-gap-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: only output scaffolds longer than N bases
    inputBinding:
      position: 102
      prefix: --min-length
  - id: no_singletons
    type:
      - 'null'
      - boolean
    doc: do not output scaffolds that consist of a single contig
    inputBinding:
      position: 102
      prefix: --no-singletons
  - id: use_overlap
    type:
      - 'null'
      - boolean
    doc: "attempt to merge contigs using predicted overlaps.\n                   \
      \                    This can help close gaps in the scaffolds but comes\n \
      \                                      with a small risk of collapsing tandem
      repeats."
    inputBinding:
      position: 102
      prefix: --use-overlap
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: write_names
    type:
      - 'null'
      - boolean
    doc: write the name of contigs contained in the scaffold in the FASTA header
    inputBinding:
      position: 102
      prefix: --write-names
  - id: write_unplaced
    type:
      - 'null'
      - boolean
    doc: output unplaced contigs that are larger than minLength
    inputBinding:
      position: 102
      prefix: --write-unplaced
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'write the scaffolds to FILE (default: scaffolds.fa)'
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
