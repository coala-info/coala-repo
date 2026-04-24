cwlVersion: v1.2
class: CommandLineTool
baseCommand: contree
label: phylommand_contree
doc: "Contree is a command line program for comparing trees. It can compare trees
  in one file/input against each other or compare the trees in one file/input to the
  trees in another file/input.\n\nTool homepage: https://github.com/mr-y/phylommand"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: File containing trees to compare
    inputBinding:
      position: 1
  - id: add_to_support
    type:
      - 'null'
      - boolean
    doc: add one to the value of the internal node for each tree that that split is
      present in.
    inputBinding:
      position: 102
      prefix: --add_to_support
  - id: calculate_support
    type:
      - 'null'
      - boolean
    doc: same as --add_to_support but divide the number by number of trees compared
      against.
    inputBinding:
      position: 102
      prefix: --calculate_support
  - id: compare
    type:
      - 'null'
      - float
    doc: output conflicting splits where at least one branch support the conflict
      with more than given support, e.g. -c 0.7.
    inputBinding:
      position: 102
      prefix: --compare
  - id: database
    type:
      - 'null'
      - File
    doc: give a second file of trees to compare against instead of comparing within
      the ordinary input.
    inputBinding:
      position: 102
      prefix: --database
  - id: decisiveness
    type:
      - 'null'
      - string
    doc: calculates proportion of random trees for which given gene sampling is decisive
      and the mean proportion of branches that are distinguished. The genes for each
      taxon are given as a comma (,) separated string, the genes for different taxon
      are separated by a bar (|).
    inputBinding:
      position: 102
      prefix: --decisiveness
  - id: file
    type:
      - 'null'
      - File
    doc: give file name for trees, or decisiveness, e.g. -f file.tree.
    inputBinding:
      position: 102
      prefix: --file
  - id: format
    type:
      - 'null'
      - string
    doc: give format of input, e.g. --format nexus. A separate file format can be
      given for the database file after a ',', e.g. --format newick,nexus.
    inputBinding:
      position: 102
      prefix: --format
  - id: html
    type:
      - 'null'
      - boolean
    doc: give output as tree in html (svg) format with conflicting tips coloured green
      and red when doing --compare.
    inputBinding:
      position: 102
      prefix: --html
  - id: iterations
    type:
      - 'null'
      - int
    doc: give numbers of iterations to do when calculating decisiveness, e.g. -i 1000.
    inputBinding:
      position: 102
      prefix: --iterations
  - id: non_shared_tips
    type:
      - 'null'
      - boolean
    doc: print tip names not present in the other tree.
    inputBinding:
      position: 102
      prefix: --non_shared_tips
  - id: output_format
    type:
      - 'null'
      - string
    doc: give tree format for output, nexus (nex or x for short) or newick (new or
      w for short), e.g --output x. (default w).
    inputBinding:
      position: 102
      prefix: --output
  - id: robinson_foulds
    type:
      - 'null'
      - boolean
    doc: compute Robinson-Foulds metric between trees.
    inputBinding:
      position: 102
      prefix: --robinson_foulds
  - id: rooted
    type:
      - 'null'
      - boolean
    doc: treat trees as rooted for --add_to_support and --calculate_support.
    inputBinding:
      position: 102
      prefix: --rooted
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: get additional output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylommand:1.1.0--hc5cd53e_2
stdout: phylommand_contree.out
