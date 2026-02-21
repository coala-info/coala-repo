cwlVersion: v1.2
class: CommandLineTool
baseCommand: cycle_finder
label: cycle_finder
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or extract the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/rkajitani/cycle_finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cycle:v0.3.1-14-deb_cv1
stdout: cycle_finder.out
