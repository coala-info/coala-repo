cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree-puzzle_run_expr.py
label: tree-puzzle_run_expr.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container build
  failure (no space left on device).\n\nTool homepage: https://github.com/jieyilong/tree-of-thought-puzzle-solver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tree-puzzle:v5.2-11-deb_cv1
stdout: tree-puzzle_run_expr.py.out
