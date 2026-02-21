cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchlib
label: sketchlib
doc: "The provided text does not contain help information or usage instructions; it
  contains system logs and a fatal error message from a container runtime (Apptainer/Singularity)
  attempting to fetch the tool image.\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
stdout: sketchlib.out
