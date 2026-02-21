cwlVersion: v1.2
class: CommandLineTool
baseCommand: asgal_detectevents.py
label: asgal_detectevents.py
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://asgal.algolab.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asgal:1.1.8--h5ca1c30_2
stdout: asgal_detectevents.py.out
