cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini
label: ppanini
doc: "The provided text does not contain help information for the tool 'ppanini'.
  It appears to be a log of a failed container build/fetch process using Apptainer/Singularity.\n
  \nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
stdout: ppanini.out
