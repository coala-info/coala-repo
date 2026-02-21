cwlVersion: v1.2
class: CommandLineTool
baseCommand: maffilter
label: maffilter
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Singularity/Apptainer) failing to
  build an image due to insufficient disk space.\n\nTool homepage: https://github.com/jydu/maffilter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maffilter:v1.3.1dfsg-1b1-deb_cv1
stdout: maffilter.out
