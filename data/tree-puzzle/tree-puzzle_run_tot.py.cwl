cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree-puzzle_run_tot.py
label: tree-puzzle_run_tot.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a log of a failed container build/execution due to insufficient
  disk space.\n\nTool homepage: https://github.com/jieyilong/tree-of-thought-puzzle-solver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tree-puzzle:v5.2-11-deb_cv1
stdout: tree-puzzle_run_tot.py.out
