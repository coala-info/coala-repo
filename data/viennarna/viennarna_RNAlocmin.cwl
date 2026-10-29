cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAlocmin
label: viennarna_RNAlocmin
doc: |-
  Calculate local minima from structures via gradient walks. Reads structures (for example RNAsubopt output) from standard input.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: input
    type: File
    doc: Structures to start the gradient walks from, for example RNAsubopt output.
  - id: seq
    type:
      - 'null'
      - File
    doc: Sequence file in FASTA format. If the sequence is the first line of the input file, this is not
      needed
    inputBinding:
      position: 10
      prefix: --seq=
      separate: false
  - id: previous
    type:
      - 'null'
      - File
    doc: Previously found LM (output from RNAlocmin or barriers), if specified does not need --seq option
    inputBinding:
      position: 10
      prefix: --previous=
      separate: false
  - id: move
    type:
      - 'null'
      - string
    doc: 'Move set: I ==> insertion & deletion of base pairs S ==> I&D& switch of base pairs (possible
      values="I", "S" default=`I'')'
    inputBinding:
      position: 10
      prefix: --move=
      separate: false
  - id: min_num
    type:
      - 'null'
      - int
    doc: Maximal number of local minima returned (0 == unlimited)
    inputBinding:
      position: 10
      prefix: --min-num=
      separate: false
  - id: find_num
    type:
      - 'null'
      - int
    doc: Maximal number of local minima found (default = unlimited - crawl through whole input file)
    inputBinding:
      position: 10
      prefix: --find-num=
      separate: false
  - id: verbose_lvl
    type:
      - 'null'
      - int
    doc: 'Level of verbosity (0 = nothing, 4 = full) WARNING: higher verbose levels increase the computation
      time'
    inputBinding:
      position: 10
      prefix: --verbose-lvl=
      separate: false
  - id: depth
    type:
      - 'null'
      - int
    doc: Depth of findpath search (higher value increases running time linearly)
    inputBinding:
      position: 10
      prefix: --depth=
      separate: false
  - id: minh
    type:
      - 'null'
      - float
    doc: Print only minima with energy barrier greater than this
    inputBinding:
      position: 10
      prefix: --minh=
      separate: false
  - id: walk
    type:
      - 'null'
      - string
    doc: Walking method used D ==> gradient descent F ==> use first found lower energy structure R ==>
      use random lower energy structure (does not work with --noLP and -m S options) (possible values="D",
      "F", "R" default=`D')
    inputBinding:
      position: 10
      prefix: --walk=
      separate: false
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: Work only with canonical RNA structures (w/o isolated base pairs, cannot be combined with ranodm
      walk (-w R option) and shift move set (-m S))
    inputBinding:
      position: 10
      prefix: --noLP
  - id: param_file
    type:
      - 'null'
      - string
    doc: Read energy parameters from paramfile, instead of using the default parameter set
    inputBinding:
      position: 10
      prefix: --paramFile=
      separate: false
  - id: dangles
    type:
      - 'null'
      - int
    doc: How to treat "dangling end" energies for bases adjacent to helices in free ends and multi-loops
    inputBinding:
      position: 10
      prefix: --dangles=
      separate: false
  - id: pseudoknots
    type:
      - 'null'
      - boolean
    doc: Allow for pseudoknots according to "gfold" model - H, K, L, and M types (genus one) of pseudoknots
      are allowed (increases computation time greatly), cannot be combined with shift move set (-m S)
    inputBinding:
      position: 10
      prefix: --pseudoknots
  - id: just_read
    type:
      - 'null'
      - boolean
    doc: Do not expect input from stdin, just do postprocessing.
    inputBinding:
      position: 10
      prefix: --just-read
  - id: neighborhood
    type:
      - 'null'
      - boolean
    doc: Use the Neighborhood routines to perform gradient descend. Cannot be combined with shift move
      set (-m S) and pseudoknots (-k). Test option.
    inputBinding:
      position: 10
      prefix: --neighborhood
  - id: degeneracy_off
    type:
      - 'null'
      - boolean
    doc: Do not deal with degeneracy, select the lexicographically first from the same energy neighbors.
    inputBinding:
      position: 10
      prefix: --degeneracy-off
  - id: just_output
    type:
      - 'null'
      - boolean
    doc: Do not store the minima and optimize, just compute directly minima and output them. Output file
      can contain duplicates.
    inputBinding:
      position: 10
      prefix: --just-output
  - id: bartree
    type:
      - 'null'
      - boolean
    doc: Generate an approximate barrier tree.
    inputBinding:
      position: 10
      prefix: --bartree
  - id: barr_name
    type:
      - 'null'
      - string
    doc: Name of barrier tree output file, switches on -b flag.
    inputBinding:
      position: 10
      prefix: --barr-name=
      separate: false
  - id: barrier_file
    type:
      - 'null'
      - string
    doc: File for saddle heights between LM (simulates the output format of barriers program)
    inputBinding:
      position: 10
      prefix: --barrier-file=
      separate: false
  - id: rates
    type:
      - 'null'
      - boolean
    doc: Create rates for treekin
    inputBinding:
      position: 10
      prefix: --rates
  - id: rates_file
    type:
      - 'null'
      - string
    doc: File where to write rates, switches on -r flag
    inputBinding:
      position: 10
      prefix: --rates-file=
      separate: false
  - id: temp
    type:
      - 'null'
      - float
    doc: Temperature in Celsius (only for rates)
    inputBinding:
      position: 10
      prefix: --temp=
      separate: false
  - id: flood_portion
    type:
      - 'null'
      - float
    doc: Fraction of minima to flood (floods first minima with low number of inwalking sample structures)
      (0.0 -> no flood; 1.0 -> try to flood all) Usable only with -r or -b options.
    inputBinding:
      position: 10
      prefix: --floodPortion=
      separate: false
  - id: flood_max
    type:
      - 'null'
      - int
    doc: Flood cap - how many structures to flood in one basin
    inputBinding:
      position: 10
      prefix: --floodMax=
      separate: false
  - id: e_range
    type:
      - 'null'
      - float
    doc: Report only LM, which energy is in range <MFE (or lowest found LM), MFE+eRange> in kcal/mol.
    inputBinding:
      position: 10
      prefix: --eRange=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: ps_files
    type:
      type: array
      items: File
    doc: PostScript plots written by the program (structure plots, dot plots)
    outputBinding:
      glob:
        - '*.ps'
  - id: barrier_tree
    type:
      - 'null'
      - File
    doc: Barrier tree written with --barr-name
    outputBinding:
      glob: $(inputs.barr_name)
  - id: barrier_table
    type:
      - 'null'
      - File
    doc: Saddle heights written with --barrier-file
    outputBinding:
      glob: $(inputs.barrier_file)
  - id: rates
    type:
      - 'null'
      - File
    doc: Rates for treekin written with --rates-file
    outputBinding:
      glob: $(inputs.rates_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.input.path)
stdout: RNAlocmin.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
