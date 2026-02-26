cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncoils
label: ncoils
doc: A program that predicts coiled-coil secondary structure in proteins.
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input sequence file (reads from stdin if not provided)
    inputBinding:
      position: 1
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: Output in FASTA format
    inputBinding:
      position: 102
      prefix: -f
  - id: use_mtk_matrix
    type:
      - 'null'
      - boolean
    doc: Use the MTK matrix (default is MTIDK)
    inputBinding:
      position: 102
      prefix: -m
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -v
  - id: weight_hydrophobics
    type:
      - 'null'
      - boolean
    doc: Weight hydrophobics at positions 'a' and 'd' the same as other 
      positions
    inputBinding:
      position: 102
      prefix: -w
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (default is 21)
    inputBinding:
      position: 102
      prefix: -win
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncoils:v2002-7-deb_cv1
stdout: ncoils.out
