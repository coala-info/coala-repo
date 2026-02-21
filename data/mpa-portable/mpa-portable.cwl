cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpa-portable
label: mpa-portable
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/compomics/meta-proteome-analyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpa-portable:2.0.0--0
stdout: mpa-portable.out
