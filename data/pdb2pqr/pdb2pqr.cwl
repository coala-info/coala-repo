cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdb2pqr
label: pdb2pqr
doc: "The provided text does not contain help information for pdb2pqr; it contains
  system error messages related to a container runtime (Singularity/Docker) failing
  due to insufficient disk space.\n\nTool homepage: https://github.com/Electrostatics/pdb2pqr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pdb2pqr:v2.1.1dfsg-5-deb_cv1
stdout: pdb2pqr.out
