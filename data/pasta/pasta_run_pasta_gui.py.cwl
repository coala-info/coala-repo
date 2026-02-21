cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_pasta_gui.py
label: pasta_run_pasta_gui.py
doc: "Main script for PASTA GUI on Windows/Mac/Linux\n\nTool homepage: https://github.com/smirarab/pasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pasta:1.9.3--py312hccd54bf_0
stdout: pasta_run_pasta_gui.py.out
