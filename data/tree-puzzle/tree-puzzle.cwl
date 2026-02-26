cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree-puzzle
label: tree-puzzle
doc: "Tree-Puzzle is a program for phylogenetic inference.\n\nTool homepage: https://github.com/jieyilong/tree-of-thought-puzzle-solver"
inputs:
  - id: sequence_file
    type: File
    doc: File name for the sequence data
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tree-puzzle:v5.2-11-deb_cv1
stdout: tree-puzzle.out
