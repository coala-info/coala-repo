cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbsuite
label: pbsuite
doc: "The provided text does not contain help documentation for pbsuite; it contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/dbrowneup/PBSuite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbsuite:v15.8.24dfsg-3-deb_cv1
stdout: pbsuite.out
