cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree-puzzle
label: tree-puzzle
doc: "Maximum likelihood analysis of phylogenies (Note: The provided text is a system
  error log and does not contain help documentation. No arguments could be extracted
  from the input.)\n\nTool homepage: https://github.com/jieyilong/tree-of-thought-puzzle-solver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tree-puzzle:v5.2-11-deb_cv1
stdout: tree-puzzle.out
