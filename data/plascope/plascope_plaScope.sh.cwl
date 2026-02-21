cwlVersion: v1.2
class: CommandLineTool
baseCommand: plaScope.sh
label: plascope_plaScope.sh
doc: "The provided text does not contain help information for the tool, but appears
  to be an error log from a container runtime (Singularity/Apptainer) indicating a
  failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/GuilhemRoyer/PlaScope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plascope:1.3.1--1
stdout: plascope_plaScope.sh.out
