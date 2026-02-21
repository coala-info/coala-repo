cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyham_run_hog_queries.py
label: pyham_run_hog_queries.py
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container execution/build process. No arguments could be extracted.\n
  \nTool homepage: https://github.com/DessimozLab/pyham"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyham:1.1.11--pyh7cba7a3_0
stdout: pyham_run_hog_queries.py.out
