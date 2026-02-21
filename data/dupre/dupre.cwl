cwlVersion: v1.2
class: CommandLineTool
baseCommand: dupre
label: dupre
doc: "The provided text does not contain a description or usage information for the
  tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to lack of disk space.\n\n
  Tool homepage: https://bitbucket.org/genomeinformatics/dupre/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dupre:0.1--py35_0
stdout: dupre.out
