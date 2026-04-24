cwlVersion: v1.2
class: CommandLineTool
baseCommand: clearcut
label: clearcut
doc: "Compute tree by supplying distance matrix via stdin\n\nTool homepage: https://github.com/DavidJBianco/Clearcut"
inputs:
  - id: alignment
    type:
      - 'null'
      - boolean
    doc: Input file is a set of aligned sequences.
    inputBinding:
      position: 101
      prefix: --alignment
  - id: distance
    type:
      - 'null'
      - boolean
    doc: Input file is a distance matrix.
    inputBinding:
      position: 101
      prefix: --distance
  - id: dna
    type:
      - 'null'
      - boolean
    doc: Input alignment are DNA sequences.
    inputBinding:
      position: 101
      prefix: --DNA
  - id: expblen
    type:
      - 'null'
      - boolean
    doc: Exponential notation for branch lengths.
    inputBinding:
      position: 101
      prefix: --expblen
  - id: expdist
    type:
      - 'null'
      - boolean
    doc: Exponential notation in distance output.
    inputBinding:
      position: 101
      prefix: --expdist
  - id: infilename
    type: File
    doc: Input file name
    inputBinding:
      position: 101
      prefix: --in
  - id: jukes
    type:
      - 'null'
      - boolean
    doc: Use Jukes-Cantor correction for computing distance matrix.
    inputBinding:
      position: 101
      prefix: --jukes
  - id: kimura
    type:
      - 'null'
      - boolean
    doc: Use Kimura correction for distance matrix.
    inputBinding:
      position: 101
      prefix: --kimura
  - id: neighbor
    type:
      - 'null'
      - boolean
    doc: Use traditional Neighbor-Joining algorithm.
    inputBinding:
      position: 101
      prefix: --neighbor
  - id: norandom
    type:
      - 'null'
      - boolean
    doc: Attempt joins deterministically.
    inputBinding:
      position: 101
      prefix: --norandom
  - id: ntrees
    type:
      - 'null'
      - int
    doc: Output n trees.
    inputBinding:
      position: 101
      prefix: --ntrees
  - id: protein
    type:
      - 'null'
      - boolean
    doc: Input alignment are protein sequences.
    inputBinding:
      position: 101
      prefix: --protein
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silent operation.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - string
    doc: Explicitly set the PRNG seed to a specific value.
    inputBinding:
      position: 101
      prefix: --seed
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: Randomly shuffle the distance matrix.
    inputBinding:
      position: 101
      prefix: --shuffle
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: Read input from STDIN.
    inputBinding:
      position: 101
      prefix: --stdin
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output tree to STDOUT.
    inputBinding:
      position: 101
      prefix: --stdout
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outfilename
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.outfilename)
  - id: matrixout
    type:
      - 'null'
      - File
    doc: Output distance matrix to specified file.
    outputBinding:
      glob: $(inputs.matrixout)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clearcut:v1.0.9-3-deb_cv1
