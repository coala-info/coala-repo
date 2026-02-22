cwlVersion: v1.2
class: CommandLineTool
baseCommand: biotools
label: biotools
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a Singularity/Apptainer
  container execution failure due to insufficient disk space.\n\nTool homepage: https://github.com/jdidion/biotools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biotools:v1.2.12-3-deb-py3_cv1
stdout: biotools.out
