cwlVersion: v1.2
class: CommandLineTool
baseCommand: matplotlib-venn
label: matplotlib-venn
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull a Docker image due to insufficient disk space.\n\nTool homepage: https://github.com/konstantint/matplotlib-venn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/matplotlib-venn:v0.11.5-5-deb-py3_cv1
stdout: matplotlib-venn.out
