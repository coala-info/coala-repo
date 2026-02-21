cwlVersion: v1.2
class: CommandLineTool
baseCommand: visionegg
label: visionegg
doc: "The provided text does not contain help information for the visionegg tool;
  it is an error log from a container runtime (Apptainer/Singularity) failing to fetch
  the visionegg image.\n\nTool homepage: https://github.com/visionegg/visionegg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/visionegg:v1.2.1-2-deb-py2_cv1
stdout: visionegg.out
