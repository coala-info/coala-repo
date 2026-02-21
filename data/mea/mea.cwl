cwlVersion: v1.2
class: CommandLineTool
baseCommand: mea
label: mea
doc: "The provided text does not contain help information for the tool 'mea'. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/mea/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mea:0.6.4--h9948957_10
stdout: mea.out
