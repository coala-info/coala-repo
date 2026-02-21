cwlVersion: v1.2
class: CommandLineTool
baseCommand: bctools_remove_tail.py
label: bctools_remove_tail.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a Singularity/Apptainer build process that failed
  due to insufficient disk space.\n\nTool homepage: https://github.com/dmaticzka/bctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
stdout: bctools_remove_tail.py.out
