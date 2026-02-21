cwlVersion: v1.2
class: CommandLineTool
baseCommand: ripser
label: bio-ripser
doc: "A lean C++ code for the computation of Vietoris–Rips persistence barcodes.\n
  \nTool homepage: https://ripser.org"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file containing a distance matrix or point cloud.
    inputBinding:
      position: 1
  - id: dim
    type:
      - 'null'
      - int
    doc: Compute homology up to dimension <k>.
    inputBinding:
      position: 102
      prefix: --dim
  - id: format
    type:
      - 'null'
      - string
    doc: Input file format (lower-distance, upper-distance, distance, point-cloud,
      sparse, dipha, ripser).
    inputBinding:
      position: 102
      prefix: --format
  - id: representative_cycles
    type:
      - 'null'
      - boolean
    doc: Compute representative cycles for the persistent homology classes.
    inputBinding:
      position: 102
      prefix: --representative-cycles
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: Use a sparse representation of the filtration.
    inputBinding:
      position: 102
      prefix: --sparse
  - id: threshold
    type:
      - 'null'
      - float
    doc: Compute homology up to filtration value <t>.
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-ripser:1.2.1--h9948957_0
stdout: bio-ripser.out
