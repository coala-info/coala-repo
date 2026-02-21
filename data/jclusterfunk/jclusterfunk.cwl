cwlVersion: v1.2
class: CommandLineTool
baseCommand: jclusterfunk
label: jclusterfunk
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
stdout: jclusterfunk.out
