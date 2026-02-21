cwlVersion: v1.2
class: CommandLineTool
baseCommand: centreseq
label: centreseq
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to pull
  or build the image due to lack of disk space.\n\nTool homepage: https://github.com/bfssi-forest-dussault/centreseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centreseq:0.3.8--py_0
stdout: centreseq.out
