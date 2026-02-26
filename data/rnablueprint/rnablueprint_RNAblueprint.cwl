cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnablueprint_RNAblueprint
label: rnablueprint_RNAblueprint
doc: "Reads RNA secondary structures in dot-bracket notation as well as sequence constraints
  in IUPAC code and fairly samples RNA sequences compatible to both inputs\n\nTool
  homepage: https://github.com/ViennaRNA/RNAblueprint"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: be verbose for debugging
    inputBinding:
      position: 101
      prefix: --debug
  - id: graphml_file
    type:
      - 'null'
      - string
    doc: write a GraphML file representing the dependency graph to the given 
      filename
    inputBinding:
      position: 101
      prefix: --graphml
  - id: input_file
    type: string
    doc: 'input file which contains the structures, sequence constraints and the start
      sequence. structures: secondary structures in dot-bracket notation. one structure
      per input line. sequence constraints: Permanent sequence constraints in IUPAC
      notation [ACGTUWSMKRYBDHVN ] (optional). start sequence: A initial RNA sequence
      to start the sampling from [ACGU] (optional)'
    inputBinding:
      position: 101
      prefix: --in
  - id: mode
    type:
      - 'null'
      - string
    doc: 'mode for sequence generation. sample: stochastic sampling of all positions
      (default). sample-clocal: Only sample one connected component at a time starting
      from an initial sequence. sample-plocal: Sample only single paths starting from
      an initial sequence. clocal-neighbors: Only find neighboring sequences to the
      initial start sequence by sampling one connected component only. plocal-neighbors:
      Only find neighboring sequences to the initial start sequence by sampling one
      path only.'
    default: sample
    inputBinding:
      position: 101
      prefix: --mode
  - id: num_designs
    type:
      - 'null'
      - string
    doc: number of designs
    default: 10
    inputBinding:
      position: 101
      prefix: --num
  - id: seed
    type:
      - 'null'
      - string
    doc: random number generator seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file for writing the sequences
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnablueprint:1.3.3--py311pl5321h6accb3f_0
