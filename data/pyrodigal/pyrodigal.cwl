cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrodigal
label: pyrodigal
doc: "The provided text does not contain help information for the tool 'pyrodigal'.
  It appears to be a log of a failed container build/fetch process using Apptainer/Singularity.\n
  \nTool homepage: https://github.com/althonos/pyrodigal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrodigal:3.7.0--py311haab0aaa_0
stdout: pyrodigal.out
