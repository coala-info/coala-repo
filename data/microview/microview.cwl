cwlVersion: v1.2
class: CommandLineTool
baseCommand: microview
label: microview
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or command-line arguments for the microview
  tool.\n\nTool homepage: https://github.com/jvfe/microview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microview:0.11.0--py312h031d066_0
stdout: microview.out
