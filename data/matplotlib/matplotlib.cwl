cwlVersion: v1.2
class: CommandLineTool
baseCommand: matplotlib
label: matplotlib
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain CLI help information or usage instructions for matplotlib.\n
  \nTool homepage: https://github.com/matplotlib/matplotlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matplotlib:3.5.1
stdout: matplotlib.out
