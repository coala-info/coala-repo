cwlVersion: v1.2
class: CommandLineTool
baseCommand: kegalign-full_diagonal_partition.py
label: kegalign-full_diagonal_partition.py
doc: "A tool for diagonal partitioning within the KEGAlign suite. (Note: The provided
  help text contains only container runtime error messages and does not list specific
  arguments or usage instructions.)\n\nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
stdout: kegalign-full_diagonal_partition.py.out
