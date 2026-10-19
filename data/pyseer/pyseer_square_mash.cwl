cwlVersion: v1.2
class: CommandLineTool
baseCommand: square_mash
label: pyseer_square_mash
doc: "Make a square matrix out of a mash stream.\n\nTool homepage: https://github.com/mgalardini/pyseer"
inputs:
  - id: mash_table
    type: File
    doc: Mash distance table (long format) read from standard input.
  - id: classic
    type:
      - 'null'
      - boolean
    doc: Output table in a format suitable for R_mds.pl.
    inputBinding:
      position: 1
      prefix: --classic
outputs:
  - id: square_matrix
    type: stdout
    doc: Square distance matrix
stdin: $(inputs.mash_table.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
stdout: pyseer_square_mash.out
