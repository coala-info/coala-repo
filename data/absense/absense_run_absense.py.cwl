cwlVersion: v1.2
class: CommandLineTool
baseCommand: absense_run_absense.py
label: absense_run_absense.py
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build or run the container image due to insufficient disk space.\n\n
  Tool homepage: https://github.com/caraweisman/abSENSE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0
stdout: absense_run_absense.py.out
