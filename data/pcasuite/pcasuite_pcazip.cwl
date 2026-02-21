cwlVersion: v1.2
class: CommandLineTool
baseCommand: pcazip
label: pcasuite_pcazip
doc: "Compresses amber format trajectory files using Principal Component Analysis
  (PCA).\n\nTool homepage: https://mmb.irbbarcelona.org/gitlab/andrio/pcasuite"
inputs:
  - id: gaussian_rmsd
    type:
      - 'null'
      - boolean
    doc: Use a gaussian RMSd for fitting
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type: File
    doc: amber format trajectory input file
    inputBinding:
      position: 101
      prefix: -i
  - id: mask_file
    type:
      - 'null'
      - File
    doc: pdb format mask file - only atoms in this file will be included in the compression.
      Atom numbers (2nd field) must be correct!
    inputBinding:
      position: 101
      prefix: --mask
  - id: num_atoms
    type: int
    doc: number of atoms in a snapshot
    inputBinding:
      position: 101
      prefix: -n
  - id: num_eigenvectors
    type:
      - 'null'
      - int
    doc: Include nev eigenvectors.
    inputBinding:
      position: 101
      prefix: -e
  - id: ptraj_mask
    type:
      - 'null'
      - string
    doc: ptraj-like format mask
    inputBinding:
      position: 101
      prefix: -M
  - id: quality
    type:
      - 'null'
      - int
    doc: Include enough eigenvectors to capture qual% (1<=qual<=99) of the total variance
    default: 90
    inputBinding:
      position: 101
      prefix: -q
  - id: use_pdb
    type:
      - 'null'
      - boolean
    doc: Use a PDB file for atom number and name extraction
    inputBinding:
      position: 101
      prefix: --pdb
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose diagnostics
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: compressed output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pcasuite:1.0.0--h7baada4_6
