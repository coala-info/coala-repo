cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-pysam
label: python3-pysam
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/fetch process using Apptainer/Singularity.\n
  \nTool homepage: https://github.com/jaqx008/Pysam-installation-error"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-pysam:v0.10.0ds-2-deb_cv1
stdout: python3-pysam.out
