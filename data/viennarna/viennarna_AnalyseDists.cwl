cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AnalyseDists
label: viennarna_AnalyseDists
doc: |-
  Analyse a distance matrix. Reads a distance matrix (lower triangle) from standard input and writes a split decomposition and a cluster analysis (Ward and neighbour joining) of it.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: distance_matrix
    type: File
    doc: Distance matrix (lower triangle), as written by RNAdistance -Xm. The line before the matrix has
      the form "> Y x [comments]".
  - id: methods
    type:
      - 'null'
      - string
    doc: 'Analysis methods to use: any of s (split decomposition), w (cluster analysis with Ward''s method,
      writes wards.ps) and n (neighbour joining, writes nj.ps), for example "sw".'
    inputBinding:
      position: 1
      prefix: -X
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.distance_matrix.path)
stdout: AnalyseDists.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
