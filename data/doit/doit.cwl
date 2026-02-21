cwlVersion: v1.2
class: CommandLineTool
baseCommand: doit
label: doit
doc: "The provided text does not contain help information for the tool 'doit'. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the container image due to lack of disk space.\n
  \nTool homepage: https://github.com/sloria/doitlive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/doit:0.29.0--py27_0
stdout: doit.out
