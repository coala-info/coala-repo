cwlVersion: v1.2
class: CommandLineTool
baseCommand: heterotachy.py
label: phylofisher_heterotachy.py
doc: "Removes the most heterotachous sites within a phylogenomic supermatrix in a
  stepwise fashion, leading to a user defined set of new matrices with these sites
  removed.\n\nTool homepage: https://github.com/TheBrownLab/PhyloFisher"
inputs:
  - id: in_format
    type:
      - 'null'
      - string
    doc: Input format of matrix
    default: fasta
    inputBinding:
      position: 101
      prefix: --in_format
  - id: matrix
    type: File
    doc: Path to supermatrix
    inputBinding:
      position: 101
      prefix: --matrix
  - id: out_format
    type:
      - 'null'
      - string
    doc: Desired format of the output steps.
    default: fasta
    inputBinding:
      position: 101
      prefix: --out_format
  - id: step_size
    type:
      - 'null'
      - int
    doc: Size of removal step (i.e., 1000 sites removed) to exhaustion
    default: 3000
    inputBinding:
      position: 101
      prefix: --step_size
  - id: tree
    type: File
    doc: Path to tree
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to user-defined output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
