cwlVersion: v1.2
class: CommandLineTool
baseCommand: quasildr_run_graphdr.py
label: quasildr_run_graphdr.py
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains log messages regarding a failed container build/execution.\n
  \nTool homepage: https://github.com/jzthree/quasildr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasildr:0.2.2--pyhdfd78af_0
stdout: quasildr_run_graphdr.py.out
