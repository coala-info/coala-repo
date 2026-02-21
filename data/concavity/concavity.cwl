cwlVersion: v1.2
class: CommandLineTool
baseCommand: concavity
label: concavity
doc: "Predict protein ligand binding sites from structure and conservation.\n\nTool
  homepage: https://github.com/mlichter2/concavity"
inputs:
  - id: pdb_file
    type: File
    doc: Input PDB file
    inputBinding:
      position: 1
outputs:
  - id: output_name
    type: File
    doc: Base name for output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/concavity:v0.1dfsg.1-4-deb_cv1
