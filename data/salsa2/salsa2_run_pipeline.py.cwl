cwlVersion: v1.2
class: CommandLineTool
baseCommand: salsa2_run_pipeline.py
label: salsa2_run_pipeline.py
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a container execution failure.\n\nTool homepage: https://github.com/marbl/SALSA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salsa2:2.3--py27h16ec135_1
stdout: salsa2_run_pipeline.py.out
