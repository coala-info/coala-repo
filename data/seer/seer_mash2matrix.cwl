cwlVersion: v1.2
class: CommandLineTool
baseCommand: mash2matrix
label: seer_mash2matrix
doc: "Uses mash (http://mash.readthedocs.io/) to create all pairwise distances between samples. Input is the mash dist output; prints a distance matrix (csv).\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: matrix_in
    type: File
    doc: "Output of mash dist (all against all, same order as the .pheno file)"
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_mash2matrix.out
