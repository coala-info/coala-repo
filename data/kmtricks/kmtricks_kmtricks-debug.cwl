cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks
label: kmtricks_kmtricks-debug
doc: "A tool suite for efficient k-mer counting and analysis. (Note: The provided
  help text contains only container runtime error logs and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
stdout: kmtricks_kmtricks-debug.out
