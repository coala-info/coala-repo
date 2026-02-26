cwlVersion: v1.2
class: CommandLineTool
baseCommand: ripser
label: ripser
doc: "Compute persistent homology\n\nTool homepage: http://ripser.org/"
inputs:
  - id: filename
    type:
      - 'null'
      - string
    doc: Input filename
    inputBinding:
      position: 1
  - id: dim
    type:
      - 'null'
      - int
    doc: Compute persistent homology up to dimension <k>
    inputBinding:
      position: 102
      prefix: --dim
  - id: format
    type:
      - 'null'
      - string
    doc: 'Use the specified file format for the input. Options are: lower-distance
      (lower triangular distance matrix; default), upper-distance (upper triangular
      distance matrix), distance (full distance matrix), point-cloud (point cloud
      in Euclidean space), dipha (distance matrix in DIPHA file format)'
    inputBinding:
      position: 102
      prefix: --format
  - id: threshold
    type:
      - 'null'
      - float
    doc: Compute Rips complexes up to diameter <t>
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ripser:1.0.1--h6bb024c_0
stdout: ripser.out
