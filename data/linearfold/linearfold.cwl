cwlVersion: v1.2
class: CommandLineTool
baseCommand: linearfold
label: linearfold
doc: "Predict RNA secondary structure using the LinearFold algorithm.\n\nTool homepage:
  https://github.com/LinearFold/LinearFold"
inputs:
  - id: beamsize
    type:
      - 'null'
      - int
    doc: set beam size
    default: 100
    inputBinding:
      position: 101
      prefix: --beamsize
  - id: constraints
    type:
      - 'null'
      - boolean
    doc: print out energy of a given structure
    default: false
    inputBinding:
      position: 101
      prefix: --constraints
  - id: dangles
    type:
      - 'null'
      - int
    doc: the way to treat `dangling end' energies for bases adjacent to helices 
      in free ends and multi-loops (only supporting `0' or `2', default=`2')
    default: 2
    inputBinding:
      position: 101
      prefix: --dangles
  - id: delta
    type:
      - 'null'
      - float
    doc: compute Zuker suboptimal structures with scores or energies(-V, 
      kcal/mol) in a centain range of the optimum
    default: 5.0
    inputBinding:
      position: 101
      prefix: --delta
  - id: eval
    type:
      - 'null'
      - boolean
    doc: print out energy of a given structure
    default: false
    inputBinding:
      position: 101
      prefix: --eval
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: input is in fasta format
    default: false
    inputBinding:
      position: 101
      prefix: --fasta
  - id: shape
    type:
      - 'null'
      - File
    doc: 'specify a file name that contains SHAPE reactivity data (DEFAULT: not use
      SHAPE data)'
    default: ''
    inputBinding:
      position: 101
      prefix: --shape
  - id: sharpturn
    type:
      - 'null'
      - boolean
    doc: enable sharp turn in prediction
    default: false
    inputBinding:
      position: 101
      prefix: --sharpturn
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print out energy of each loop in the structure
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
  - id: vienna
    type:
      - 'null'
      - boolean
    doc: use vienna parameters
    default: false
    inputBinding:
      position: 101
      prefix: --Vienna
  - id: zuker
    type:
      - 'null'
      - boolean
    doc: output Zuker suboptimal structures
    default: false
    inputBinding:
      position: 101
      prefix: --zuker
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linearfold:1.0.1.dev20220829--h9948957_2
stdout: linearfold.out
