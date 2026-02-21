cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngmaster
label: ngmaster
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/MDU-PHL/ngmaster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngmaster:1.1.1--pyhdfd78af_0
stdout: ngmaster.out
