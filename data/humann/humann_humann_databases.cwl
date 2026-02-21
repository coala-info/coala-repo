cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_databases
label: humann_humann_databases
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build a container image due to insufficient disk space.\n\nTool homepage:
  http://huttenhower.sph.harvard.edu/humann"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
stdout: humann_humann_databases.out
