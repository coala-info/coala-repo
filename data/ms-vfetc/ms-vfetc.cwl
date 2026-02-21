cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms-vfetc
label: ms-vfetc
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or a description for the tool 'ms-vfetc'.\n
  \nTool homepage: https://github.com/leidenuniv-lacdr-abs/ms-vfetc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ms-vfetc:phenomenal-v0.6_cv1.1.27
stdout: ms-vfetc.out
