cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio
doc: "The provided text does not contain help information or usage instructions for
  the 'bio' tool. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/ialbert/bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio.out
