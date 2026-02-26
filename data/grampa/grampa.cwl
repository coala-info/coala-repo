cwlVersion: v1.2
class: CommandLineTool
baseCommand: grampa
label: grampa
doc: "GRAMPA: Gene-tree Reconciliation Algorithm with MUL-trees for Polyploid Analysis.\n\
  \nTool homepage: https://github.com/gwct/grampa"
inputs:
  - id: appendlog
    type:
      - 'null'
      - boolean
    doc: Set this to keep the old log file even if --overwrite is specified. New
      log information will instead be appended to the previous log file.
    inputBinding:
      position: 101
      prefix: --appendlog
  - id: buildmultrees
    type:
      - 'null'
      - boolean
    doc: Use this along with -s and possibly -h1 and -h2 to simply build 
      MUL-trees from those options.
    inputBinding:
      position: 101
      prefix: --buildmultrees
  - id: checknums
    type:
      - 'null'
      - boolean
    doc: Use this flag in conjunction with all other options to check the number
      of nodes, groups, and combinations for each gene tree and MUL-tree. In 
      general, gene trees with more than 15 groups to map take a very long time 
      to reconcile.
    inputBinding:
      position: 101
      prefix: --checknums
  - id: gene_input
    type:
      - 'null'
      - File
    doc: A file containing one or more ROOTED, bifurcating (no polytomies), 
      newick formatted gene trees to reconcile. The labels in the gene tree MUST
      end with '_[species name]' and contain no other underscores. Also accepts 
      a single tree string.
    inputBinding:
      position: 101
      prefix: -g
  - id: group_cap
    type:
      - 'null'
      - int
    doc: 'The maxmimum number of groups to consider for any gene tree. Default: 8.
      Max value: 18.'
    default: 8
    inputBinding:
      position: 101
      prefix: -c
  - id: h1_spec
    type:
      - 'null'
      - string
    doc: "A space separated list of species labels or internal nodes that define the
      polyploid clade. Example: 'x,y,z y,z' or '2 4'"
    inputBinding:
      position: 101
      prefix: -h1
  - id: h2_spec
    type:
      - 'null'
      - string
    doc: "A space separated list of species labels or internal node labels that make
      up the clade that you wish to place the second polyploid clade sister to. Example:
      'c'"
    inputBinding:
      position: 101
      prefix: -h2
  - id: info
    type:
      - 'null'
      - boolean
    doc: Print some meta information about the program and exit. No other 
      options required.
    inputBinding:
      position: 101
      prefix: --info
  - id: maps
    type:
      - 'null'
      - boolean
    doc: Output the maps for each reconciliation in the detailed output file.
    inputBinding:
      position: 101
      prefix: --maps
  - id: multree
    type:
      - 'null'
      - boolean
    doc: Set this option if your input species tree is a MUL-tree
    inputBinding:
      position: 101
      prefix: --multree
  - id: no_st
    type:
      - 'null'
      - boolean
    doc: Set this to only perform reconciliations to the input MUL-trees and NOT
      the singly-labeled tree.
    inputBinding:
      position: 101
      prefix: --no-st
  - id: numtrees
    type:
      - 'null'
      - boolean
    doc: Use this along with -s and possibly -h1 and -h2 to simply count the 
      number of MUL-trees from those options.
    inputBinding:
      position: 101
      prefix: --numtrees
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory name. Default: grampa-[current date]-[current time]'
    default: grampa-[current date]-[current time]
    inputBinding:
      position: 101
      prefix: -o
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: 'A prefix to add to the beginning of all output files created. Default: grampa'
    default: grampa
    inputBinding:
      position: 101
      prefix: -f
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set this to overwrite existing files.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: print_labeled_tree
    type:
      - 'null'
      - boolean
    doc: If this flag is set, the program will read your species tree and simply
      print it out with the internal nodes labeled.
    inputBinding:
      position: 101
      prefix: --labeltree
  - id: processes
    type:
      - 'null'
      - int
    doc: 'The number of processes GRAMPA should use. Default: 1.'
    default: 1
    inputBinding:
      position: 101
      prefix: -p
  - id: spec_tree
    type:
      - 'null'
      - File
    doc: A file or string containing a ROOTED, bifurcating, newick formatted 
      species tree in newick format on which to search for polyploid events.
    inputBinding:
      position: 101
      prefix: -s
  - id: st_only
    type:
      - 'null'
      - boolean
    doc: Set this to only perform reconciliations to the singly-labeled tree.
    inputBinding:
      position: 101
      prefix: --st-only
  - id: tests
    type:
      - 'null'
      - string
    doc: Use 'grampa.py --tests' the first time you run grampa to run through 
      all the options with pre-set input files.
    default: bioconda
    inputBinding:
      position: 101
      prefix: --tests
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'An option to control the amount of output printed to the screen. 0: print
      nothing. 1: print only some info at the start. 2: print all log info to screen.
      3 (default): print all log info to the screen as well as progress updates for
      certain steps.'
    default: 3
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grampa:1.4.4--pyhdfd78af_0
stdout: grampa.out
